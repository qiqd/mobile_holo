import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_mikufans/ui/screen/player.dart';

class SetttingScreen extends StatefulWidget {
  const SetttingScreen({super.key});

  @override
  State<SetttingScreen> createState() => _SetttingScreenState();
}

class _SetttingScreenState extends State<SetttingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/player');
          },
          child: const Text('进入播放器'),
        ),
      ),
    );
  }
}
