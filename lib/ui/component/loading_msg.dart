import 'package:flutter/material.dart';

class LoadingOrShowMsg extends StatelessWidget {
  final String? msg;
  final Color backgroundColor;
  final Function()? onMsgTab;
  const LoadingOrShowMsg({
    super.key,
    this.msg,
    this.backgroundColor = Colors.transparent,
    this.onMsgTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: msg == null || msg!.isEmpty
            ? const CircularProgressIndicator()
            : TextButton(onPressed: () => onMsgTab?.call(), child: Text(msg!)),
      ),
    );
  }
}
