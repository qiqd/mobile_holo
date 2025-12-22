import 'package:flutter/material.dart';

class LoadingOrShowMsg extends StatelessWidget {
  final String? msg;
  const LoadingOrShowMsg({super.key, this.msg});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: msg == null || msg!.isEmpty
            ? const CircularProgressIndicator()
            : Text(msg!),
      ),
    );
  }
}
