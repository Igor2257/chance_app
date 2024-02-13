import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/reminders_page/components/calendar.dart';
import 'package:chance_app/ux/bloc/reminders_bloc/reminders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

enum Reminders { medicine, tasks }

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  @override
  void initState() {
    BlocProvider.of<RemindersBloc>(context).add(LoadData());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Нагадування"),
        actions: [
          IconButton(onPressed: (){}, icon:SvgPicture.asset("assets/icons/dots_vertical.svg")),
        ],
      ),
      backgroundColor: beigeBG,
      body: Column(children: [
        CalendarView(),
      ],),
    );
  }
}
