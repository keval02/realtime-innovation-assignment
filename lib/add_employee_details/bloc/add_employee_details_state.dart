part of 'add_employee_details_bloc.dart';

@immutable
abstract class EmployeeDetailsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class EmployeeDetailsInitial extends EmployeeDetailsState {

}

class EmployeeDetailsLoadingState extends EmployeeDetailsState{}
class EmployeeDetailsLoadedState extends EmployeeDetailsState{
  final EmployeeModel model;
  EmployeeDetailsLoadedState({required this.model});
  @override
  List<Object?> get props => [model];
}
class EmployeeDetailsErrorState extends EmployeeDetailsState{
  final String error;

  EmployeeDetailsErrorState({required this.error});

}

class InsertEmployeeDataSuccessfully extends EmployeeDetailsState{}