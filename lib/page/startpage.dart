import 'package:flutter/material.dart';
import '../index/setting.dart';

class StartEvent extends StatefulWidget {
  const StartEvent({super.key});

  @override
  State<StartEvent> createState() => _StartEventState();
}

class _StartEventState extends State<StartEvent>{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text('hello!')
        )
      ]
    );
  }
}