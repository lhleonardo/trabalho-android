import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/components/category_widget.dart';
import 'package:trabalho/components/input.dart';
import 'package:trabalho/models/member.dart';
import 'package:trabalho/services/bill.dart';
import 'package:trabalho/services/house.dart';
import 'package:trabalho/utils/validator_alerts.dart';
import '../../../providers/member_provider.dart';
import '../../../services/house.dart';

class HouseControllPage extends StatefulWidget {
  @override
  _HouseControllPage createState() => _HouseControllPage();
}

class _HouseControllPage extends State<HouseControllPage> {
  final Map<String, bool> _members = {};
  final HouseService _houseService = HouseService();
  final Map<String, String> _data = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  final BillService _service = BillService();

  final NumberFormat _format =
      NumberFormat.simpleCurrency(locale: 'pt_BR', decimalDigits: 2);

  List<Member> _membersList = [];
  bool _isLoading = true;
  String _selectedCategory;

  int _payersCount = 0;
  double _payersPart = 0;

  Future<void> _loadMembers() async {
    final provider = Provider.of<MemberProvider>(context, listen: false);
    _membersList =
        await _houseService.getCommomMembers(provider.loggedMemberHouse.id);

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _loadMembers();
  }

  Future<void> _submit({String houseId, String memberId}) async {
    final progress = ValidatorAlerts.createProgress(context);
    // descrição e preço preenchidos
    await progress.show();
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      if (_selectedCategory == null || _selectedCategory.isEmpty) {
        await progress.hide();
        ValidatorAlerts.showWarningMessage(
            context, 'Validação', 'Selecione a categoria da despesa');
      } else if (_payersCount == 0) {
        await progress.hide();
        ValidatorAlerts.showWarningMessage(context, 'Validação',
            'Marque pelo menos um membro que deverá pagar a despesa');
      } else {
        final recipients = _membersList
            .where((element) => _members[element.id] == true)
            .toList();

        _formKey.currentState.save();

        await _service.create(
          houseId,
          ownerId: memberId,
          category: _selectedCategory,
          description: _data['description'],
          price: _format.parse(_data['price']).toDouble(),
          recipients: recipients,
        );
        await progress.hide();

        ValidatorAlerts.showWarningMessage(
            context, 'Concluído', 'Despesa cadastrada com sucesso');
      }
    }

    _service.getBillsForMember(
        houseId: houseId,
        memberId: Provider.of<MemberProvider>(context, listen: false)
            .loggedMember
            .id);
  }

  Widget _categoryWidget(String category, String description) {
    return CategoryWidget(
      isSelected: _selectedCategory == category,
      onPressed: () => setState(() => _selectedCategory = category),
      icon: Image.asset('assets/icons/$category.png', width: 44),
      label: description,
    );
  }

  Widget _managerView(BuildContext context, MemberProvider provider) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Row(
            children: [
              const Image(
                image: AssetImage('assets/icons/RepIcon.png'),
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Nome da República',
                    style: TextStyle(
                        color: Color.fromRGBO(240, 238, 238, 1), fontSize: 14),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Criada 10/12/2017',
                    style: TextStyle(
                        color: Color.fromRGBO(240, 238, 238, 1), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 16.0, left: 20, right: 15),
          child: Row(children: <Widget>[
            Text('Controle de acesso', style: Theme.of(context).textTheme.headline2)
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(top: 3, left: 10, right: 10, bottom: 15),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Text('Escolha quem poderá controlar a república',
                style: TextStyle(
                  color: Color.fromRGBO(240, 238, 238, 1), fontSize: 12),)
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 3, left: 10, right: 10),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Text('Marque os representantes', 
              style: TextStyle(
                  color: Color.fromRGBO(240, 238, 238, 1), fontSize: 18),)
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            children: _membersList
                .map(
                  (member) => Card(
                    color: Theme.of(context).primaryColor,
                    child: CheckboxListTile(
                      key: Key(member.id),
                      title: Text(member.nickname),
                      value: member.isManager,
                      onChanged: (value) {
                        setState(() {
                          
                        });
                      },
                      activeColor: Colors.green,
                      checkColor: Theme.of(context).backgroundColor,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Theme.of(context).accentColor,
                    child: const Text(
                      'Atualizar Permissões',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => _submit(
                        houseId: provider.loggedMemberHouse.id,
                        memberId: provider.loggedMember.id),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _managerView(context, Provider.of<MemberProvider>(context)),
          ),
        ),
      ),
    );
  }
}
