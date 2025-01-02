import 'package:flutter/material.dart';

class CusttomButtonAuth extends StatelessWidget {
  final String title;
  final void Function()? onPresed;
  const CusttomButtonAuth({super.key,required this.title, required this.onPresed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
            height: 45,
            padding: EdgeInsets.symmetric(vertical:5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.orange,
            textColor: Colors.white,
            onPressed: onPresed,
            child: Text(title),
          );
  }
}