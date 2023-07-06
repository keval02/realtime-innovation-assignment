import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realtime_innovations_assignment/add_employee_details/add_employee_details.dart';
import 'package:flutter_realtime_innovations_assignment/add_employee_details/bloc/add_employee_details_bloc.dart';
import 'package:flutter_realtime_innovations_assignment/database/database_provider.dart';
import 'package:flutter_realtime_innovations_assignment/home_page/bloc/home_page_bloc.dart';
import 'package:flutter_realtime_innovations_assignment/home_page/home_page.dart';
import 'package:flutter_realtime_innovations_assignment/model/user_model.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(create: (context) => HomePageBloc(dataBaseProvider: DataBaseProvider())..add(GetEmployeeListEvent(EmployeeModel())),),
        BlocProvider<AddEmployeeDetailsBloc>(create: (context) => AddEmployeeDetailsBloc(DataBaseProvider()),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  HomePage(),
        routes: {
          HomePage.routeName:(context) =>  HomePage(),
          AddEmployeeDetails.routeName:(context) => AddEmployeeDetails(),
        },
      ),
    );
  }
}
