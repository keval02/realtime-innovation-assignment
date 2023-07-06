import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realtime_innovations_assignment/model/user_model.dart';

@immutable
abstract class HomePageState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageEmptyData extends HomePageState{}

class HomePageLoadDataEmployeeState extends HomePageState {
  final List<EmployeeModel> previousEmployee;
  final List<EmployeeModel> currentEmployee;

  HomePageLoadDataEmployeeState({required this.previousEmployee, required this.currentEmployee});

  @override
  List<Object?> get props => [previousEmployee, currentEmployee];
}

class HomePageErrorState extends HomePageState {
  final String error;

  HomePageErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
