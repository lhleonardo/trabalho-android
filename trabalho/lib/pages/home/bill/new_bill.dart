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

class NewBillPage extends StatefulWidget {
  @override
  _NewBillPage createState() => _NewBillPage();
}

class _NewBillPage extends State<NewBillPage> {
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

    for (final member in _membersList) {
      _members[member.id] = false;
    }

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    _loadMembers();
  }

  Future<void> _submit(String houseId) async {
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
            Text('Nova despesa', style: Theme.of(context).textTheme.headline2)
          ]),
        ),
        Container(
            margin: const EdgeInsets.only(top: 6, left: 5, right: 5),
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 15, right: 15),
                  child: Input(
                    labelText: 'Descrição da despesa',
                    placeholder: 'Ex: Compra do Supermercado',
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _data['description'] = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 15, right: 15),
                  child: Input(
                    labelText: 'Valor total',
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _data['price'] = value;
                    },
                  ),
                ),
              ]),
            )),
        const SizedBox(height: 22),
        Container(
          height: 250,
          child: GridView.count(
            padding: const EdgeInsets.only(left: 16, right: 16),
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 14,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _categoryWidget('water', 'Água'),
              _categoryWidget('aluguel', 'Aluguel'),
              _categoryWidget('compras', 'Compras'),
              _categoryWidget('limpeza', 'Limpeza'),
              _categoryWidget('luz', 'Luz'),
              _categoryWidget('outros', 'Outros'),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Pessoas que deverão pagar',
                      style: Theme.of(context).textTheme.headline3),
                ],
              ),
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
                      value: _members[member.id],
                      onChanged: (value) {
                        setState(() {
                          _members[member.id] = value;

                          if (value) {
                            _payersCount += 1;
                          } else {
                            _payersCount -= 1;
                          }

                          if (_payersCount == 0) {
                            _payersPart = 0.0;
                          } else {
                            if (_controller.text.isEmpty) {
                              _payersPart = 0;
                            } else {
                              _payersPart = _format.parse(_controller.text) /
                                  _payersCount;
                            }
                          }
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
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Total Selecionado: $_payersCount',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Valor para cada: ${_format.format(_payersPart)}',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ],
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
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => _submit(provider.loggedMemberHouse.id),
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
