import 'package:flutter/material.dart';
import 'package:voice_demo/widgets/directory_button.dart';
import 'package:voice_demo/widgets/record_button.dart';

import '../pages/trim_audio_page.dart';
import 'record_button_widget.dart';

class RecordMenuWidget extends StatelessWidget {
  const RecordMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              DirectoryButton(),
              Text(
                'Your recording',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        RecordButton(
            width: 200, showLastRecording: ((value, path, time) => {})),
        SizedBox(
          width: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
              const Text('Enhance',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}
