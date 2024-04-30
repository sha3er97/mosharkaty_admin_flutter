import 'package:flutter/material.dart';
import 'package:flutter_mosharkaty/classes/Meeting.dart';
import 'package:flutter_mosharkaty/res/colors.dart';
import 'package:flutter_mosharkaty/res/constants.dart';

class DownloadMeetingsDialog extends StatefulWidget {
  const DownloadMeetingsDialog({super.key});

  @override
  _DownloadMeetingsDialogState createState() => _DownloadMeetingsDialogState();
}

class _DownloadMeetingsDialogState extends State<DownloadMeetingsDialog> {
  int selectedMonth = DateTime.now().month;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'اختر شهرًا لتحميل الاجتماعات',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.newBlueDark,
          fontFamily: 'Master',
        ),
      ),
      content: DropdownButton<int>(
        value: selectedMonth,
        isExpanded: true,
        dropdownColor: AppColors.offWhite,
        borderRadius: const BorderRadius.all(Radius.circular(defaultPadding)),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.newBlueDark,
        ),
        iconSize: dropDownArrowSize,
        underline: const SizedBox(),
        hint: const Text('اختر شهرًا'),
        onChanged: (int? newValue) {
          setState(() {
            selectedMonth = newValue!;
          });
        },
        items: arabicMonths.entries.map<DropdownMenuItem<int>>((entry) {
          return DropdownMenuItem<int>(
            value: entry.key,
            child: Text(
              entry.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.newBlueDark,
                fontFamily: 'Master',
              ),
            ),
          );
        }).toList(),
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
            // Perform download action with selectedMonth parameter
            print('Downloading sheet for month $selectedMonth');
            setState(() {
              isLoading = true;
            });
            await Meeting.downloadMeetingsForMonth(selectedMonth)
                .then((value) => Navigator.of(context).pop());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.successGreen,
          ),
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text(
                  'تأكيد',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
        ),
      ],
    );
  }
}
