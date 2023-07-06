import 'package:flutter/material.dart';
import 'package:flutter_realtime_innovations_assignment/common/app_color.dart';

class SnackBarWidget {
  SnackBarWidget._();

  static buildErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: AppColor.white),
        ),
        backgroundColor: AppColor.blueColor,
      ),
    );
  }
}
