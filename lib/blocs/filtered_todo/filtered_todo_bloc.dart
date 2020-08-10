import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_test/blocs/todo/todo_bloc.dart';
import 'package:todo_test/blocs/todo/todo_state.dart';
import 'package:todo_test/models/models/models.dart';

import 'filtered_todo.dart';

class FilteredTodoBloc extends Bloc<FilteredTodoEvent, FilteredTodoState> {

  final TodoBloc todoBloc;
  StreamSubscription todosSubScription;

  FilteredTodoBloc({@required this.todoBloc}) : super(todoBloc.state is TodoLoadSuccess
      ? FilteredTodosLoadSuccess((todoBloc.state as TodoLoadSuccess).loadTodos, VisibilityFilter.all,)
      : FilteredTodosLoadInProgress(),
  ){
    todosSubScription = todoBloc.listen((state) {
      if (state is TodoLoadSuccess) {
        add(FilterTodoUpdate((todoBloc.state as TodoLoadSuccess).loadTodos));
      }
    });
  }

  @override
  Stream<FilteredTodoState> mapEventToState(
    FilteredTodoEvent event,
  ) async* {
    if(event is FilterUpdate){
      yield* _mapFilterUpdateToState(event);
    }else if(event is FilterTodoUpdate){
      yield* _mapTodoUpdateToState(event);
    }
  }


  Stream<FilteredTodoState> _mapFilterUpdateToState(FilterUpdate event) async*{
      if(todoBloc.state is TodoLoadSuccess){
        yield FilteredTodosLoadSuccess((todoBloc.state as TodoLoadSuccess).loadTodos, event.filter);
      }
  }

  Stream<FilteredTodoState> _mapTodoUpdateToState(FilterTodoUpdate event) async*{
    final visibilityFilter  = state is FilteredTodosLoadSuccess ? (state as FilteredTodosLoadSuccess).activeFilter : VisibilityFilter.all;

    yield FilteredTodosLoadSuccess(_mapTodosToFilteredTodos((todoBloc.state as TodoLoadSuccess).loadTodos, visibilityFilter), visibilityFilter);

  }

  List<Todo> _mapTodosToFilteredTodos(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<Function> close() {
    todosSubScription.cancel();
    return super.close();
  }
}
