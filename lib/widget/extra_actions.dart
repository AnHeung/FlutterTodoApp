import 'package:flutter/material.dart';
import 'package:todo_test/flutter_todos_keys.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/blocs/blocs.dart';
import 'widgets.dart';
import 'package:todo_test/localization.dart';
import 'package:todo_test/models/models.dart';

class ExtraActions extends StatelessWidget {

  ExtraActions({Key key}) : super(key: ArchSampleKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoadSuccess) {
          bool allComplete = (BlocProvider.of<TodoBloc>(context).state as TodoLoadSuccess)
              .loadTodos
              .every((todo) => todo.complete);
          return PopupMenuButton<ExtraAction>(
            key: FlutterTodosKeys.extraActionsPopupMenuButton,
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted :
                  BlocProvider.of<TodoBloc>(context).add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete :
                  BlocProvider.of<TodoBloc>(context).add(ToggleAll());
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                key: ArchSampleKeys.toggleAll,
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete
                      ? ArchSampleLocalizations.of(context).markAllIncomplete
                      : ArchSampleLocalizations.of(context).markAllComplete,
                ),
              ),
              PopupMenuItem<ExtraAction>(
                key: ArchSampleKeys.clearCompleted,
                value: ExtraAction.clearCompleted,
                child: Text(
                  ArchSampleLocalizations.of(context).clearCompleted,
                ),
              ),
            ],
          );
        }
        return Container(
          key: FlutterTodosKeys.extraActionsEmptyContainer,
        );
      },
    );
  }
}
