import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        title: Text('Título de Despesa'),
        trailing: Text('R\$ Valor')
      ),
    );
  }
}
