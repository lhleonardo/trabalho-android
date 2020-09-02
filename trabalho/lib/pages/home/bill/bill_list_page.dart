import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalho/components/bill_card.dart';
import 'package:trabalho/models/bill.dart';
import 'package:trabalho/providers/member_provider.dart';
import 'package:trabalho/services/bill.dart';

class BillListPage extends StatelessWidget {
  final _billService = BillService();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context);
    return Container(
      color: Theme.of(context).backgroundColor,
      width: double.infinity,
      child: StreamBuilder<List<Bill>>(
        stream: _billService.getBillsForMember(
            houseId: provider.loggedMemberHouse.id,
            memberId: provider.loggedMember.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const _NoBills();
          }

          return ListView.builder(
            itemExtent: 160.0,
            itemCount: snapshot.data.length,
            itemBuilder: (_, index) => BillCard(value: snapshot.data[index]),
          );
        },
      ),
    );
  }
}

class _NoBills extends StatelessWidget {
  const _NoBills({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/money.png',
            width: 100,
          ),
          Text('Nada por aqui :D',
              style: Theme.of(context).textTheme.subtitle1),
          const SizedBox(height: 8),
          Text('Suas contas estão em dia!',
              style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }
}
