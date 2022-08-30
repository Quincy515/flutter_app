import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'note_controller.dart';
import 'widgets/web_note_widget.dart';

class NoteView extends GetView<NoteController> {
  const NoteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WebNoteWidget();
  }
}
