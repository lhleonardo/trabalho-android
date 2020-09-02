import 'package:flutter/material.dart';
import 'package:trabalho/models/member.dart';

class MemberBillWidget extends StatelessWidget {
  final Member member;
  final bool payed;

  const MemberBillWidget({Key key, this.member, this.payed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(
            Icons.person,
            color: Color.fromRGBO(240, 238, 238, 1),
          ),
          backgroundColor: Color.fromRGBO(11, 19, 43, 1),
        ),
        title: Text(
          member.name,
          style: const TextStyle(
            color: Color.fromRGBO(240, 238, 238, 1),
            fontSize: 14,
          ),
        ),
        trailing: payed
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 22,
              )
            : const Icon(
                Icons.hourglass_empty,
                color: Colors.grey,
                size: 22,
              ),
      ),
    );
  }
}
