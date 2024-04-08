import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/classes/NormalVolunteer.dart';
import 'package:flutter_mosharkaty/classes/credentials.dart';
import 'package:flutter_mosharkaty/components/appBars/common_appbar.dart';
import 'package:flutter_mosharkaty/components/buttons/master_btn.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/constants.dart';
import 'package:flutter_mosharkaty/res/spaces.dart';
import 'package:flutter_mosharkaty/res/textUtilities.dart';
import 'package:flutter_mosharkaty/screens/error_success_screens/loading_screen.dart';
import 'package:get/get.dart';

class UploadAllSheet extends StatefulWidget {
  const UploadAllSheet({super.key});

  @override
  _UploadAllSheetState createState() => _UploadAllSheetState();
}

class _UploadAllSheetState extends State<UploadAllSheet> {
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, allSheet),
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
                          List<NormalVolunteer> vols =
                              await readAllExcel(bytes);
                          setState(() {
                            _uploading = false;
                          });
                          if (vols.isNotEmpty) {
                            setState(() {
                              _uploading = true;
                            });
                            await NormalVolunteer.writeAllSheetToFirebase(vols)
                                .then((value) => setState(() {
                                      _uploading = false;
                                    }));
                          } else {
                            setState(() {
                              _uploading = false;
                            });
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
              stream: allSheetRef.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  List<NormalVolunteer> uploadedData = [];

                  var snapshotValue = snapshot.data!.snapshot.value;
                  if (snapshotValue is List<dynamic>) {
                    // Exclude the first element (null) and iterate over the remaining elements
                    for (var i = 1; i < snapshotValue.length; i++) {
                      // Process volunteer data
                      // print("we reached $i");
                      uploadedData
                          .add(NormalVolunteer.fromSnapshot(snapshotValue[i]));
                    }
                  }

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
                            onTap: () => downloadAllExcel(uploadedData),
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
                                  '${uploadedData[index].id}. الاسم: ${uploadedData[index].Volname}'),
                              subtitle: Text(
                                  'Months: ${uploadedData[index].months_count} | الدرجة: ${uploadedData[index].motabaa}'),
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
          ],
        ),
      ),
    );
  }

  Future<List<NormalVolunteer>> readAllExcel(bytes) async {
    List<NormalVolunteer> allVols = [];
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
            // row[1]?.value != null &&
            row[3]?.value != null &&
            row[4]?.value != null) {
          switch (row[0]!.value) {
            case IntCellValue():
              // print('  text: ${value.value}');
              break;
            default:
              //non text found
              Get.snackbar(
                "found non number in id column row $i",
                row[0]!.value.toString(),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.offerRed,
              );
              return [];
          }
          switch (row[3]!.value) {
            case TextCellValue():
              // print('  text: ${value.value}');
              break;
            default:
              //non text found
              Get.snackbar(
                "found non text in motabaa column row $i",
                row[3]!.value.toString(),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.offerRed,
              );
              return [];
          }
          switch (row[4]!.value) {
            case IntCellValue():
              // print('  text: ${value.value}');
              break;
            default:
              //non text found
              Get.snackbar(
                "found non number in months column row $i",
                row[4]!.value.toString(),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.offerRed,
              );
              return [];
          }
          allVols.add(NormalVolunteer(
            id: int.parse(row[0]!.value.toString()),
            Volname: row[1]!.value.toString(),
            phone_text: row[2]!.value.toString(),
            motabaa: row[3]!.value.toString(),
            months_count: int.parse(row[4]!.value.toString()),
          ));
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

  void downloadAllExcel(List<NormalVolunteer> uploadedList) {
    Excel excel =
        Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    Sheet sheetObject = excel['all'];
    sheetObject.cell(CellIndex.indexByString('A1')).value =
        const TextCellValue('ID');
    sheetObject.cell(CellIndex.indexByString('B1')).value =
        const TextCellValue('الاسم');
    sheetObject.cell(CellIndex.indexByString('C1')).value =
        const TextCellValue('رقم التليفون');
    sheetObject.cell(CellIndex.indexByString('D1')).value =
        const TextCellValue('المتابعة');
    sheetObject.cell(CellIndex.indexByString('E1')).value =
        const TextCellValue('اجمالي عدد الشهور');
    for (int i = 0; i < uploadedList.length; i++) {
      var cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1));
      cell.value = IntCellValue(uploadedList[i].id);
      var cell2 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1));
      cell2.value = TextCellValue(uploadedList[i].Volname);
      var cell3 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1));
      cell3.value = TextCellValue(uploadedList[i].phone_text);
      var cell4 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1));
      cell4.value = TextCellValue(uploadedList[i].motabaa);
      var cell5 = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1));
      cell5.value = IntCellValue(uploadedList[i].months_count);
    }
    excel.delete('Sheet1');
    String fileName = "شيت متابعة ${Credentials.userCredentials.branch}";
    excel.save(fileName: '$fileName.xlsx');
  }
}
