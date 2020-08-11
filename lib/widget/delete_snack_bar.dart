import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todo_test/models/models.dart';

class DeleteSnackBar extends SnackBar {
  final ArchSampleLocalizations localizations;

  DeleteSnackBar({
    Key key,
    @required Todo todo,
    @required VoidCallback onUndo,
    @required this.localizations,
  }) : super(
            key: key,
            content: Text(
              localizations.todoDeleted(todo.task),
              maxLines: 1,
            ),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: localizations.undo,
              onPressed: onUndo,
            ));
}
