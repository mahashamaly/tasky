import 'package:flutter/material.dart';

class Customcheckbox extends StatelessWidget {
Customcheckbox({super.key, required this.value, required this.onChanged});
final bool value;
final Function(bool?)onChanged;
  @override
  Widget build(BuildContext context) {
    return  Checkbox(
                        activeColor: Color(0XFF15B86C),
                     
                        value: value,
                        onChanged: (bool? value) =>onChanged(value),
                          
                      );
  }
}