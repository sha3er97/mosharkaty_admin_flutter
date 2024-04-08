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
                  // Map<dynamic, dynamic> values = Map<dynamic, dynamic>.from(
                  //     (snapshot.data!).snapshot.value as Map<dynamic, dynamic>);
                  // print((snapshot.data!).snapshot.value);

                  // values.forEach((key, value) {
                  //   uploadedData.add(NormalVolunteer.fromSnapshot(value));
                  // });
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
                      await NormalVolunteer.addVolunteer(
                        _phoneController.text,
                        _nameController.text,
                        lastId + 1,
                      );
                      setState(() {
                        _nameController.clear();
                        _phoneController.clear();
                      });
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
}
