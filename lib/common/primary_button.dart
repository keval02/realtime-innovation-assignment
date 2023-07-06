import 'package:flutter/material.dart';
import 'package:flutter_realtime_innovations_assignment/common/app_color.dart';

@immutable
class PrimaryButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
   Color? colors;
   Color? bgColor;

   PrimaryButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed, this.colors,
     this.bgColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            backgroundColor: bgColor ?? AppColor.transparent),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: colors ?? Colors.white),
        ));
  }
}
