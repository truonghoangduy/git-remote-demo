import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_demo/controller/audio_player_controller.dart';
import 'package:voice_demo/services/snackbar_service.dart';

import 'controller/path_controller.dart';
import 'controller/record_controller.dart';
import 'controller/timer_controller.dart';
import 'pages/record_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => RecordController(),
      ),
      ChangeNotifierProvider(
        create: (_) => TimerController(),
      ),
      ChangeNotifierProvider(
        create: (_) => AudioPlayerController(""),
      ),
      ChangeNotifierProvider(
        create: (_) => PathController(),
      ),
      Provider(
        create: (_) => SnackbarService(),
      ),
    ],
    child: const MaterialApp(
      home: RecordPage(),
    ),
  ));
}
