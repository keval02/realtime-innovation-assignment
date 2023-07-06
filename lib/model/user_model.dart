class EmployeeModel {
  int? id;
  String? employeeName;
  String? employeeRole;
  String? startDate;
  String? endDate;

  EmployeeModel(
      {this.id,
        this.employeeName,
        this.employeeRole,
        this.startDate,
        this.endDate});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employeeName'];
    employeeRole = json['employeeRole'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employeeName'] = employeeName;
    data['employeeRole'] = employeeRole;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
