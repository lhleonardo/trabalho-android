import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabalho/models/bill.dart';
import 'package:trabalho/routes/routes.dart';

class BillListTile extends StatelessWidget {
  final Bill bill;

  const BillListTile({Key key, this.bill}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final NumberFormat _formatter =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return Card(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        title: Text(bill.title),
        trailing: Text(
          _formatter.format(bill.price),
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(Routes.billDetais, arguments: bill);
        },
      ),
    );
  }
}
