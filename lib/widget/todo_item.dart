import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todo_test/models/models.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDisMissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckBoxChanged;
  final Todo todo;

  TodoItem(
      {Key key,
      this.onDisMissed,
      this.onTap,
      this.onCheckBoxChanged,
      this.todo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.todoItem(todo.id),
      onDismissed: onDisMissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: ArchSampleKeys.todoItemCheckbox(todo.id),
          value: todo.complete,
          onChanged: onCheckBoxChanged,
        ),
        title: Hero(
          tag: '${todo.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              todo.task,
              key: ArchSampleKeys.todoItemTask(todo.id),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        subtitle: todo.note.isNotEmpty
            ? Text(
                todo.note,
                key: ArchSampleKeys.todoItemNote(todo.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
      ),
    );
  }
}
