part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetEmployeeListEvent extends HomePageEvent {
  final EmployeeModel model;

  GetEmployeeListEvent(this.model);

  @override
  List<Object?> get props => [model];
}

class RemoveEmployeeEvent extends HomePageEvent {
  final EmployeeModel model;

  RemoveEmployeeEvent({required this.model});

  @override
  List<Object?> get props => [model];
}
