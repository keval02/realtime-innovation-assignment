import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realtime_innovations_assignment/database/database_provider.dart';
import 'package:flutter_realtime_innovations_assignment/model/user_model.dart';

import 'home_page_state.dart';

part 'home_page_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final DataBaseProvider dataBaseProvider;

  List<EmployeeModel> currentEmployeeList = [];
  List<EmployeeModel> previousEmployeeList = [];
  bool isDataEmpty = false;

  HomePageBloc({required this.dataBaseProvider}) : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) async {
      if (event is GetEmployeeListEvent) {
        emit(HomePageLoadingState());
        try {
          final response = await dataBaseProvider.getModelList();
          if (response.isNotEmpty) {
            isDataEmpty = false;
            currentEmployeeList.clear();
            previousEmployeeList.clear();
            response.forEach((element) {
              EmployeeModel model = EmployeeModel(
                  id: element.id,
                  employeeName: element.employeeName,
                  employeeRole: element.employeeRole,
                  startDate: element.startDate,
                  endDate: element.endDate);
              if (element.endDate != "") {
                previousEmployeeList.add(model);
              } else {
                currentEmployeeList.add(model);
              }
            });
            emit(HomePageLoadDataEmployeeState(
                previousEmployee: previousEmployeeList,
                currentEmployee: currentEmployeeList));
          }else{
            isDataEmpty = true;
            emit(HomePageEmptyData());
          }
        } catch (e) {
          isDataEmpty = true;
          emit(HomePageErrorState(error: e.toString()));
        }
      } else if (event is RemoveEmployeeEvent) {
        emit(HomePageLoadingState());
        try {
          final response = await dataBaseProvider.deleteModel(event.model);
          emit(HomePageInitial());
          print("Delete::: response${response.toString()}");
        } catch (e) {
          emit(HomePageErrorState(error: e.toString()));
        }
      }
    });
  }
}
