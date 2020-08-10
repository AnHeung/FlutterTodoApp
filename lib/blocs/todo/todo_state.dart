import 'package:equatable/equatable.dart';
import 'package:todo_test/models/models/models.dart';

abstract class TodoState extends Equatable{

  const TodoState();

  @override
  List<Object> get props => [];

}

class TodoLoadingInProgress extends TodoState{}

class TodoLoadSuccess extends TodoState{

  final List<Todo> loadTodos;

  const TodoLoadSuccess([this.loadTodos = const []]);

  @override
  List<Object> get props => [loadTodos];

  @override
  String toString() => 'TodoLoadInSuccess : $loadTodos';
}

class TodoLoadFailure extends TodoState{}
