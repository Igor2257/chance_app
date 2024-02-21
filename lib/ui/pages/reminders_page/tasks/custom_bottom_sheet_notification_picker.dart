import 'package:bottom_picker/resources/context_extension.dart';
import 'package:chance_app/ui/components/rounded_button.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NotificationsBefore {
  no,
  atTime,
  fiveMinute,
  thirtyMinute,
  oneHour,
  oneDay
}

class CustomBottomSheetNotificationPicker extends StatefulWidget {
  const CustomBottomSheetNotificationPicker({super.key});

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: false,
      showDragHandle: true,
      useSafeArea: false,
      backgroundColor: beige100,
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height/1.2,
        maxWidth: context.bottomPickerWidth,
      ),
      builder: (context) {
        return BottomSheet(
          backgroundColor: beige100,
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
  State<CustomBottomSheetNotificationPicker> createState() =>
      _CustomBottomSheetNotificationPickerState();
}

class _CustomBottomSheetNotificationPickerState
    extends State<CustomBottomSheetNotificationPicker> {
  final int session = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      NotificationsBefore notificationsBefore = state.newNotificationsBefore;
      final List<String> notifications = state.notifications;

      return Column(
        children: [
          Text(
            "Нагадування",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: primaryText),
          ),
          ListView.builder(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: NotificationsBefore.values.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, position) {
                bool isSelected =
                    notificationsBefore == NotificationsBefore.values[position];
                return RoundedButton(
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 48,
                    border: Border.all(color: darkNeutral800),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    onPress: () {
                      BlocProvider.of<RemindersBloc>(context).add(
                          SelectNotificationBefore(
                              notificationsBefore:
                                  NotificationsBefore.values[position],
                              session: session));
                    },
                    color: isSelected ? darkNeutral600 : Colors.transparent,
                    child: Row(
                      children: [
                        Text(
                          notifications[position],
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? primary50 : primaryText,
                          ),
                        ),
                        const Spacer(),
                        if (isSelected)
                          Icon(
                            Icons.done,
                            color: primary50,
                          )
                      ],
                    ));
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  BlocProvider.of<RemindersBloc>(context)
                      .add(CancelNotificationBefore(session: session));
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
              const SizedBox(
                width: 24,
              ),
              GestureDetector(
                onTap: () {
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
          const Spacer(),
        ],
      );
    });
  }
}
