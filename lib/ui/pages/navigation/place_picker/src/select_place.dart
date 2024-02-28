import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/components/map_data.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/place_picker.dart';
import 'package:chance_app/ux/position_controller.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum PickResultFor { first, second }

class SelectPlace extends StatefulWidget {
  const SelectPlace({super.key, required this.pickResultFor});

  final PickResultFor pickResultFor;

  @override
  State<SelectPlace> createState() => _SelectPlaceState();
}

class _SelectPlaceState extends State<SelectPlace> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  List<PickResult> savedAddresses = Repository()
      .savedAddresses
      .where((element) => element.isRecentlySearched == true)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: beigeBG,
                    border: Border(
                        bottom: BorderSide(color: darkNeutral600, width: 0.1))),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: darkNeutral600)),
                      child: Row(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SizedBox(
                            height: 44,
                            width: 44,
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
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  textInputAction: TextInputAction.search,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Пошук"),
                                )))
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Position? position = PositionController.myPosition;

                        //if (position != null) {
                        //  switch (widget.pickResultFor) {
                        //    case PickResultFor.first:
                        //      firstPickResult = position;
                        //      break;
                        //    case PickResultFor.second:
                        //      secondPickResult = result;
                        //      break;
                        //  }
                        //}
                      },
                      child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: darkNeutral600)),
                      child:  Row(
                          children: [
                            const Icon(Icons.my_location),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Використовувати моє місцезнаходження",
                              style:
                                  TextStyle(fontSize: 14, color: primaryText),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Position? position = PositionController.myPosition;

                        if (position != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey: googleAPIKey,
                                onPlacePicked: (result) async {
                                  switch (widget.pickResultFor) {
                                    case PickResultFor.first:
                                      firstPickResult = result;
                                      break;
                                    case PickResultFor.second:
                                      secondPickResult = result;

                                      break;
                                  }
                                  print("${result.geometry?.bounds};${result.geometry?.location}; ${result.geometry?.locationType}; ${result.geometry?.viewport}");
                                  for(var addr in result.addressComponents!){
                                    print("${addr.types}; ${addr.longName}; ${addr.shortName}");
                                  }
                                  await Repository()
                                      .addSavedAddresses(result)
                                      .whenComplete(
                                          () => Navigator.of(context).pop());
                                },
                                initialPosition: LatLng(
                                    position.latitude, position.longitude),
                                useCurrentLocation: true,
                                resizeToAvoidBottomInset:
                                false, // only works in page mode, less flickery, remove if wrong offsets
                              ),
                            ),
                          );
                        }
                      },
                      child:Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: darkNeutral600)),
                      child:  Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Обрати на мапі",
                              style:
                                  TextStyle(fontSize: 14, color: primaryText),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: beigeTransparent,
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: beigeBG,
                    border: Border(
                        top: BorderSide(color: darkNeutral600, width: 0.1))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Недавні",
                      style: TextStyle(fontSize: 16, color: primaryText),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: savedAddresses.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, position) {
                          return Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: darkNeutral600),
                                child: const Icon(Icons.access_time),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Column(
                                children: [],
                              ),
                            ],
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
