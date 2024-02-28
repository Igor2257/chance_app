import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';

class SavedAddressesComponent extends StatefulWidget {
  const SavedAddressesComponent({super.key});

  @override
  State<SavedAddressesComponent> createState() =>
      _SavedAddressesComponentState();
}

class _SavedAddressesComponentState extends State<SavedAddressesComponent> {
  List<PickResult> savedAddresses = Repository()
      .savedAddresses
      .where((element) => element.isRecentlySearched == false)
      .toList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: savedAddresses.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, position) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: beigeTransparent),
              child: Center(
                child: Text(savedAddresses[position].name ??
                    ""),
              ),
            );
          }),
    );
  }
}
