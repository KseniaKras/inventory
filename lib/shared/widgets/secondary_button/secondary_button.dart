import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final Function() onPressed;
  final String title;

  const SecondaryButton({
    super.key, 
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(120, 40),
        maximumSize: Size(double.infinity, 50),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
      ),
      child: Text(title, textDirection: TextDirection.ltr),
    ); 
  }
}
