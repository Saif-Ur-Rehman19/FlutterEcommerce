import 'package:ecommerce/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  const CustomButton({super.key, required this.text, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        
        minimumSize: const Size(double.infinity, 50),
        
        //foregroundColor: Colors.white,
        backgroundColor: color ?? GlobalVariables.secondaryColor,
      
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
      child: Text(text, style: TextStyle(color: color == null ? Colors.white : Colors.black),),
    );
  }
}
