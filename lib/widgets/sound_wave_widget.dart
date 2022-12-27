import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class SoundWaveWidget extends StatefulWidget {
  final RecorderController controller;
  const SoundWaveWidget({super.key, required this.controller});

  @override
  State<SoundWaveWidget> createState() => _SoundWaveWidgetState();
}

class _SoundWaveWidgetState extends State<SoundWaveWidget> {
  @override
  Widget build(BuildContext context) {
    return AudioWaveforms(
      size: const Size(double.infinity, double.infinity),
      recorderController: widget.controller,
    );
  }
}
