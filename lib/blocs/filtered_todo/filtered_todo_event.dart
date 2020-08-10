
import 'package:equatable/equatable.dart';
import 'package:todo_test/models/models/models.dart';

abstract class FilteredTodoEvent  extends Equatable{
  const FilteredTodoEvent();
}

class FilterUpdate extends FilteredTodoEvent{

  final VisibilityFilter filter;

  const FilterUpdate(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class FilterTodoUpdate extends FilteredTodoEvent{

  final List<Todo> todos;

  const FilterTodoUpdate(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosUpdated { todos: $todos }';

}
