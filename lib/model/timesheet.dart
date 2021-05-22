class Timesheet {
  Id iId;
  String assignees;
  bool currentUserIsReviewer;
  bool currentUserIsReviewerForProject;
  double hours;
  Null hoursFriday;
  Null hoursMonday;
  Null hoursThursday;
  Null hoursTuesday;
  Null hoursWednesday;
  int id;
  bool protected;
  bool rejected;
  Null rejectReason;
  bool review;
  String sheetUserDisplay;
  String sheetUserName;
  String startOfWeek;
  int weekOfYear;
  int year;

  bool released;


  Timesheet({
      this.iId,
      this.assignees,
      this.currentUserIsReviewer,
      this.currentUserIsReviewerForProject,
      this.hours,
      this.hoursFriday,
      this.hoursMonday,
      this.hoursThursday,
      this.hoursTuesday,
      this.hoursWednesday,
      this.id,
      this.protected,
      this.rejected,
      this.rejectReason,
      this.review,
      this.sheetUserDisplay,
      this.sheetUserName,
      this.startOfWeek,
      this.weekOfYear,
      this.year, this.released});

  Timesheet.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    assignees = json['Assignees'];
    currentUserIsReviewer = json['CurrentUserIsReviewer'];
    currentUserIsReviewerForProject = json['CurrentUserIsReviewerForProject'];
    hours = json['Hours'];
    hoursFriday = json['HoursFriday'];
    hoursMonday = json['HoursMonday'];
    hoursThursday = json['HoursThursday'];
    hoursTuesday = json['HoursTuesday'];
    hoursWednesday = json['HoursWednesday'];
    id = json['Id'];
    protected = json['Protected'];
    rejected = json['Rejected'];
    rejectReason = json['RejectReason'];
    review = json['Review'];
    sheetUserDisplay = json['SheetUserDisplay'];
    sheetUserName = json['SheetUserName'];
    startOfWeek = json['StartOfWeek'];
    weekOfYear = json['WeekOfYear'];
    year = json['Year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId.toJson();
    }
    data['Assignees'] = this.assignees;
    data['CurrentUserIsReviewer'] = this.currentUserIsReviewer;
    data['CurrentUserIsReviewerForProject'] =
        this.currentUserIsReviewerForProject;
    data['Hours'] = this.hours;
    data['HoursFriday'] = this.hoursFriday;
    data['HoursMonday'] = this.hoursMonday;
    data['HoursThursday'] = this.hoursThursday;
    data['HoursTuesday'] = this.hoursTuesday;
    data['HoursWednesday'] = this.hoursWednesday;
    data['Id'] = this.id;
    data['Protected'] = this.protected;
    data['Rejected'] = this.rejected;
    data['RejectReason'] = this.rejectReason;
    data['Review'] = this.review;
    data['SheetUserDisplay'] = this.sheetUserDisplay;
    data['SheetUserName'] = this.sheetUserName;
    data['StartOfWeek'] = this.startOfWeek;
    data['WeekOfYear'] = this.weekOfYear;
    data['Year'] = this.year;
    return data;
  }
}

class Id {
  String value;

  Id({this.value});

  Id.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}