import 'package:bottom_picker/resources/context_extension.dart';
import 'package:bottom_picker/widgets/date_picker.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'package:bottom_picker/resources/time.dart';

class CustomBottomSheetTimePicker extends StatefulWidget {
  const CustomBottomSheetTimePicker({super.key, required this.onPressOK});
  final Function(DateTime dateTime) onPressOK;

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: false,
      constraints: BoxConstraints(
        maxWidth: context.bottomPickerWidth,
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomSheet(
          backgroundColor: Colors.transparent,
          enableDrag: false,
          onClosing: () {},
          builder: (context) {
            return this;
          },
        );
      },
    );
  }

  @override
  State<CustomBottomSheetTimePicker> createState() =>
      _CustomBottomSheetTimePickerState();
}

class _CustomBottomSheetTimePickerState
    extends State<CustomBottomSheetTimePicker> {
  DateTime now = DateTime.now();
  late DateTime selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      height: size.height/2.2,
      decoration: BoxDecoration(
        color: beige100,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Text(
              "Термін виконання",
              style: TextStyle(fontSize: 24, color: primaryText),
            ),
            Expanded(
                child: DatePicker(
              initialDateTime: DateTime(now.year, now.month, now.day, now.hour,
                  (now.minute % 5 * 5).toInt()),
              minuteInterval: 5,
              mode: CupertinoDatePickerMode.time,
              onDateChanged: (DateTime date) {
                selectedDateTime=date;
              },
              use24hFormat: true,
              textStyle: TextStyle(fontSize: 28, color: primary800),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Скасувати",
                      style: TextStyle(fontSize: 22, color: primary700),
                    ),
                  ),
                ),
                const SizedBox(width: 24,),
                GestureDetector(
                  onTap: (){
                    widget.onPressOK(selectedDateTime);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 22, color: primary700),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
