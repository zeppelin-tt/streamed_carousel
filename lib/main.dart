import 'package:flutter/material.dart';
import 'package:streamed_carousel/beauty_sub_effects_menu.dart';
import 'package:streamed_carousel/iterable_beauty_sub_effects_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Material(
        color: Colors.black,
        child: Foo(),
      ),
    );
  }
}

class Foo extends StatelessWidget {
  const Foo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:  [
        BeautySubEffectsMenu(),
        IterableBeautySubEffectsMenu(),
      ],
    );
  }
}
