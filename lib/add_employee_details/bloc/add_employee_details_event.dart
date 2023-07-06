part of 'add_employee_details_bloc.dart';

@immutable
abstract class AddEmployeeDetailsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SaveDataEvent extends AddEmployeeDetailsEvent{
 final  EmployeeModel model;

  SaveDataEvent({required this.model});

  @override
  List<Object?> get props => [model];
}

class UpdateEmployeeDataEvent extends AddEmployeeDetailsEvent{
 final EmployeeModel employeeModel;

 UpdateEmployeeDataEvent({required this.employeeModel});

  @override
  List<Object?> get props => [employeeModel];
}
