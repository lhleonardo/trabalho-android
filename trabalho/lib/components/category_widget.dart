import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;
  final Image icon;
  final String label;

  const CategoryWidget({
    Key key,
    @required this.isSelected,
    @required this.onPressed,
    @required this.icon,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: isSelected
            ? Border.all(
                width: 3.0,
                color: Theme.of(context).accentColor,
              )
            : null,
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 10),
            Text(label, style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
      ),
    );
  }
}
