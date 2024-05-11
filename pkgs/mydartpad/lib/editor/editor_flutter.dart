import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/dart.dart' as language;

import 'package:dartpad_shared/services.dart' as services;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model.dart';

import 'dart:math' as math;
//import '../common/snippets.dart';

class EditorWidget extends StatefulWidget {
  final AppModel appModel;
  final AppServices appServices;

  EditorWidget({
    required this.appModel,
    required this.appServices,
    super.key,
  }) {
   // _initViewFactory();
  }

  @override
  State<EditorWidget> createState() => _EditorWidgetState();
}


class _EditorWidgetState extends State<EditorWidget> implements EditorService {
 // StreamSubscription<void>? listener;
 // CodeMirror? codeMirror;
  //CompletionType completionType = CompletionType.auto;
  final controller = CodeController(
    text: "javaFactorialSnippet",
    language: language.dart,
  );

  late final FocusNode _focusNode;

  _EditorWidgetState() {
    _focusNode = FocusNode(
      onKeyEvent: (node, event) {
        if (!node.hasFocus) {
          return KeyEventResult.ignored;
        }

        // If focused, allow CodeMirror to handle tab.
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          return KeyEventResult.skipRemainingHandlers;
        } else if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.period) {
          // On a period, auto-invoke code completions.

          // If any modifiers keys are depressed, ignore this event. Note that
          // directly querying `HardwareKeyboard.instance` could have a race
          // condition (we'd like to read this information directly from the
          // event).
          if (HardwareKeyboard.instance.isAltPressed ||
              HardwareKeyboard.instance.isControlPressed ||
              HardwareKeyboard.instance.isMetaPressed ||
              HardwareKeyboard.instance.isShiftPressed) {
            return KeyEventResult.ignored;
          }

          // We introduce a delay here to allow codemirror to process the key
          // event.
         // Timer.run(() => showCompletions(autoInvoked: true));

          return KeyEventResult.skipRemainingHandlers;
        }

        return KeyEventResult.ignored;
      },
    );
  }
  @override
  void showCompletions({required bool autoInvoked}) {
 //   completionType = autoInvoked ? CompletionType.auto : CompletionType.manual;


  }

  @override
  void showQuickFixes() {
  // completionType = CompletionType.quickfix;

  }

  @override
  void jumpTo(services.AnalysisIssue issue) {
    final line = math.max(issue.location.line - 1, 0);
    final column = math.max(issue.location.column - 1, 0);

    if (issue.location.line != -1) {

    } else {

    }

    focus();
  }

  @override
  int get cursorOffset {
    final pos = 0; //codeMirror?.getCursor();
    if (pos == null) return 0;

    return  0;
  }

  @override
  void focus() {
    _focusNode.requestFocus();
  }


  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: CodeThemeData(styles: monokaiSublimeTheme),
      child: SingleChildScrollView(
        child: CodeField(
          controller: controller,
        ),
      ),
    );
  }
}