import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realtime_innovations_assignment/database/database_provider.dart';
import 'package:flutter_realtime_innovations_assignment/model/user_model.dart';

part 'add_employee_details_event.dart';

part 'add_employee_details_state.dart';

class AddEmployeeDetailsBloc
    extends Bloc<AddEmployeeDetailsEvent, EmployeeDetailsState> {
  final DataBaseProvider dataBaseProvider;
  bool isStartDate = false;
  AddEmployeeDetailsBloc(this.dataBaseProvider)
      : super(EmployeeDetailsInitial()) {
    on<AddEmployeeDetailsEvent>((event, emit) async {
      if (event is SaveDataEvent) {
        emit(EmployeeDetailsLoadingState());
        try {
          final response = await dataBaseProvider.insertModel(event.model);

          if(response != null){
            emit(InsertEmployeeDataSuccessfully());
          }
          if (kDebugMode) {
            print("response${response}");
          }
        } catch (e) {
          emit(EmployeeDetailsErrorState(error: e.toString()));
        }
      }else if(event is UpdateEmployeeDataEvent){
        print("Update:::${event.employeeModel.employeeName}");

        emit(EmployeeDetailsLoadingState());
        try{
          await dataBaseProvider.updateModel(event.employeeModel);
          emit(InsertEmployeeDataSuccessfully());
        }catch(e){
          emit(EmployeeDetailsErrorState( error: e.toString(),));
        }
      }
    });
  }
}
