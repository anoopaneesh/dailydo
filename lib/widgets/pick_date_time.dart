import 'package:flutter/material.dart';

class PickDateTime extends StatelessWidget {
  final String currentDate;
  final void Function()? onPressed;
  const PickDateTime({Key? key, required this.currentDate,required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(2)),
        child: Text(
          currentDate,
          style: const TextStyle(color: Color.fromARGB(255, 81, 79, 79)),
        ),
      ),
    );
  }
}
