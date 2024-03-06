import 'package:chance_app/ui/constans.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({
    super.key,
    required this.text,
    required this.isMine,
  });

  final String text;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    return Align(
      alignment: isMine ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 4.0),
        constraints: BoxConstraints(
          minWidth: screenSize.width * 0.3,
          maxWidth: screenSize.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: darkNeutral300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8.0),
            topRight: const Radius.circular(8.0),
            bottomRight: isMine ? Radius.zero : const Radius.circular(8.0),
            bottomLeft: isMine ? const Radius.circular(8.0) : Radius.zero,
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Олег',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 20 / 14,
                letterSpacing: 0.1,
                color: darkNeutral1000,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 20 / 14,
                letterSpacing: 0.25,
                color: darkNeutral1000,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              DateFormat('hh:mm').format(DateTime.now()),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11,
                height: 16 / 11,
                letterSpacing: 0.5,
                color: darkNeutral1000.withOpacity(.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
