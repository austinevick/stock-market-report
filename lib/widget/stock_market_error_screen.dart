import 'package:flutter/material.dart';

import '../common/constant.dart';
import 'custom_button.dart';

class StockMarketErrorScreen extends StatelessWidget {
  final VoidCallback onTap;
  final double? fontSize;
  const StockMarketErrorScreen(this.onTap, {super.key, this.fontSize});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'We are unable to load this page.\nkindly check your connection and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: fontSize),
              ),
              const SizedBox(height: 18),
              CustomButton(
                text: 'Retry',
                radius: 80,
                height: 40,
                width: 150,
                textStyle: const TextStyle(
                    color: lightGreen, fontWeight: FontWeight.w700),
                onPressed: onTap,
                borderSide: const BorderSide(color: lightGreen),
              )
            ],
          ),
        ),
      );
}
