import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  void playSound(int soundNumber) async {
    print('run sound $soundNumber');
    final player = AudioPlayer();
    await player.play(AssetSource('note$soundNumber.wav'));
  }

  List<int> playedSounds = [];
  late Timer? timer;

  void playRecordedSounds(int soundNumber) {
    playedSounds.add(soundNumber);
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(seconds: 3), () {
      runListSounds(playedSounds);
      playedSounds.clear();
    });
  }

  void runListSounds(List<int> sounds) {
    List<int> newSounds = List.from(sounds);
    for (int i = 0; i < newSounds.length; i++) {
      Timer(Duration(seconds: i * 2), () {
        playSound(newSounds[i]);
      });
    }
  }

  Expanded buildKey({required Color color, required int soundNumber}) {
    return Expanded(
      child: TextButton(
        child: SizedBox.shrink(),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ))),
        onPressed: () {
          playSound(soundNumber);
          playRecordedSounds(soundNumber);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildKey(color: Colors.red, soundNumber: 1),
              buildKey(color: Colors.orange, soundNumber: 2),
              buildKey(color: Colors.yellow, soundNumber: 3),
              buildKey(color: Colors.green, soundNumber: 4),
              buildKey(color: Colors.teal, soundNumber: 5),
              buildKey(color: Colors.blue, soundNumber: 6),
              buildKey(color: Colors.purple, soundNumber: 7),
            ],
          ),
        ),
      ),
    );
  }
}
