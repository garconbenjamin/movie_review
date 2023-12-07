import 'package:flutter/material.dart';

class TabelCell extends StatelessWidget {
  const TabelCell({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: child,
    );
  }
}
