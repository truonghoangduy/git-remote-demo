import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_demo/widgets/directory_button.dart';
import 'package:voice_demo/widgets/record_button.dart';
import 'package:voice_demo/widgets/record_duration.dart';

import '../widgets/record_menu_widget.dart';
import '../widgets/script_editor_widget.dart';
import '../widgets/sound_wave_widget.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    RecorderController recorderController = RecorderController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Record audio'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Flexible(flex: 3, child: ScriptEditor()),

            // RecordButton(
            //     width: 200, showLastRecording: ((value, path, time) => {})),
            // DirectoryButton(),
            // Flexible(
            //     flex: 1,
            //     child: SoundWaveWidget(
            //       controller: recorderController,
            //     )),
            Flexible(flex: 1, child: RecordMenuWidget())
          ],
        ),
      ),
    );
  }
}
