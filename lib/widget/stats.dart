import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todo_test/blocs/stat/stats.dart';
import 'widgets.dart';
import 'package:todo_test/flutter_todos_keys.dart';


class Stats extends StatelessWidget {

  Stats({Key key }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state){
        if(state is StatsLoadInProgress){
          return LoadingIndicator(
            key: FlutterTodosKeys.statsLoadInProgressIndicator,
          );
        }else if(state is StatsLoadSuccess){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    ArchSampleLocalizations.of(context).completedTodos,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    '${state.numComplete}',
                    key: ArchSampleKeys.statsNumCompleted,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    ArchSampleLocalizations.of(context).activeTodos,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    "${state.numActive}",
                    key: ArchSampleKeys.statsNumActive,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
          );
        }


        return Container();
      },
    );
  }
}
