import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/classes/TeamVolunteer.dart';
import 'package:flutter_mosharkaty/classes/credentials.dart';
import 'package:flutter_mosharkaty/components/appBars/common_appbar.dart';
import 'package:flutter_mosharkaty/components/buttons/master_btn.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/constants.dart';
import 'package:flutter_mosharkaty/res/spaces.dart';
import 'package:flutter_mosharkaty/res/textUtilities.dart';
import 'package:flutter_mosharkaty/screens/error_success_screens/loading_screen.dart';
import 'package:get/get.dart';

class UploadTeamCodes extends StatefulWidget {
  const UploadTeamCodes({super.key});

  @override
  _UploadTeamCodesState createState() => _UploadTeamCodesState();
}

class _UploadTeamCodesState extends State<UploadTeamCodes> {
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, teamCodes),
      body: Padding(
        padding: paddingHorizontal20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            sBoxHeight8,
            Center(
              child: _uploading
                  ? const ColorLoader()
                  : MasterButton(
                      name: uploadBtnTxt,
                      onTap: () async {
                        FilePickerResult? pickedFile =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowMultiple: false,
                          allowedExtensions: ['xlsx'], //should we add xls ?
                        );

                        /// file might be picked
                        if (pickedFile != null) {
                          setState(() {
                            _uploading = true;
                          });
                          var bytes = pickedFile.files.single.bytes;
                          List<TeamVolunteer> vols = await readTeamExcel(bytes);
                          setState(() {
                            _uploading = false;
                          });
                          if (vols.isNotEmpty) {
                            setState(() {
                              _uploading = true;
                            });
                            await TeamVolunteer.writeTeamSheetToFirebase(vols)
                                .then((value) => setState(() {
                                      _uploading = false;
                                    }));
                          }
                        }
                      },
                    ),
            ),
            const Divider(
              height: 3,
              thickness: 2,
            ),
            sBoxHeight8,
            Center(
              child: Text(
                "الشيت الحالي",
                style: FontStyleUtilities.h3(),
              ),
            ),
            sBoxHeight8,
            // Expanded(
            //   child:
            StreamBuilder(
              stream: teamSheetRef.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  Map<String, dynamic> values = Map<String, dynamic>.from(
                      (snapshot.data!).snapshot.value as Map<String, dynamic>);
                  List<TeamVolunteer> uploadedData = [];
                  values.forEach((key, value) {
                    uploadedData.add(TeamVolunteer.fromSnapshot(value));
                  });
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Rows count : ${uploadedData.length}",
                              style: FontStyleUtilities.h4()),
                          MasterButton(
                            name: exportBtnTxt,
                            onTap: () => downloadTeamExcel(uploadedData),
                            buttonColor: AppColors.successGreen,
                          ),
                        ],
                      ),
                      sBoxHeight8,
                      SizedBox(
                        height: 600,
                        child: ListView.builder(
                          itemCount: uploadedData.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  '${index + 1}. الاسم: ${uploadedData[index].Volname}'),
                              subtitle: Text(
                                  'Code: ${uploadedData[index].code} | الدرجة: ${uploadedData[index].degree}'),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.offerRed,
                                ),
                                onPressed: () {
                                  TeamVolunteer.deleteVolunteer(
                                      uploadedData[index].Volname);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return const ColorLoader();
                }
              },
            ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<List<TeamVolunteer>> readTeamExcel(bytes) async {
    List<TeamVolunteer> allVols = [];
    Excel excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      // print(table); //sheet Name
      // print(excel.tables[table]?.maxColumns);
      // print(excel.tables[table]?.maxRows);
      for (var i = 1;
          i < excel.tables[table]!.rows.length;
          i++) //var row in excel.tables[table]!.rows)
      {
        var row = excel.tables[table]!.rows[i];
        if (row[0]?.value != null &&
            row[1]?.value != null &&
            row[2]?.value != null) {
          switch (row[0]!.value) {
            case TextCellValue():
              // print('  text: ${value.value}');
              break;
            default:
              //non text found
              Get.snackbar(
                "found non text in a name column row $i",
                row[0]!.value.toString(),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.offerRed,
              );
              return [];
          }
          switch (row[1]!.value) {
            case TextCellValue():
              // print('  text: ${value.value}');
              break;
            default:
              //non text found
              Get.snackbar(
                "found non text in a code column row $i",
                row[1]!.value.toString(),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.offerRed,
              );
              return [];
          }
          switch (row[2]!.value) {
            case TextCellValue():
              // print('  text: ${value.value}');
              break;
            default:
              //non text found
              Get.snackbar(
                "found non text in degree column row $i",
                row[2]!.value.toString(),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.offerRed,
              );
              return [];
          }
          allVols.add(TeamVolunteer(
              Volname: row[0]!.value.toString(),
              code: row[1]!.value.toString(),
              degree: row[2]!.value.toString()));
        } else {
          Get.snackbar(
            "found ${allVols.length} rows",
            "لو العدد المفروض يبقي اكتر يبقي في خانة ناقصة عند الصف ${allVols.length + 2}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.successGreen,
          );
          return allVols;
        }
        // for (var cell in row) {
        //   print('cell ${cell?.rowIndex}/${cell?.columnIndex}');
        //   final value = cell?.value;
        //   // final numFormat =
        //   //     cell?.cellStyle?.numberFormat ?? NumFormat.standard_0;
        //   switch (value) {
        //     case null:
        //       print('  empty cell');
        //     // print('  format: ${numFormat}');
        //     case TextCellValue():
        //       print('  text: ${value.value}');
        //     case FormulaCellValue():
        //       print('  formula: ${value.formula}');
        //     // print('  format: ${numFormat}');
        //     case IntCellValue():
        //       print('  int: ${value.value}');
        //     // print('  format: ${numFormat}');
        //     case BoolCellValue():
        //       print('  bool: ${value.value ? 'YES!!' : 'NO..'}');
        //     // print('  format: ${numFormat}');
        //     case DoubleCellValue():
        //       print('  double: ${value.value}');
        //     // print('  format: ${numFormat}');
        //     case DateCellValue():
        //       print(
        //           '  date: ${value.year} ${value.month} ${value.day} (${value.asDateTimeLocal()})');
        //     case TimeCellValue():
        //       print(
        //           '  time: ${value.hour} ${value.minute} ... (${value.asDuration()})');
        //     case DateTimeCellValue():
        //       print(
        //           '  date with time: ${value.year} ${value.month} ${value.day} ${value.hour} ... (${value.asDateTimeLocal()})');
        //   }

        // print('${cell?.value}');
        // }
      }
    }
    return allVols;
  }

  void downloadTeamExcel(List<TeamVolunteer> uploadedList) {
    Excel excel =
        Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    Sheet sheetObject = excel['month_mosharkat'];
    sheetObject.cell(CellIndex.indexByString('A1')).value =
        const TextCellValue('الاسم');
    sheetObject.cell(CellIndex.indexByString('B1')).value =
        const TextCellValue('الكود');
    sheetObject.cell(CellIndex.indexByString('C1')).value =
        const TextCellValue('الدرجة');
    for (int i = 0; i < uploadedList.length; i++) {
      var cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1));
      cell.value = TextCellValue(uploadedList[i].Volname);
      var cell2 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1));
      cell2.value = TextCellValue(uploadedList[i].code);
      var cell3 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1));
      cell3.value = TextCellValue(uploadedList[i].degree);
    }
    excel.delete('Sheet1');
    String fileName = "فريق ${Credentials.userCredentials.branch}";
    excel.save(fileName: '$fileName.xlsx');
  }
}
