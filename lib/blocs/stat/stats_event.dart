import 'package:equatable/equatable.dart';
import 'package:todo_test/models/models.dart';

abstract class StatsEvent extends Equatable{

  const StatsEvent();

  @override
  List<Object> get props => [];
}

class StatsInitialize extends StatsEvent{}

class StatsUpdate extends StatsEvent{

  final List<Todo> updateList;

  StatsUpdate({this.updateList});

  @override
  List<Object> get props => [updateList];

}
