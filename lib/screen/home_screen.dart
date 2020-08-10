import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/blocs/blocs.dart';
import 'package:todo_test/localization.dart';
import 'package:todo_test/models/models/app_tab.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc , AppTab>(
      builder: (context, activeTab)=>Scaffold(

        appBar: AppBar(
          title: Text(FlutterBlocLocalizations.of(context).appTitle),
          actions: [
          ],
        ),
      ),
    );
  }
}
