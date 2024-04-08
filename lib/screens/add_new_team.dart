import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/classes/TeamVolunteer.dart';
import 'package:flutter_mosharkaty/classes/credentials.dart';
import 'package:flutter_mosharkaty/components/appBars/common_appbar.dart';
import 'package:flutter_mosharkaty/components/buttons/master_btn.dart';
import 'package:flutter_mosharkaty/components/textFields/textFieldWithTitle.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/constants.dart';
import 'package:flutter_mosharkaty/res/constants.dart';
import 'package:flutter_mosharkaty/res/spaces.dart';
import 'package:flutter_mosharkaty/res/textUtilities.dart';
import 'package:flutter_mosharkaty/res/utility_funcs.dart';
import 'package:flutter_mosharkaty/screens/error_success_screens/loading_screen.dart';
import 'package:get/get.dart';

class AddNewTeam extends StatefulWidget {
  const AddNewTeam({super.key});

  @override
  _AddNewTeamState createState() => _AddNewTeamState();
}

class _AddNewTeamState extends State<AddNewTeam> {
  bool _name_validate = false;
  final TextEditingController _nameController = TextEditingController();
  String selectedDegree = degrees[0];
  List<String> codesList = [];

  VoidCallback? onDegreeChange(val) {
    setState(() {
      selectedDegree = val;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, newTeamVolunteer),
      body: Padding(
        padding: paddingHorizontal20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                  codesList =
                      uploadedData.map((volunteer) => volunteer.code).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 400,
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
                  //isDark ? kcwhite : kcnewBlueDark,
                  fontFamily: 'newJf',
                  fontWeight: FontWeight.w600),
            ),
            sBoxHeight16,
            const Text(
              'الدرجة',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "Avenir",
                color: AppColors.newBlueDark, //isDark ? kcwhite : Colors.black,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: paddingHorizontal6,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 6, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.offWhite, width: minimumBorder),
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),

                      // dropdown below..
                      child: DropdownButton<String>(
                        hint: const Text("Degree name"),
                        value: selectedDegree,
                        isExpanded: true,
                        dropdownColor: AppColors.offWhite,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(defaultPadding)),
                        items: degrees.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.newBlueDark,
                                fontFamily: 'Master',
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: onDegreeChange,
                        // add extra sugar..
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.newBlueDark,
                        ),
                        iconSize: dropDownArrowSize,
                        underline: const SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            sBoxHeight20,
            Center(
              child: MasterButton(
                name: newTeamVolunteer,
                onTap: () async {
                  setState(() {
                    _name_validate = emptyField(_nameController.text);
                  });
                  if (!_name_validate) {
                    await TeamVolunteer.addVolunteer(
                      _nameController.text,
                      selectedDegree,
                      codesList,
                    );
                    setState(() {
                      _nameController.clear();
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
            sBoxHeight8,
          ],
        ),
      ),
    );
  }
}
