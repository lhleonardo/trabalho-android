import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/components/member_bill.dart';
import 'package:trabalho/models/bill.dart';
import 'package:trabalho/models/member.dart';
import 'package:trabalho/providers/member_provider.dart';
import 'package:trabalho/services/bill.dart';
import 'package:trabalho/services/member.dart';
import 'package:trabalho/utils/validator_alerts.dart';

class BillDetailsPage extends StatelessWidget {
  final _memberService = MemberService();
  final _billService = BillService();

  final NumberFormat _formatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  String _choiceLabel(String key) {
    String text = '';

    switch (key) {
      case 'water':
        text = 'Água/Esgoto';
        break;
      case 'aluguel':
        text = 'Aluguel e Casa';
        break;
      case 'compras':
        text = 'Compras e Supermercado';
        break;
      case 'limpeza':
        text = 'Limpeza';
        break;
      case 'luz':
        text = 'Luz/Energia elétrica';
        break;
      default:
        text = 'Outros';
        break;
    }

    return text;
  }

  Future<void> _submit(
      BuildContext context, MemberProvider provider, Bill bill) async {
    if (bill.recipients[provider.loggedMember.id]) {
      ValidatorAlerts.showWarningMessage(
          context, 'Validação', 'Você já confirmou o pagamento desta despesa.');

      return;
    }
    final progress = ValidatorAlerts.createProgress(context);

    await progress.show();
    await _billService.markAsPaid(
        houseId: provider.loggedMemberHouse.id,
        memberId: provider.loggedMember.id,
        billId: bill.id);

    await progress.hide();

    await ValidatorAlerts.showWarningMessage(
        context, 'Sucesso!', 'Você marcou que pagou sua parte na despesa.');

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Bill bill = ModalRoute.of(context).settings.arguments as Bill;
    final double perMember = bill.price / bill.recipients.length;

    final provider = Provider.of<MemberProvider>(context, listen: false);
    final List<String> membersId =
        bill.recipients.entries.map((e) => e.key).toList();

    final isPaid = bill.recipients[provider.loggedMember.id] ?? false;

    final canPaid = bill.recipients.containsKey(provider.loggedMember.id);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      'Detalhes da despesa',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.label_outline,
                                color: Color.fromRGBO(240, 238, 238, 1),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Título da despesa',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            bill.title,
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 60,
                      color: Theme.of(context).primaryColor,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Container(
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                    'assets/icons/${bill.category}.png'),
                                height: 80,
                                width: 80,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Categoria',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    _choiceLabel(bill.category),
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Positioned(
                            right: 0,
                            top: 40,
                            child: Opacity(
                              opacity: canPaid ? 1 : 0,
                              child: Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: isPaid
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).accentColor,
                                ),
                                child: FlatButton(
                                  child: Text(
                                    isPaid ? 'Pago!' : 'Pagar',
                                    style: TextStyle(
                                      color: Theme.of(context).backgroundColor,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () =>
                                      _submit(context, provider, bill),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 50,
                      color: Theme.of(context).primaryColor,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.adjust,
                          color: Color.fromRGBO(240, 238, 238, 1),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Descrição',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      bill.description,
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.start,
                      softWrap: true,
                    ),
                    Divider(
                      height: 50,
                      color: Theme.of(context).primaryColor,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: Column(
                            children: [
                              Text(
                                'Valor',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Total: ${_formatter.format(bill.price)}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                'Individual: ${_formatter.format(perMember)}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: Column(
                            children: [
                              Text(
                                'Status',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: 4),
                              Icon(
                                isPaid
                                    ? Icons.check_circle_outline
                                    : Icons.hourglass_empty,
                                color: isPaid ? Colors.green : Colors.grey[300],
                                size: 20,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isPaid ? 'Confirmado' : 'Aguardando',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: 50,
                      color: Theme.of(context).primaryColor,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.supervised_user_circle,
                          color: Color.fromRGBO(240, 238, 238, 1),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Membros',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 40),
                      child: Column(
                        children: membersId
                            .map(
                              (memberId) => FutureBuilder<Member>(
                                future: _memberService.getById(memberId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 4, bottom: 4),
                                        child:
                                            const CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  return Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: MemberBillWidget(
                                      member: snapshot.data,
                                      payed: bill.recipients[memberId],
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
