import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class ScriptEditor extends StatefulWidget {
  const ScriptEditor({super.key});

  @override
  ScriptEditorState createState() => ScriptEditorState();
}

class ScriptEditorState extends State<ScriptEditor> {
  QuillController? _controller;
  final FocusNode _focusNode = FocusNode();
  Timer? _selectAllTimer;

  @override
  void dispose() {
    _selectAllTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadFromAssets();
  }

  Future<void> _loadFromAssets() async {
    try {
      final result = await rootBundle.loadString(isDesktop()
          ? 'assets/sample_data_nomedia.json'
          : 'assets/sample_data.json');
      final doc = Document.fromJson(jsonDecode(result));
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    } catch (error) {
      final doc = Document()..insert(0, 'Add your memorial text');
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(body: Center(child: Text('Loading...')));
    }

    return _buildWelcomeEditor(context);
  }

  Widget _buildWelcomeEditor(BuildContext context) {
    Widget quillEditor = MouseRegion(
      cursor: SystemMouseCursors.text,
      child: QuillEditor(
        controller: _controller!,
        scrollController: ScrollController(),
        scrollable: true,
        focusNode: _focusNode,
        autoFocus: false,
        readOnly: false,
        placeholder: 'Input your scripts',
        enableSelectionToolbar: true,
        expands: false,
        padding: EdgeInsets.zero,
      ),
    );
    var toolbar = QuillToolbar.basic(
      iconTheme: const QuillIconTheme(),
      controller: _controller!,
      showAlignmentButtons: true,
      afterButtonPressed: _focusNode.requestFocus,
      showFontSize: false,
      showFontFamily: false,
      showCodeBlock: false,
      showBackgroundColorButton: false,
      showClearFormat: false,
      showInlineCode: false,
      showLink: false,
      showDirection: false,
      showIndent: false,
      showListCheck: false,
      showQuote: false,
      showListBullets: false,
      showSearchButton: false,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 15,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: quillEditor,
          ),
        ),
        Container(child: toolbar)
      ],
    );
  }
}
