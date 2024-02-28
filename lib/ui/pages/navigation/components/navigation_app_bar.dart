import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/components/search_bar.dart';
import 'package:flutter/material.dart';

class NavigationAppBar extends StatefulWidget implements PreferredSizeWidget {
  NavigationAppBar({
    super.key,
    this.elevation,
    this.toolbarHeight,
    this.bottom,
    required this.textEditingController,
    required this.focusNode,
  })  : assert(elevation == null || elevation >= 0.0),
        preferredSize =
            _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);
  final double? elevation;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  @override
  State<NavigationAppBar> createState() => _NavigationAppBarState();

  @override
  final Size preferredSize;
}

class _NavigationAppBarState extends State<NavigationAppBar> {
 late final TextEditingController textEditingController;
 late final FocusNode focusNode;
@override
  void initState() {
  textEditingController=widget.textEditingController;
  focusNode=widget.focusNode;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: widget.preferredSize.height,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: beigeTransparent,boxShadow: const [
                  BoxShadow(
                      blurRadius: 6,
                      color: Colors.black26,
                      offset: Offset(0, 0),
                      spreadRadius: 2,
                      blurStyle: BlurStyle.normal)
                ]),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: primaryText,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomSearchBar(
                textEditingController: textEditingController,
                focusNode: focusNode,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
