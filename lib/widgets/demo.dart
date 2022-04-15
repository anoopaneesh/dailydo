import 'package:flutter/material.dart';

class DemoWidget extends StatelessWidget {
  final void Function()? onTap;
  const DemoWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        key: ValueKey('hello'),
        child: Text('hello'),
        onTap: onTap,
      ),
    );
  }
}
