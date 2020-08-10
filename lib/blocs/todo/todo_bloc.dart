import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/blocs/todo/todo_event.dart';
import 'package:todo_test/blocs/todo/todo_state.dart';
import 'package:todo_test/blocs/todo/todos.dart';
import 'package:todo_test/models/models/models.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState>{

   TodosRepositoryFlutter repository;

  TodoBloc(TodoState initialState) : super(initialState);

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async*{
    if(event is TodoLoaded){
      yield* _mapTodoLoadedState();
    }else if(event is TodoDelete){
      yield* _mapToTodoDelete(event);
    } else if(event is TodoUpdate){
      yield* _mapToTodoDelete(event);
    }else if(event is TodoAdd){
      yield* _mapToTodoDelete(event);
    }
  }

  Stream<TodoState> _mapTodoLoadedState() async*{
    try{
      yield TodoLoadSuccess([]);
    }catch(_){
      yield TodoLoadFailure();
    }
  }

  Stream<TodoState> _mapToTodoDelete(TodoEvent event){

  }

  Stream<TodoState> _mapToTodoUpdate(TodoEvent event){

  }

  Stream<TodoState> _mapToTodoAdd(TodoEvent event) async*{
    if(state is TodoLoadSuccess){
      yield TodoLoadSuccess([]);
    }
  }

}