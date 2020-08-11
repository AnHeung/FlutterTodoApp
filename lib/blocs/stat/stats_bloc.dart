import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_test/blocs/blocs.dart';
import 'package:todo_test/blocs/stat/stats.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodoBloc todoBloc;
  StreamSubscription streamSubscription;

  StatsBloc({@required this.todoBloc}) : super(StatsLoadInProgress()) {
    streamSubscription = todoBloc.listen((state) {
      if (state is TodoLoadSuccess) {
        add(StatsUpdate(updateList: state.loadTodos));
      }
    });
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event,) async* {
    if (event is StatsUpdate) {
      int numActive = event.updateList.where((todo) => !todo.complete).toList().length;
      int numComplete = event.updateList.where((todo) => todo.complete).toList().length;
      yield StatsLoadSuccess(numActive: numActive, numComplete: numComplete);
    }
  }

  @override
  Future<Function> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
