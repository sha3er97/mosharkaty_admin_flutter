import 'package:firebase_database/firebase_database.dart';
import 'package:excel/excel.dart';
import 'package:flutter_mosharkaty/res/constants.dart';

class Meeting {
  final String count;
  final String date;
  final String description;
  final String from;
  final String head;
  final String headRole;
  final String location;
  final String reason;
  final String to;
  final String type;

  Meeting({
    required this.count,
    required this.date,
    required this.description,
    required this.from,
    required this.head,
    required this.headRole,
    required this.location,
    required this.reason,
    required this.to,
    required this.type,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      count: json['count'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      from: json['from'] ?? '',
      head: json['head'] ?? '',
      headRole: json['head_role'] ?? '',
      location: json['location'] ?? '',
      reason: json['reason'] ?? '',
      to: json['to'] ?? '',
      type: json['type'] ?? '',
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'count': count,
  //     'date': date,
  //     'description': description,
  //     'from': from,
  //     'head': head,
  //     'head_role': headRole,
  //     'location': location,
  //     'reason': reason,
  //     'to': to,
  //     'type': type,
  //   };
  // }
  static Future<void> downloadMeetingsForMonth(int selectedMonth) async {
    Map<String, List<Meeting>> meetingsMap = {};
    try {
      // Get a reference to the root of your database
      DatabaseReference rootRef = FirebaseDatabase.instance.ref('meetings');

      // Get all branches
      DatabaseEvent branchesSnapshot = await rootRef.once();
      Map<String, dynamic>? branchesData =
          branchesSnapshot.snapshot.value as Map<String, dynamic>?;
      if (branchesData != null) {
        for (String branchName in branchesData.keys) {
          DatabaseReference monthRef =
              rootRef.child(branchName).child(selectedMonth.toString());

          DatabaseEvent meetingsSnapshot = await monthRef.once();
          Map<String, dynamic>? meetingsData =
              meetingsSnapshot.snapshot.value as Map<String, dynamic>?;
          if (meetingsData != null) {
            List<Meeting> meetingsList = [];
            meetingsData.forEach((meetingId, meetingJson) {
              Meeting meeting = Meeting.fromJson(meetingJson);
              meetingsList.add(meeting);
            });
            meetingsMap[branchName] = meetingsList;
          }
        }
      }
      print("fetched ${meetingsMap.length} branches");
      downloadMeetingsAsExcel(meetingsMap, selectedMonth);
    } catch (error) {
      print("Error fetching meetings: $error");
      // Handle error
    }
  }
}

void downloadMeetingsAsExcel(
    Map<String, List<Meeting>> meetingsMap, int selectedMonth) {
  try {
    final excel = Excel.createExcel();
    Sheet sheetObject = excel['Meetings'];

    // Add headers
    sheetObject.appendRow([
      const TextCellValue('الفرع'),
      const TextCellValue('التاريخ'),
      const TextCellValue('اللجنة'),
      const TextCellValue('هيد الاجتماع'),
      const TextCellValue('دوره'),
      const TextCellValue('عدد الحضور'),
      const TextCellValue('من'),
      const TextCellValue('الي'),
      const TextCellValue('مكان الاجتماع'),
      const TextCellValue('سبب الاجتماع'),
      const TextCellValue('محضر الاجتماع'),
    ]);

    // Add data from meetings list
    meetingsMap.forEach((branch, meetings) {
      for (Meeting meeting in meetings) {
        sheetObject.appendRow([
          TextCellValue(branch),
          TextCellValue(meeting.date),
          TextCellValue(meeting.type),
          TextCellValue(meeting.head),
          TextCellValue(meeting.headRole),
          TextCellValue(meeting.count),
          TextCellValue(meeting.from),
          TextCellValue(meeting.to),
          TextCellValue(meeting.location),
          TextCellValue(meeting.reason),
          TextCellValue(meeting.description),
        ]);
      }
    });

    // Save the Excel file
    excel.delete('Sheet1');
    String fileName = "اجتماعات_ ${arabicMonths[selectedMonth]}";
    excel.save(fileName: '$fileName.xlsx');

    // Optionally, open the file after download
    // Process.run('open', ['meetings.xlsx']);

    print('Excel file created successfully!');
  } catch (e) {
    print('Error creating Excel file: $e');
  }
}
