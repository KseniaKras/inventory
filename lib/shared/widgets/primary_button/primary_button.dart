import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final Function() onPressed;
  final String title;
  final bool isLoading;

  const PrimaryButton({
    super.key, 
    required this.onPressed,
    required this.title,
    this.isLoading = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(120, 40),
        maximumSize: Size(double.infinity, 50),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
      ),
      child: widget.isLoading == true
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          )
        : Text(widget.title, textDirection: TextDirection.ltr),
    ); 
  }
}
