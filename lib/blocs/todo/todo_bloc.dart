import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/blocs/todo/todo_event.dart';
import 'package:todo_test/blocs/todo/todo_state.dart';
import 'package:todo_test/blocs/todo/todos.dart';
import 'package:todo_test/models/models.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState>{

   final TodosRepositoryFlutter repository;

  TodoBloc({@required this.repository}) : super(TodoLoadingInProgress());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async*{
    if(event is TodoLoaded){
      yield* _mapTodoLoadedState();
    }else if(event is TodoUpdate){
      yield* _mapToTodoUpdate(event);
    } else if(event is TodoDelete){
      yield* _mapToTodoDelete(event);
    }else if(event is TodoAdd){
      yield* _mapToTodoAdd(event);
    }else if(event is ClearCompleted){
      yield* _mapToClearComplete();
    }else if(event is ToggleAll){
      yield* _mapToMarkedAll();
    }
  }

  Stream<TodoState> _mapTodoLoadedState() async*{
    try{
      final todos = await this.repository.loadTodos();
      yield TodoLoadSuccess(todos.map(Todo.fromEntity).toList());
    }catch(_){
      yield TodoLoadFailure();
    }
  }

  Stream<TodoState> _mapToTodoDelete(TodoDelete event) async*{
    if(state is TodoLoadSuccess){
      final List<Todo> updateTodos = (state as TodoLoadSuccess).loadTodos.where((todo) => todo.id != event.deleteTodo.id).toList();
      yield TodoLoadSuccess(updateTodos);
      _saveTodos(updateTodos);
    }
  }

  Stream<TodoState> _mapToTodoUpdate(TodoUpdate event) async*{
      if(state is TodoLoadSuccess){
        final List<Todo> updateTodos = (state as TodoLoadSuccess).loadTodos.map((todo) => todo.id == event.updateTodos.id? event.updateTodos : todo).toList();
        yield TodoLoadSuccess(updateTodos);
        _saveTodos(updateTodos);
      }
  }

  Stream<TodoState> _mapToTodoAdd(TodoAdd event) async*{
    if(state is TodoLoadSuccess){
      final List<Todo> addTodo = List.from((state as TodoLoadSuccess).loadTodos)..add(event.addedTodos);
      yield TodoLoadSuccess(addTodo);
      _saveTodos(addTodo);
    }
  }

  Stream<TodoState> _mapToClearComplete() async*{
    if(state is TodoLoadSuccess){
      final List<Todo> clearList = (state as TodoLoadSuccess).loadTodos
          .where((todo) => !todo.complete)
          .toList();
      yield TodoLoadSuccess(clearList);
      _saveTodos(clearList);
    }
  }

   Stream<TodoState> _mapToMarkedAll() async*{
     if(state is TodoLoadSuccess){
        final List<Todo> updateList = (state as TodoLoadSuccess).loadTodos.map((todo) =>  todo.copyWith(complete: !todo.complete)).toList();
        yield TodoLoadSuccess(updateList);
        _saveTodos(updateList);
     }
   }

  Future _saveTodos(List<Todo> todos)=> repository.saveTodos(todos.map((todo) => todo.toEntity()).toList());

}