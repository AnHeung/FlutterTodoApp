import 'package:equatable/equatable.dart';
import 'package:todo_test/models/models/models.dart';

abstract class FilteredTodoState extends Equatable{

  const FilteredTodoState();

  @override
  List<Object> get props => [];
}

class FilteredTodosLoadInProgress extends FilteredTodoState {}

class FilteredTodosLoadSuccess extends FilteredTodoState{

  final List<Todo> filteredTodos;

  final VisibilityFilter activeFilter;

  const FilteredTodosLoadSuccess(this.filteredTodos , this.activeFilter);

  @override
  List<Object> get props => [filteredTodos , activeFilter];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { filteredTodos: $filteredTodos, activeFilter: $activeFilter }';
  }
}


