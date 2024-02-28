import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/components/map_view.dart';
import 'package:chance_app/ui/pages/navigation/components/navigation_app_bar.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: beigeBG,
      appBar: NavigationAppBar(
        textEditingController: textEditingController,
        focusNode: focusNode,
      ),
      body: const MapView(),
    );
  }
}
