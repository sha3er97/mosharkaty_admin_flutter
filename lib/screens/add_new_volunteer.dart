import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/classes/NormalVolunteer.dart';
import 'package:flutter_mosharkaty/components/appBars/common_appbar.dart';
import 'package:flutter_mosharkaty/components/buttons/master_btn.dart';
import 'package:flutter_mosharkaty/components/textFields/textFieldWithTitle.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/constants.dart';
import 'package:flutter_mosharkaty/res/spaces.dart';
import 'package:flutter_mosharkaty/res/utility_funcs.dart';
import 'package:flutter_mosharkaty/screens/error_success_screens/loading_screen.dart';
import 'package:get/get.dart';

class AddNewVolunteer extends StatefulWidget {
  const AddNewVolunteer({super.key});

  @override
  _AddNewVolunteerState createState() => _AddNewVolunteerState();
}

class _AddNewVolunteerState extends State<AddNewVolunteer> {
  int lastId = -1;
  bool _name_validate = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  List<String> names = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, newVolunteer),
      body: Padding(
        padding: paddingHorizontal20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                      uploadedData
                          .add(NormalVolunteer.fromSnapshot(snapshotValue[i]));
                    }
                  }
                  if (uploadedData.isNotEmpty) {
                    names = uploadedData
                        .map((volunteer) => volunteer.Volname)
                        .toList();
                    // print("length = ${names.length}");
                  }
                  lastId = uploadedData.last.id;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        ":اخر متطوع في الشيت",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          '${uploadedData.last.id}. الاسم: ${uploadedData.last.Volname}',
                        ),
                        subtitle: Text(
                          'Months: ${uploadedData.last.months_count} | الدرجة: ${uploadedData.last.motabaa}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.offerRed,
                          ),
                          onPressed: () {
                            NormalVolunteer.deleteVolunteer(
                                uploadedData.last.id);
                          },
                        ),
                      )
                    ],
                  );
                  //   ListView.builder(
                  //   itemCount: uploadedData.length,
                  //   itemBuilder: (context, index) {
                  //     return ListTile(
                  //       title: Text(
                  //           '${uploadedData[index].id}. الاسم: ${uploadedData[index].Volname}'),
                  //       subtitle: Text(
                  //           'Months: ${uploadedData[index].months_count} | الدرجة: ${uploadedData[index].motabaa}'),
                  //     );
                  //   },
                  // );
                } else {
                  return const ColorLoader();
                }
              },
              // ),
            ),
            const Divider(
              height: 3,
              thickness: 2,
            ),
            sBoxHeight8,
            TextFieldWithTitle(
              title: "الاسم",
              // errorText: _name_validate ? 'Name Can\'t Be Empty' : null,
              controller: _nameController,
              keyboardType: TextInputType.text,
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "newJf",
                color: AppColors.newBlueDark, //isDark ? kcwhite : Colors.black,
                fontSize: 17,
              ),
              style: const TextStyle(
                  fontSize: 17,
                  color: AppColors.newBlueDark,
                  //isDark ? kcwhite : kcNestedTabcolor,
                  fontFamily: 'newJf',
                  fontWeight: FontWeight.w600),
            ),
            sBoxHeight16,
            TextFieldWithTitle(
              title: "التليفون",
              // errorText: _name_validate ? 'Name Can\'t Be Empty' : null,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              titleStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "newJf",
                color: AppColors.newBlueDark, //isDark ? kcwhite : Colors.black,
                fontSize: 17,
              ),
              style: const TextStyle(
                  fontSize: 17,
                  color: AppColors.newBlueDark,
                  //isDark ? kcwhite : kcNestedTabcolor,
                  fontFamily: 'newJf',
                  fontWeight: FontWeight.w600),
            ),
            sBoxHeight16,
            Padding(
              padding: paddingHorizontal20,
              child: Center(
                child: MasterButton(
                  name: newVolunteer,
                  onTap: () async {
                    setState(() {
                      _name_validate = emptyField(_nameController.text);
                    });
                    if (!_name_validate) {
                      if (names.contains(_nameController.text.trim())) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text(
                                    'الاسم مكرر انت متاكد انك عايز تضيفه ؟',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.newBlueDark,
                                      fontFamily: 'Master',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'إلغاء',
                                        style: TextStyle(
                                          color: AppColors.offerRed,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await addVolunteerMethod().then(
                                            (value) =>
                                                Navigator.of(context).pop());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.successGreen,
                                      ),
                                      child: const Text(
                                        'تأكيد',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                      } else {
                        //not duplicate
                        if (lastId == -1) {
                          Get.snackbar(
                            "Error",
                            "sheet didn't finish loading",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColors.offerRed,
                          );
                        } else {
                          await addVolunteerMethod();
                        }
                      }
                    } else {
                      Get.snackbar(
                        "Form Error",
                        "الاسم مينفعش يكون فاضي",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.offerRed,
                      );
                    }
                  },
                ),
              ),
            ),
            sBoxHeight8,
          ],
        ),
      ),
    );
  }

  Future<void> addVolunteerMethod() async {
    await NormalVolunteer.addVolunteer(
      _phoneController.text.trim(),
      _nameController.text.trim(),
      lastId + 1,
    );
    setState(() {
      _nameController.clear();
      _phoneController.clear();
    });
  }
}
