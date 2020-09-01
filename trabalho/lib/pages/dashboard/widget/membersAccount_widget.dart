import 'package:flutter/material.dart';

class MemberAccountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: const ListTile(
        leading:CircleAvatar(child: Icon(Icons.person, color:Color.fromRGBO(240, 238, 238, 1)), backgroundColor:Color.fromRGBO(11, 19, 43, 1) ,),
        title: Text('Título de Despesa', style: TextStyle(
          color:Color.fromRGBO(240, 238, 238, 1),
          fontSize: 14
        )),
        trailing: Icon(Icons.check_circle, color: Colors.green, size: 22,),
      ),
    );
  }
}
