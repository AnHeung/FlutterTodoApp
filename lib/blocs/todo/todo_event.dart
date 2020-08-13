import 'package:equatable/equatable.dart';
import 'package:todo_test/models/todo.dart';

abstract class TodoEvent extends Equatable{

  const TodoEvent();

  @override
  List<Object> get props  => [];
}

class TodoLoaded extends TodoEvent{}

class TodoUpdate extends TodoEvent{

  final Todo updateTodos;

  TodoUpdate({this.updateTodos});

  @override
  List<Object> get props => [updateTodos];

  @override
  String toString() =>'TodoUpdated data :$updateTodos';

}

class TodoAdd extends TodoEvent{

  final Todo addedTodos;

  TodoAdd({this.addedTodos});

  @override
  List<Object> get props => [addedTodos];

  @override
  String toString() => 'TodoAdded Data : $addedTodos';
}

class TodoDelete extends TodoEvent{

  final Todo deleteTodo;

  TodoDelete({this.deleteTodo});

  @override
  List<Object> get props => [deleteTodo];

  @override
  String toString() => 'TodoDelete Data : $deleteTodo';
}

class ClearCompleted extends TodoEvent{}

class ToggleAll extends TodoEvent{}