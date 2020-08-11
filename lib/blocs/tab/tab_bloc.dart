import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/blocs/tab/tab.dart';
import 'package:todo_test/models/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab>{

  TabBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async*{

    if(event is TabUpdated){
      yield event.tab;
    }
  }

}