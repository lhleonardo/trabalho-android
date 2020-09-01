import 'package:flutter/material.dart';

class BillWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: const ListTile(
        title: Text('Nome do Membro (Apelido)'),
        leading: Icon(
          Icons.check_box
        )
      ),
    );
  }
}
