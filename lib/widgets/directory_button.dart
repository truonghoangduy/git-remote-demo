import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controller/path_controller.dart';
import 'directory_sheet.dart';

class DirectoryButton extends StatelessWidget {
  const DirectoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PathController _pathController = Provider.of<PathController>(context);
    return IconButton(
        onPressed: () {
          _pathController.getDocs();
          HapticFeedback.vibrate();
          Future.delayed(const Duration(seconds: 0)).then(
            (value) => showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              elevation: 0,
              isScrollControlled: true,
              enableDrag: true,
              routeSettings: const RouteSettings(name: '/recording-sheet'),
              builder: (_) => const RecordingSheet(),
            ),
          );
        },
        icon: const Icon(Icons.folder_open_rounded));
  }
}
