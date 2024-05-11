// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

//import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
//import 'package:web/web.dart' as web;
import 'package:flutter_resizable_container/flutter_resizable_container.dart';

import '../model.dart';
import '../theme.dart';
//import 'frame.dart';

const String _viewType = 'dartpad-execution';

bool _viewFactoryInitialized = false;
ExecutionService? executionServiceInstance;

final Key _elementViewKey = UniqueKey();

void _initViewFactory() {
  if (_viewFactoryInitialized) return;

  _viewFactoryInitialized = true;

 // ui_web.platformViewRegistry.registerViewFactory(_viewType, _iFrameFactory);
}

StatefulWidget _iFrameFactory(int viewId) {
  // 'allow-popups' allows plugins like url_launcher to open popups.


 // executionServiceInstance = ExecutionServiceImpl(frame);

  return   ElevatedButton(
    style: TextButton.styleFrom(foregroundColor: Colors.green),
    onPressed: null,
    child: const Text('Disabled'),
  );
}

class ExecutionWidget extends StatefulWidget {
  final AppServices appServices;

  final AppModel appModel;

  ExecutionWidget({
    required this.appServices,
    required this.appModel,
    super.key,
  }) {
    _initViewFactory();
  }

  @override
  State<ExecutionWidget> createState() => _ExecutionWidgetState();
}

class _ExecutionWidgetState extends State<ExecutionWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: widget.appModel.splitViewDragState,
      builder: (context, _) {
        // Ignore pointer events while the Splitter is being dragged.
        widget.appServices.executionService?.ignorePointer =
            widget.appModel.splitViewDragState.value == SplitDragState.active;
        return Container(
          color: theme.scaffoldBackgroundColor,
          padding: const EdgeInsets.all(denseSpacing),
          child: const Text(overflow: TextOverflow.ellipsis, 'Hello , how are you?'),
          //TextBox.fromLTRBD(0.0, 0.0, size.width, size.height, TextDirection.ltr)
          );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    // Unregister the execution service.
    widget.appServices.registerExecutionService(null);
  }
}
