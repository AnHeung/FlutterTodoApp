import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/blocs/simple_bloc_observer.dart';
import 'package:todo_test/blocs/stat/stats.dart';
import 'package:todo_test/screen/home_screen.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'blocs/blocs.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todo_test/localization.dart';


void main() {
  Bloc.observer  = SimpleBlocObserver();
  runApp(BlocProvider(
      create: (context) {
        return TodoBloc(
          repository: const TodosRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..add(TodoLoaded());
      },
    child: TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home :(context){
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<FilteredTodoBloc>(
                create: (context) => FilteredTodoBloc(
                  todoBloc: BlocProvider.of<TodoBloc>(context),
                ),
              ),
              BlocProvider<StatsBloc>(
                create: (context) => StatsBloc(
                  todoBloc: BlocProvider.of<TodoBloc>(context),
                ),
              ),
            ],
            child: HomeScreen(),
          );
        },
      },
    );
  }
}




