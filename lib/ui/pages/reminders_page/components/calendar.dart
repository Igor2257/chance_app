import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/date_element.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
enum SideSwipe{left,right}
class CalendarView extends StatelessWidget {
  CalendarView({super.key});

  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
      List<Map<String, dynamic>> week = List.from(state.week),
          days = List.from(state.days);
      DateTime dateTime = DateTime.now();
      if (state.isCalendarOpened) {
        int count = getCount(days.first["weekDay"].toString());
        for(int i=0;i<count;i++){
          days.insert(0, {"number":-1});
        }
      }
      return AnimatedContainer(
        decoration: BoxDecoration(
            color: darkNeutral600, borderRadius: BorderRadius.circular(16)),
        height: state.isCalendarOpened ? 400 : 146,
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        duration: const Duration(milliseconds: 200),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<RemindersBloc>(context).add(ChangeMonth(sideSwipe: SideSwipe.left));
                    },
                    icon: Icon(Icons.arrow_back_ios, color: primary50)),
                Text(
                  "${getMonthName(state.dateForSwiping?.month ?? 0)}, ${state.dateForSwiping?.year ?? ""}",
                  style: TextStyle(fontSize: 22, color: primary50),
                ),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<RemindersBloc>(context).add(ChangeMonth(sideSwipe: SideSwipe.right));
                    },
                    icon: Icon(Icons.arrow_forward_ios, color: primary50)),
                const Spacer(),
                InkWell(
                  onTap: () {
                    BlocProvider.of<RemindersBloc>(context)
                        .add(ChangeCalendarState());
                  },
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: beige200),
                    child: Center(
                      child: SvgPicture.asset("assets/icons/calendar.svg"),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            state.isCalendarOpened
                ? SizedBox(
                    child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            width: size.width / 8, height: 26,
                            child: Text(
                              "ПН",
                              style: TextStyle(
                                  color: beige0,
                                  fontSize: 16,
                                  letterSpacing: 0.15),
                            ),
                          ),
                           Container(
                            alignment: Alignment.bottomCenter,
                            width: size.width / 8, height: 26,
                            child: Text(
                              "ВТ",
                              style: TextStyle(
                                  color: beige0,
                                  fontSize: 16,
                                  letterSpacing: 0.15),
                            ),
                          ),
                           Container(
                            alignment: Alignment.bottomCenter,
                            width: size.width / 8, height: 26,
                            child: Text(
                              "СР",
                              style: TextStyle(
                                  color: beige0,
                                  fontSize: 16,
                                  letterSpacing: 0.15),
                            ),
                          ),
                           Container(
                            alignment: Alignment.bottomCenter,
                            width: size.width / 8, height: 26,
                            child: Text(
                              "ЧТ",
                              style: TextStyle(
                                  color: beige0,
                                  fontSize: 16,
                                  letterSpacing: 0.15),
                            ),
                          ),
                           Container(
                            alignment: Alignment.bottomCenter,
                            width: size.width / 8, height: 26,
                            child: Text(
                              "ПТ",
                              style: TextStyle(
                                  color: beige0,
                                  fontSize: 16,
                                  letterSpacing: 0.15),
                            ),
                          ),
                           Container(
                            alignment: Alignment.bottomCenter,
                            width: size.width / 8,
                            height: 26,
                            child: Text(
                              "СБ",
                              style: TextStyle(
                                  color: beige0,
                                  fontSize: 16,
                                  letterSpacing: 0.15),
                            ),
                          ),
                           Container(
                            alignment: Alignment.bottomCenter,
                            width: size.width / 8,
                             height: 26,
                            child: Text(
                              "НД",
                              style: TextStyle(
                                  color: beige0,
                                  fontSize: 16,
                                  letterSpacing: 0.15),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: darkNeutral400,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
                        alignment: WrapAlignment.start,
                        children: days.map((e) {
                          if(e["number"]==-1){
                            return SizedBox(
                              height: size.width / 8,
                              width: size.width / 8,
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              BlocProvider.of<RemindersBloc>(context)
                                  .add(SelectedDate(selectedDate: e));
                            },
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  height: size.width / 8,
                                  width: size.width / 8,
                                  alignment: Alignment.center,
                                  decoration:e["isSelected"]
                                      ? BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(90),
                                      color: beige200)
                                      : int.parse(e["number"]) == now.day &&
                                          e["month"] == now.month &&
                                          e["year"] == now.year
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          border: Border.all(color: beige200))
                                      :  null,
                                  child: Text(
                                    e["number"].toString(),
                                    style: TextStyle(
                                        color: e["isSelected"]
                                            ? primaryText
                                            : beige0,
                                        letterSpacing: 0.5,
                                        fontSize: 16),
                                  ),
                                ),
                                if ((e["number"] == dateTime.day.toString()) &&
                                    (e["month"] == dateTime.month) &&
                                    (e["year"] == dateTime.year))
                                  Container(
                                    height: 10,
                                    width: 10,
                                    margin: const EdgeInsets.only(bottom: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(90),
                                        color: primary400),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: week.map((e) {
                      return DateElement(
                        date: e,
                        isCurrentDate:
                            (e["number"] == dateTime.day.toString()) &&
                                (e["month"] == dateTime.month) &&
                                (e["year"] == dateTime.year),
                      );
                    }).toList(),
                  )
          ],
        ),
      );
    });
  }

  int getCount(String weekday) {
    switch (weekday) {
      case 'ПН':
        return 0;
      case 'ВТ':
        return 1;
      case 'СР':
        return 2;
      case 'ЧТ':
        return 3;
      case 'ПТ':
        return 4;
      case 'СБ':
        return 5;
      case 'НД':
        return 6;
      default:
        return 0;
    }
  }
}
