import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/blocs/filtered_todo/filtered_todo.dart';
import 'package:todo_test/screen/detail_screen.dart';
import 'widgets.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todo_test/blocs/blocs.dart';
import 'package:todo_test/flutter_todos_keys.dart';

class FilterTodo extends StatelessWidget {
  FilterTodo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = ArchSampleLocalizations.of(context);
    return BlocBuilder<FilteredTodoBloc, FilteredTodoState>(
      builder: (context, state) {
        if (state is FilteredTodosLoadInProgress) {
          return LoadingIndicator();
        } else if (state is FilteredTodosLoadSuccess) {
          final todos = state.filteredTodos;
          return ListView.builder(
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDisMissed: (_) {
                  BlocProvider.of<TodoBloc>(context)
                      .add(TodoDelete(deleteTodo: todo));
                  Scaffold.of(context).showSnackBar(DeleteSnackBar(
                    key: ArchSampleKeys.snackbar,
                    todo: todo,
                    onUndo: () => BlocProvider.of<TodoBloc>(context).add(TodoAdd(addedTodos: todo)),
                    localizations: localization,
                  ));
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DetailScreen(id: todo.id,)));

                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(DeleteSnackBar(
                      key: ArchSampleKeys.snackbar,
                      todo: todo,
                      onUndo: () => BlocProvider.of<TodoBloc>(context)
                          .add(TodoAdd(addedTodos: todo)),
                      localizations: localization,
                    ));
                  }
                },
                onCheckBoxChanged: (_) {
                  BlocProvider.of<TodoBloc>(context).add(TodoUpdate(
                      updateTodos: todo.copyWith(complete: !todo.complete)));
                },
              );
            },
            itemCount: todos.length,
          );
        }
        return Container(
          key: FlutterTodosKeys.filteredTodosEmptyContainer,
        );
      },
    );
  }
}
