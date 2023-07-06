import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realtime_innovations_assignment/add_employee_details/add_employee_details.dart';
import 'package:flutter_realtime_innovations_assignment/common/app_color.dart';
import 'package:flutter_realtime_innovations_assignment/common/app_string.dart';
import 'package:flutter_realtime_innovations_assignment/common/images_path.dart';
import 'package:flutter_realtime_innovations_assignment/model/user_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'bloc/home_page_bloc.dart';
import 'bloc/home_page_state.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/homePage';

  HomePage({
    super.key,
  });

  List<SlidableController> slidableController = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(AppString.appTitle),
            automaticallyImplyLeading: false),
        body: mainView(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddEmployeeDetails.routeName);
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: const Icon(Icons.add),
        ));
  }

  Widget mainView(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          BlocConsumer<HomePageBloc, HomePageState>(
            listener: (context, state) {
              if (state is HomePageInitial) {
                BlocProvider.of<HomePageBloc>(context)
                    .add(GetEmployeeListEvent(EmployeeModel()));
              }
            },
            builder: (context, state) {
              if (state is HomePageLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomePageLoadDataEmployeeState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: state.currentEmployee.isNotEmpty,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        color: AppColor.lightGrey,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              AppString.currentEmployee,
                              style: TextStyle(color: AppColor.blueColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.currentEmployee.isNotEmpty,
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                                  itemCount: state.currentEmployee.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          const EdgeInsets.only(top: 8, left: 8),
                                      child: Slidable(
                                        key: const ValueKey(0),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (value) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return AddEmployeeDetails(
                                                      employeeModel: state
                                                          .currentEmployee[index],
                                                    );
                                                  },
                                                ));
                                              },
                                              backgroundColor:
                                                  AppColor.sliableEditColor,
                                              foregroundColor: Colors.white,
                                              icon: Icons.edit,
                                              label: AppString.edit,
                                            ),
                                            SlidableAction(
                                              onPressed: (value) {
                                                BlocProvider.of<HomePageBloc>(
                                                        context)
                                                    .add(RemoveEmployeeEvent(
                                                        model:
                                                            state.currentEmployee[
                                                                index]));
                                              },
                                              backgroundColor:
                                                  AppColor.sliableDeleteColor,
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: AppString.delete,
                                            ),
                                          ],
                                        ),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.079,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.currentEmployee[index]
                                                        .employeeName ??
                                                    "",
                                                style: const TextStyle(
                                                    color:
                                                        AppColor.textBlackColor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(state.currentEmployee[index]
                                                      .employeeRole ??
                                                  ""),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "${state.currentEmployee[index].startDate} " ??
                                                      ""),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      color: Colors.grey,
                                    );
                                  },
              )),
                    ),
                    Visibility(
                      visible: state.previousEmployee.isNotEmpty,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        color: AppColor.lightGrey,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              AppString.previousEmployee,
                              style: TextStyle(color: AppColor.blueColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.previousEmployee.isNotEmpty,
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child:  ListView.separated(
                                  itemCount: state.previousEmployee.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          const EdgeInsets.only(top: 8, left: 8),
                                      child: Slidable(
                                        key: const ValueKey(0),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (value) {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return AddEmployeeDetails(
                                                          employeeModel: state
                                                              .previousEmployee[index],
                                                        );
                                                      },
                                                    ));
                                              },
                                              backgroundColor:
                                                  AppColor.sliableEditColor,
                                              foregroundColor: Colors.white,
                                              icon: Icons.edit,
                                              label: AppString.edit,
                                            ),
                                            SlidableAction(
                                              onPressed: (value) {
                                                BlocProvider.of<HomePageBloc>(
                                                        context)
                                                    .add(RemoveEmployeeEvent(
                                                        model: state
                                                                .previousEmployee[
                                                            index]));
                                              },
                                              backgroundColor:
                                                  AppColor.sliableDeleteColor,
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: AppString.delete,
                                            ),
                                          ],
                                        ),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.079,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.previousEmployee[index]
                                                        .employeeName ??
                                                    "",
                                                style: const TextStyle(
                                                    color:
                                                        AppColor.textBlackColor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(state.previousEmployee[index]
                                                      .employeeRole ??
                                                  ""),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "${state.previousEmployee[index].startDate} - ${state.previousEmployee[index].endDate} " ??
                                                      ""),
                                              // Divider(color: Colors.grey,)
                                              // Container(child: Text('Current Employees', style: TextStyle(color: AppColor.blueColor),),height: MediaQuery.of(context).size.height * 0.05,color: Colors.grey,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      color: Colors.grey,
                                    );
                                  },
                                )
                             ),
                    ),
                  ],
                );
              }else if(state is HomePageEmptyData){
                return Image.asset(ImagePath.emptyEmployeesList);
              }

              return Image.asset(ImagePath.emptyEmployeesList);
            },
          ),
          Visibility(
            visible: !context.watch<HomePageBloc>().isDataEmpty,
            child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  color: AppColor.lightGrey,
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(AppString.swipeLeftToDelete),
                      )),
                )),
          )
        ],
      ),
    );
  }
}
