import 'package:flutter/material.dart';

class TabelHeaderCell extends StatelessWidget {
  final String text;
  const TabelHeaderCell({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                text,
              ))),
    );
  }
}
