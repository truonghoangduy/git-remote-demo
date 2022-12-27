import 'package:flutter/material.dart';

import '../painters/ripple_painter.dart';

class RecordButtonWidget extends StatefulWidget {
  const RecordButtonWidget({
    Key? key,
    required this.showLastRecording,
    required this.width,
  }) : super(key: key);
  final double width;
  final Function(bool value, String path, int time) showLastRecording;

  @override
  State<RecordButtonWidget> createState() => _RecordButtonWidgetState();
}

class _RecordButtonWidgetState extends State<RecordButtonWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final Tween<double> _sizeTween = Tween(begin: .4, end: 1);
  bool glow = true;
  bool holding = false;
  double x = 0;
  double y = 0;
  bool lock = false;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animation = _sizeTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    )..addListener(() {
        setState(() {
          if (controller.value >= 0.7) {
            glow = false;
          } else if (controller.value <= 0.1) {
            glow = true;
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              top: holding
                  ? lock
                      ? -90
                      : -70
                  : 56,
              height: holding
                  ? lock
                      ? 96
                      : 56
                  : 0,
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(lock ? 26 : 16.0),
                    child: Icon(
                      lock ? Icons.lock : Icons.lock_open,
                      size: holding
                          ? lock
                              ? 44
                              : 24
                          : 0,
                    ),
                  ))),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: RipplePainter(
                    color: Theme.of(context).colorScheme.secondary,
                    animationValue: animation.value,
                    width: widget.width * 0.486),
                child: SizedBox(
                  height: widget.width * 0.486,
                  width: widget.width * 0.486,
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                top: holding
                    ? y
                    : (((widget.width * 0.486) - (widget.width * 0.218)) / 2),
                left: (((widget.width * 0.486) - (widget.width * 0.218)) / 2),
                child: SizedBox(
                  height: (widget.width * 0.218),
                  width: (widget.width * 0.218),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onLongPressStart: (details) async {},
                    onLongPressMoveUpdate: (details) {},
                    onLongPressEnd: (details) async {},
                    child: FloatingActionButton(
                      heroTag: "Record",
                      shape: const CircleBorder(),
                      child: StreamBuilder(
                        builder: (context, snapshot) {
                          return const Icon(
                            Icons.mic,
                          );
                          // switch (snapshot.data) {
                          //   case RecordState.ready:
                          //     return const Icon(
                          //       Icons.mic,
                          //     );
                          //   case RecordState.recording:
                          //     return const Icon(
                          //       Icons.stop,
                          //     );
                          //   case RecordState.paused:
                          //     return const Icon(
                          //       Icons.stop,
                          //     );
                          //   case RecordState.error:
                          //     return const Icon(
                          //       Icons.error,
                          //     );
                          //   default:
                          //     return const Icon(
                          //       Icons.mic,
                          //     );
                          // }
                        },
                      ),
                      onPressed: () async {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
