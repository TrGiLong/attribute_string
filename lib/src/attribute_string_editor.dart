import 'package:flutter/material.dart';

import 'attribute_string_editing_controller.dart';

class RichTextEditor extends StatefulWidget {
  final AttributeStringEditingController controller;

  const RichTextEditor({Key key, this.controller}) : super(key: key);

  @override
  _RichTextEditorState createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
