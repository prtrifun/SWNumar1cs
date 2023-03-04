import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback? onTryAgain;

  const CustomErrorWidget({this.error = 'error', this.onTryAgain, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onTryAgain,
            child: Text('try_again'.tr()),
          ),
        ],
      ),
    );
  }
}
