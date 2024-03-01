import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/components/map_data.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/controllers/autocomplete_search_controller.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/providers/place_provider.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/autocomplete_search.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/place_picker.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/select_place.dart';
import 'package:chance_app/ux/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:chance_app/ux/model/me_user.dart';
import 'package:chance_app/ux/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

enum MenuItems {
  add,
}

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar(
      {super.key, required this.appBarKey, required this.width});

  final GlobalKey appBarKey;
  final double width;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late final Future<PlaceProvider> _futureProvider;
  PlaceProvider? provider;
  SearchBarController searchBarController = SearchBarController();
  MeUser meUser = Repository().user!;
  List<Map<String, dynamic>> predictionsForMapView = [];
  List<Prediction> predictionsForTapMapView = [];
  bool isPredictionsShow = false;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<PickResult> savedAddresses = Repository()
      .savedAddresses
      .where((element) => element.isRecentlySearched == true)
      .toList();
  MenuController menuController = MenuController();

  @override
  void initState() {
    _futureProvider = _initPlaceProvider();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Future<PlaceProvider> _initPlaceProvider() async {
    final headers = await const GoogleApiHeaders().getHeaders();
    final provider = PlaceProvider(
      googleAPIKey,
      null,
      null,
      headers,
    );
    provider.sessionToken = const Uuid().v4();
    provider.setMapType(
      meUser.mapType == 0
          ? MapType.normal
          : meUser.mapType == 1
              ? MapType.terrain
              : MapType.hybrid,
    );
    return provider;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PlaceProvider>(
        future: _futureProvider,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            provider = snapshot.data;
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider<PlaceProvider>.value(value: provider!),
                ],
                child: SizedBox(
                  width: widget.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: beigeTransparent,
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 6,
                                  color: Colors.black26,
                                  offset: Offset(0, 0),
                                  spreadRadius: 2,
                                  blurStyle: BlurStyle.normal)
                            ],
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: widget.width - 60,
                              child: AutoCompleteSearch(
                                textEditingController: textEditingController,
                                appBarKey: widget.appBarKey,
                                searchBarController: searchBarController,
                                sessionToken: provider!.sessionToken,
                                hintText: "Пошук",
                                searchingText: "Пошук...",
                                focusNode: focusNode,
                                onPicked: (prediction) {
                                  //if (mounted) {
                                  //  _pickPrediction(prediction);
                                  //}
                                },
                                onTap: () {
                                  setState(() {
                                    isPredictionsShow = true;
                                  });
                                },
                                onTapCancel: () {
                                  predictionsForMapView.clear();
                                  predictionsForTapMapView.clear();
                                  isPredictionsShow = false;
                                  setState(() {});
                                },
                                prediction: (predictions) {
                                  predictionsForMapView = predictions
                                      .map((e) => {
                                            "id": e.id,
                                            "description": e.description,
                                            "distanceMeters": e.distanceMeters,
                                          })
                                      .toList();
                                  predictionsForTapMapView = predictions;
                                  setState(() {});
                                },
                              ),
                            ),
                            const Spacer(),
                            PopupMenuButton(
                                child: SvgPicture.asset(
                                  "assets/icons/dots_vertical.svg",
                                  width: 24,
                                  height: 24,
                                ),
                                itemBuilder: (context) =>
                                    MenuItems.values.map((e) {
                                      return PopupMenuItem(
                                        value: e,
                                        child: Text(e.name),
                                        onTap: () {

                                        },
                                      );
                                    }).toList()),
                          ],
                        ),
                      ),
                      if ((predictionsForMapView.isNotEmpty ||
                              savedAddresses.isNotEmpty) &&
                          isPredictionsShow &&
                          focusNode.hasFocus)
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                              color: beigeTransparent,
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 6,
                                    color: Colors.black26,
                                    offset: Offset(0, 0),
                                    spreadRadius: 2,
                                    blurStyle: BlurStyle.normal)
                              ],
                              borderRadius: BorderRadius.circular(16)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: predictionsForMapView.isNotEmpty
                                  ? predictionsForTapMapView.length
                                  : savedAddresses.length,
                              itemBuilder: (context, position) {
                                return GestureDetector(
                                  onTap: () async {
                                    if (predictionsForTapMapView.isNotEmpty) {
                                      await _pickPrediction(
                                              predictionsForTapMapView[
                                                  position])
                                          .then((value) async {
                                        if (value == null) return;
                                        double? lat =
                                                value.geometry?.location.lat,
                                            lng = value.geometry?.location.lng;
                                        PointLatLng? pointLatLng;
                                        if (lat == null || lng == null) {
                                          pointLatLng =
                                              await getPositionOfPoint(value);
                                        } else {
                                          pointLatLng = PointLatLng(lat, lng);
                                        }
                                        if (pointLatLng != null) {
                                          Marker point = Marker(
                                              markerId: const MarkerId("point"),
                                              draggable: false,
                                              position: LatLng(
                                                  pointLatLng.latitude,
                                                  pointLatLng.longitude),
                                              icon: await getMarkerIcon(
                                                      PickResultFor.first) ??
                                                  await BitmapDescriptor.fromAssetImage(
                                                      ImageConfiguration(
                                                          devicePixelRatio:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .devicePixelRatio),
                                                      "assets/icons/point_a.png"),
                                              infoWindow: InfoWindow(
                                                  title: value.name,
                                                  snippet:
                                                      value.formattedAddress,
                                                  onTap: () {
                                                    mapController!.animateCamera(
                                                        CameraUpdate.newLatLngZoom(
                                                            LatLng(
                                                                pointLatLng!
                                                                    .latitude,
                                                                pointLatLng
                                                                    .longitude),
                                                            18));
                                                  }));

                                          await Repository()
                                              .addSavedAddresses(value)
                                              .whenComplete(() {
                                            mapController!.animateCamera(
                                                CameraUpdate.newLatLngZoom(
                                                    LatLng(
                                                        pointLatLng!.latitude,
                                                        pointLatLng.longitude),
                                                    18));

                                            predictionsForMapView.clear();
                                            predictionsForTapMapView.clear();
                                            isPredictionsShow = false;
                                            textEditingController.text =
                                                value.formattedAddress!;
                                            BlocProvider.of<NavigationBloc>(
                                                    context)
                                                .add(UpdateMarkers(
                                                    markers: {point}));
                                            focusNode.unfocus();
                                          });
                                        }
                                      });
                                    } else {
                                      Marker point = Marker(
                                          markerId: const MarkerId("point"),
                                          draggable: false,
                                          position: LatLng(
                                              savedAddresses[position]
                                                  .geometry!
                                                  .location
                                                  .lat,
                                              savedAddresses[position]
                                                  .geometry!
                                                  .location
                                                  .lng),
                                          icon: await getMarkerIcon(
                                                  PickResultFor.first) ??
                                              await BitmapDescriptor.fromAssetImage(
                                                  ImageConfiguration(
                                                      devicePixelRatio:
                                                          MediaQuery.of(context)
                                                              .devicePixelRatio),
                                                  "assets/icons/point_a.png"),
                                          infoWindow: InfoWindow(
                                              title:
                                                  savedAddresses[position].name,
                                              snippet: savedAddresses[position]
                                                  .formattedAddress,
                                              onTap: () {
                                                mapController!.animateCamera(
                                                    CameraUpdate.newLatLngZoom(
                                                        LatLng(
                                                            savedAddresses[
                                                                    position]
                                                                .geometry!
                                                                .location
                                                                .lat,
                                                            savedAddresses[
                                                                    position]
                                                                .geometry!
                                                                .location
                                                                .lng),
                                                        18));
                                              }));
                                      mapController!.animateCamera(
                                          CameraUpdate.newLatLngZoom(
                                              LatLng(
                                                  savedAddresses[position]
                                                      .geometry!
                                                      .location
                                                      .lat,
                                                  savedAddresses[position]
                                                      .geometry!
                                                      .location
                                                      .lng),
                                              18));

                                      predictionsForMapView.clear();
                                      predictionsForTapMapView.clear();
                                      isPredictionsShow = false;
                                      textEditingController.text =
                                          savedAddresses[position]
                                              .formattedAddress!;
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(UpdateMarkers(markers: {point}));
                                      focusNode.unfocus();
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: darkNeutral600))),
                                    child: Row(
                                      children: [
                                        Icon(predictionsForTapMapView.isNotEmpty
                                            ? Icons.location_on_outlined
                                            : Icons.access_time),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: Text(
                                          predictionsForMapView.isNotEmpty
                                              ? predictionsForMapView[position]
                                                  ["description"]
                                              : savedAddresses[position]
                                                  .formattedAddress,
                                          style: TextStyle(
                                              fontSize: 16, color: primaryText),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                    ],
                  ),
                ));
          }
          return const SizedBox();
        });
  }

  Future<PickResult?> _pickPrediction(Prediction prediction) async {
    if (provider == null) return null;
    provider!.placeSearchingState = SearchingState.Searching;

    final PlacesDetailsResponse response =
        await provider!.places.getDetailsByPlaceId(
      prediction.placeId!,
      sessionToken: provider!.sessionToken,
    );

    if (response.errorMessage?.isNotEmpty == true ||
        response.status == "REQUEST_DENIED") {
      return null;
    }

    provider!.selectedPlace = getPickResult(response.result);

    provider!.isAutoCompleteSearching = true;

    provider!.placeSearchingState = SearchingState.Idle;
    return provider!.selectedPlace;
  }
}
