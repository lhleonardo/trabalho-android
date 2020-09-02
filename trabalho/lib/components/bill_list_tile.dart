import 'package:flutter/material.dart';

class BillListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: const ListTile(
        title: Text('Título de Despesa'),
        trailing: Text('R\$ Valor'),
      ),
    );
  }
}
