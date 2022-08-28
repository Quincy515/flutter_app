import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// LogicalKeyboardKey.meta macOS上的 CMD 键
// LogicalKeyboardKey.control windows上上的 control 键
final playOrPauseKeySet = LogicalKeySet(
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.space,
);

class StartIntent extends Intent {}

class PlayOrPauseIntent extends Intent {}

class CounterShortcuts extends StatelessWidget {
  const CounterShortcuts({
    Key? key,
    required this.child,
    required this.playOrPause,
  }) : super(key: key);
  final Widget child;
  final VoidCallback playOrPause;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        playOrPauseKeySet: PlayOrPauseIntent(),
      },
      actions: {
        PlayOrPauseIntent: CallbackAction(onInvoke: (e) => playOrPause.call()),
      },
      child: child,
    );
  }
}
