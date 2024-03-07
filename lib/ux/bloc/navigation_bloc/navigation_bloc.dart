import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chance_app/ui/constans.dart';
import 'package:chance_app/ui/pages/navigation/navigation_page/components/map_data.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/models/pick_result.dart';
import 'package:chance_app/ui/pages/navigation/place_picker/src/select_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<UpdateMarkers>(_onUpdateMarkers);
    on<UpdatePolyline>(_onUpdatePolyline);
    on<UpdateFirstPickResult>(_onUpdateFirstPickResult);
    on<UpdateSecondPickResult>(_onUpdateSecondPickResult);
    on<BuildRoute>(_onBuildRoute);
  }

  FutureOr<void> _onUpdateMarkers(
      UpdateMarkers event, Emitter<NavigationState> emit) {
    emit(state.copyWith(setMarkers: event.markers));
  }

  FutureOr<void> _onUpdatePolyline(
      UpdatePolyline event, Emitter<NavigationState> emit) {
    emit(state.copyWith(polylines: event.polylines));
  }

  FutureOr<void> _onUpdateFirstPickResult(
      UpdateFirstPickResult event, Emitter<NavigationState> emit) {
    emit(state.copyWith(firstPickResult: event.firstPickResult));
  }

  FutureOr<void> _onUpdateSecondPickResult(
      UpdateSecondPickResult event, Emitter<NavigationState> emit) {
    emit(state.copyWith(secondPickResult: event.secondPickResult));
  }

  FutureOr _onBuildRoute(
      BuildRoute event, Emitter<NavigationState> emit) async {
    PickResult? firstPickResult = state.firstPickResult,
        secondPickResult = state.secondPickResult;
    if (firstPickResult != null && secondPickResult != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      PointLatLng? firstPointLatLng;
      if (firstPickResult.id != "me") {
        try {
          firstPointLatLng = PointLatLng(firstPickResult.geometry!.location.lat,
              firstPickResult.geometry!.location.lng);
        } catch (e) {
          firstPointLatLng = await getPositionOfPoint(firstPickResult);
        }
      } else {
        firstPointLatLng = PointLatLng(firstPickResult.geometry!.location.lat,
            firstPickResult.geometry!.location.lng);
      }
      PointLatLng? secondPointLatLng;
      if (secondPickResult.id != "me") {
        try {
          secondPointLatLng = PointLatLng(
              secondPickResult.geometry!.location.lat,
              secondPickResult.geometry!.location.lng);
        } catch (e) {
          secondPointLatLng = await getPositionOfPoint(secondPickResult);
        }
      } else {
        secondPointLatLng = PointLatLng(secondPickResult.geometry!.location.lat,
            secondPickResult.geometry!.location.lng);
      }
      if (firstPointLatLng == null || secondPointLatLng == null) {
        return null;
      }
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        firstPointLatLng,
        secondPointLatLng,
      );
      List<LatLng> polylineCoordinates = [];
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
      Polyline polyline = Polyline(
        polylineId: const PolylineId("route"),
        color: red900,
        points: polylineCoordinates,
        width: 3,
      );
      Set<Polyline> polylines = {};
      polylines.add(polyline);
      BitmapDescriptor? bitmapDescriptor =
      await getMarkerIcon(PickResultFor.first);
      Marker? pointA;
      if (bitmapDescriptor != null) {
        pointA = Marker(
            markerId: const MarkerId("point_a"),
            draggable: false,
            position:
            LatLng(firstPointLatLng.latitude, firstPointLatLng.longitude),
            icon: bitmapDescriptor,
            infoWindow: InfoWindow(
                title: firstPickResult.name,
                snippet: firstPickResult.formattedAddress,
                onTap: () {
                  mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                      LatLng(firstPointLatLng!.latitude,
                          firstPointLatLng.longitude),
                      18));
                }));
      }
      Set<Marker> setMarkers = {};
      if (pointA != null) {
        setMarkers.add(pointA);
      }
      Marker? pointB;
      bitmapDescriptor = await getMarkerIcon(PickResultFor.second);
      if (bitmapDescriptor != null) {
        pointB = Marker(
            markerId: const MarkerId("point_B"),
            draggable: false,
            position:
            LatLng(secondPointLatLng.latitude, secondPointLatLng.longitude),
            icon: bitmapDescriptor,
            infoWindow: InfoWindow(
                title: secondPickResult.name,
                snippet: secondPickResult.formattedAddress,
                onTap: () {
                  mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                      LatLng(secondPointLatLng!.latitude,
                          secondPointLatLng.longitude),
                      18));
                }));
      }
      if (pointB != null) {
        setMarkers.add(pointB);
      }
      emit(state.copyWith(setMarkers: setMarkers, polylines: polylines));
    }
  }
}