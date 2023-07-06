import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_realtime_innovations_assignment/add_employee_details/bloc/add_employee_details_bloc.dart';
import 'package:flutter_realtime_innovations_assignment/common/app_color.dart';
import 'package:flutter_realtime_innovations_assignment/common/app_string.dart';
import 'package:flutter_realtime_innovations_assignment/common/images_path.dart';
import 'package:flutter_realtime_innovations_assignment/common/primary_button.dart';
import 'package:flutter_realtime_innovations_assignment/common/snackBar_widget.dart';
import 'package:flutter_realtime_innovations_assignment/home_page/bloc/home_page_bloc.dart';
import 'package:flutter_realtime_innovations_assignment/home_page/home_page.dart';
import 'package:flutter_realtime_innovations_assignment/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEmployeeDetails extends StatefulWidget {
  static const String routeName = '/addEmployeeName';

  EmployeeModel? employeeModel;

  AddEmployeeDetails({
    super.key,
    this.employeeModel,
  });

  @override
  State<AddEmployeeDetails> createState() => _AddEmployeeDetailsState();
}

class _AddEmployeeDetailsState extends State<AddEmployeeDetails> {
  TextEditingController employeeNameController = TextEditingController();

  TextEditingController dropDownController = TextEditingController();

  TextEditingController todayDateController = TextEditingController();

  TextEditingController endDateController = TextEditingController();

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  String startDate = '';
  bool isStartDate = false;
  bool isEndDate = false;
  String endDate = '';
  int? employeeId;
  DateRangePickerController rangePickerController = DateRangePickerController();

  @override
  void initState() {
    super.initState();
    if (widget.employeeModel != null) {
      employeeNameController.text = widget.employeeModel?.employeeName ?? "";
      dropDownController.text = widget.employeeModel?.employeeRole ?? "";
      todayDateController.text = widget.employeeModel?.startDate ?? "";
      endDateController.text = widget.employeeModel?.endDate ?? "";
      employeeId = widget.employeeModel?.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(AppString.addEmployeeDetails),
          automaticallyImplyLeading: false),
      body: BlocConsumer<AddEmployeeDetailsBloc, EmployeeDetailsState>(
        listener: (context, state) {
          if (state is InsertEmployeeDataSuccessfully) {
            BlocProvider.of<HomePageBloc>(context)
                .add(GetEmployeeListEvent(EmployeeModel()));
            Navigator.pushNamed(context, HomePage.routeName);
          }
        },
        builder: (context, state) {
          return mainView(context);
        },
      ),
    );
  }

  Widget mainView(BuildContext context) {
    return Stack(
      children: [
        columnWidget(),

        buttonWidget(context),
      ],
    );
  }

  Widget columnWidget() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        height: 40,
        margin: const EdgeInsets.all(15),
        child: TextFormField(
          controller: employeeNameController,
          cursorColor: Colors.black,
          style: const TextStyle(
            color: Colors.black,fontSize: 12
          ),
          onChanged: (value) {
            // employeeNameController.text = value.toString();
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
              focusColor: Colors.white,
              //add prefix icon
              prefixIcon: Container(
                height: 8,
                width: 8,
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: AppColor.blueColor,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColor.lightGrey20,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black26, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              fillColor: Colors.grey,
              hintText: AppString.employeeName,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
      ),
      Container(
        height: 40,
        margin: const EdgeInsets.all(15),
        child: TextFormField(
          readOnly: true,
          showCursor: false,
          keyboardType: TextInputType.none,
          onTap: () async {
            FocusManager.instance.primaryFocus?.unfocus();

            final String? number = await showCupertinoModalPopup(
                context: context, builder: _showActionSheet);

            dropDownController.text = number ?? "";
            print(number);
          },
          controller: dropDownController,
          cursorColor: Colors.black,
          style: const TextStyle(
            color: Colors.black,fontSize: 12
          ),
          onChanged: (value) {
            // dropDownController.text = value.toString();
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
              focusColor: Colors.white,
              suffixIcon: const Icon(
                Icons.arrow_drop_down_sharp,
                color: AppColor.blueColor,
              ),
              prefixIcon: Container(
                  padding: const EdgeInsets.all(13),
                  height: 8,
                  width: 8,
                  child: Image.asset(ImagePath.bagImage)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColor.lightGrey20,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black26, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              fillColor: Colors.grey,
              hintText: AppString.selectRole,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              height: 40,
              margin: const EdgeInsets.all(15),
              child: TextFormField(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    isStartDate = true;
                  });
                  showDialogMethod();
                },
                controller: todayDateController,
                cursorColor: Colors.black,
                style:  TextStyle(
                  color: Colors.black,fontSize: 12,
                ),
                onChanged: (value) {
                  //todayDateController.text = value.toString();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  focusColor: Colors.white,
                  prefixIcon: Container(
                      padding: const EdgeInsets.all(12),
                      height: 8,
                      width: 8,
                      child: Image.asset(ImagePath.calendarImage)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: AppColor.lightGrey20,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black26, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  fillColor: Colors.grey,
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: AppString.today,
                ),
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_rounded,
            color: AppColor.blueColor,
          ),
          Expanded(
            child: Container(
              height: 40,
              margin: const EdgeInsets.all(15),
              child: TextFormField(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    isEndDate = true;
                  });
                  showDialogEndDateMethod();
                },
                controller: endDateController,
                cursorColor: Colors.black,
                style:  TextStyle(
                  color: Colors.black,fontSize: 12,
                ),
                onChanged: (value) {
                  // endDateController.text = value.toString();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    focusColor: Colors.white,
                    prefixIcon: Container(
                        padding: const EdgeInsets.all(12),
                        height: 8,
                        width: 8,
                        child: Image.asset(ImagePath.calendarImage)),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: AppColor.lightGrey20,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.grey,
                    hintText: AppString.noDate,
                    hintStyle: const TextStyle(color: Colors.grey,)),
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  Future<dynamic> showDialogMethod() {
    return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColor.transparent,
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  shape: BoxShape.rectangle,
                  color: AppColor.white,
                  border: Border.all(width: 1)),
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: dialogWidget(context),
            ),
          ),
        );
      },
    );
  }

  Widget dialogWidget(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        height: MediaQuery.of(context).size.height * 0.055,
                        // width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: AppColor.white50,
                        ),
                        child: PrimaryButtonWidget(
                            text: AppString.today,
                            bgColor: AppColor.buttonBGLightBlueColor,
                            colors: AppColor.blueColor,
                            onPressed: () {
                              setState(() {
                                isStartDate = true;
                              });
                              _onSelectionChanged(DateRangePickerSelectionChangedArgs(DateTime.now()));
                            }))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: MediaQuery.of(context).size.height * 0.055,
                        // width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: AppColor.white50,
                        ),
                        child: PrimaryButtonWidget(
                            text: AppString.nextMonday,
                            bgColor: AppColor.buttonBGLightBlueColor,
                            colors: AppColor.blueColor,
                            onPressed: () {
                              setState(() {
                                isStartDate = true;
                              });
                              var today = DateTime.now();
                              _onSelectionChanged(DateRangePickerSelectionChangedArgs(today.next(DateTime.monday)));
                            }))),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        height: MediaQuery.of(context).size.height * 0.055,
                        // width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: AppColor.white50,
                        ),
                        child: PrimaryButtonWidget(
                            text: AppString.netTuesday,
                            bgColor: AppColor.buttonBGLightBlueColor,
                            colors: AppColor.blueColor,
                            onPressed: () {
                              setState(() {
                                isStartDate = true;
                              });
                              var today = DateTime.now();
                              _onSelectionChanged(DateRangePickerSelectionChangedArgs(today.next(DateTime.tuesday)));
                            }))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: MediaQuery.of(context).size.height * 0.055,
                        // width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: AppColor.white50,
                        ),
                        child: PrimaryButtonWidget(
                            text: AppString.after1Week,
                            bgColor: AppColor.buttonBGLightBlueColor,
                            colors: AppColor.blueColor,
                            onPressed: () {
                              setState(() {
                                isStartDate = true;
                              });
                              var today = DateTime.now();
                              _onSelectionChanged(DateRangePickerSelectionChangedArgs(today.afterWeek(7)));
                            }))),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              controller: rangePickerController,
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedRange: PickerDateRange(
                  DateTime.now().subtract(Duration()),
                  DateTime.now().add(Duration())),
            ),
          ],
        ),
        Positioned(
            bottom: 5,
            left: 0,
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.07,
                  child: Image.asset(ImagePath.calendarImage),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(AppString.noDate),
                ),
              ],
            )),
        Positioned(
            bottom: 10,
            right: 0,
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 3, right: 10),
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: AppColor.white50,
                    ),
                    child: PrimaryButtonWidget(
                        text: AppString.cancel,
                        bgColor: AppColor.buttonBGLightBlueColor,
                        colors: AppColor.blueColor,
                        onPressed: () {
                          Navigator.pop(context);
                        })),
                Container(
                    margin: const EdgeInsets.only(top: 3, right: 10),
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: AppColor.blueColor),
                    child: PrimaryButtonWidget(
                        text: AppString.save,
                        onPressed: () {
                          Navigator.pop(context);
                        })),
              ],
            )),
      ],
    );
  }



  Future<dynamic> showDialogEndDateMethod() {
    return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColor.transparent,
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  shape: BoxShape.rectangle,
                  color: AppColor.white,
                  border: Border.all(width: 1)),
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: dialogEndDateWidget(context),
            ),
          ),
        );
      },
    );
  }

  Widget dialogEndDateWidget(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: MediaQuery.of(context).size.height * 0.055,
                        // width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: AppColor.white50,
                        ),
                        child: PrimaryButtonWidget(
                            text: AppString.noDate,
                            bgColor: AppColor.buttonBGLightBlueColor,
                            colors: AppColor.blueColor,
                            onPressed: () {
                              setState(() {
                                endDateController.text = "";
                              });
                              Navigator.pop(context);
                              // _onSelectionChanged(DateRangePickerSelectionChangedArgs(""));
                            }))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        height: MediaQuery.of(context).size.height * 0.055,
                        // width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: AppColor.white50,
                        ),
                        child: PrimaryButtonWidget(
                            text: AppString.today,
                            bgColor: AppColor.buttonBGLightBlueColor,
                            colors: AppColor.blueColor,
                            onPressed: () {
                              setState(() {
                                isEndDate = true;
                              });
                              _onSelectionChanged(DateRangePickerSelectionChangedArgs(DateTime.now()));
                            }))),
              ],
            ),
            SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              controller: rangePickerController,
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedRange: PickerDateRange(
                  DateTime.now().subtract(Duration()),
                  DateTime.now().add(Duration())),
            ),
          ],
        ),
        Positioned(
            bottom: 5,
            left: 0,
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.07,
                  child: Image.asset(ImagePath.calendarImage),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(AppString.noDate),
                ),
              ],
            )),
        Positioned(
            bottom: 10,
            right: 0,
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 3, right: 10),
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: AppColor.white50,
                    ),
                    child: PrimaryButtonWidget(
                        text: AppString.cancel,
                        bgColor: AppColor.buttonBGLightBlueColor,
                        colors: AppColor.blueColor,
                        onPressed: () {
                          Navigator.pop(context);
                        })),
                Container(
                    margin: const EdgeInsets.only(top: 3, right: 10),
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: AppColor.blueColor),
                    child: PrimaryButtonWidget(
                        text: AppString.save,
                        onPressed: () {
                          Navigator.pop(context);
                        })),
              ],
            )),
      ],
    );
  }

  Widget buttonWidget(BuildContext context) {
    return Positioned(
        bottom: 10,
        right: 0,
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 3, right: 10),
                height: MediaQuery.of(context).size.height * 0.055,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: AppColor.white50,
                ),
                child: PrimaryButtonWidget(
                    text: AppString.cancel,
                    bgColor: AppColor.buttonBGLightBlueColor,
                    colors: AppColor.blueColor,
                    onPressed: () {
                      Navigator.pop(context); //close Dialog
                      // Navigator.of(context, rootNavigator: true).pop();
                      // Navigator.pop(context);
                    })),
            Container(
                margin: const EdgeInsets.only(top: 3, right: 10),
                height: MediaQuery.of(context).size.height * 0.055,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: AppColor.blueColor),
                child: PrimaryButtonWidget(
                    text: widget.employeeModel != null
                        ? AppString.update
                        : AppString.save,
                    onPressed: () {
                      EmployeeModel empModel = EmployeeModel();
                      if (employeeNameController.text.isEmpty ||
                          employeeNameController.text == "") {
                        SnackBarWidget.buildErrorSnackBar(
                            context, "Please enter employee name!");
                      } else if (dropDownController.text.isEmpty ||
                          dropDownController.text == "") {
                        SnackBarWidget.buildErrorSnackBar(
                            context, "Please select employee role!");
                      } else if (todayDateController.text.isEmpty ||
                          todayDateController.text == "") {
                        SnackBarWidget.buildErrorSnackBar(
                            context, "Please select start date");
                      } else {
                        empModel.employeeName = employeeNameController.text;
                        empModel.employeeRole = dropDownController.text;
                        empModel.startDate = todayDateController.text;
                        empModel.endDate = endDateController.text;
                        if (widget.employeeModel != null) {
                          empModel.id = employeeId;
                        }
                        widget.employeeModel != null
                            ? BlocProvider.of<AddEmployeeDetailsBloc>(context)
                                .add(UpdateEmployeeDataEvent(
                                    employeeModel: empModel))
                            : BlocProvider.of<AddEmployeeDetailsBloc>(context)
                                .add(SaveDataEvent(model: empModel));
                      }
                    })),
          ],
        ));
  }

  Widget _showActionSheet(BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, AppString.productDesigner);
            },
            child: const Text(AppString.productDesigner,
                style: TextStyle(color: AppColor.textBlackColor)),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, AppString.flutterDeveloper);
            },
            child: const Text(AppString.flutterDeveloper,
                style: TextStyle(color: AppColor.textBlackColor)),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, AppString.qaTester);
            },
            child: const Text(AppString.qaTester,
                style: TextStyle(color: AppColor.textBlackColor)),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, AppString.productOwner);
            },
            child: const Text(AppString.productOwner,
                style: TextStyle(color: AppColor.textBlackColor)),
          ),
        ],
      );

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = args.value.toString();
        var date = DateTime.parse(_selectedDate);
        var dateFormatter = DateFormat('dd/MM/yyyy');
        String startDate = dateFormatter.format(date);
        print("_selectData::::$startDate"); // result 2020-03-24
        if (isStartDate == true) {
          print("_selectDataDDDD::::$startDate");
          todayDateController.text = startDate;
          isStartDate = false;
        }
        if(isEndDate == true){
          endDateController.text = startDate;
          isEndDate = false;
        }
        rangePickerController.selectedDate = date;
        print("StartDate:::$_selectedDate");
      } else {
        _rangeCount = args.value.length.toString();
        print("_rangeCount:::$_rangeCount");
      }
    });
  }
}


extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return this.add(
      Duration(
        days: (day - this.weekday) % DateTime.daysPerWeek,
      ),
    );
  }

  DateTime afterWeek(int day) {
    return this.add(
      Duration(
        days: day,
      ),
    );
  }
}
