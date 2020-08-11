import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/blocs/blocs.dart';
import 'package:todo_test/localization.dart';
import 'package:todo_test/models/models.dart';
import 'package:todo_test/widget/tab_selector.dart';
import 'package:todo_test/widget/widgets.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilterTodo() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addTodo,
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
