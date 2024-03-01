part of 'navigation_bloc.dart';

class NavigationState {
  Set<Marker> setMarkers;
  Set<Polyline> polylines;
  PickResult? firstPickResult, secondPickResult;

  NavigationState({
    this.setMarkers = const {},
    this.polylines = const {},
    this.firstPickResult,
    this.secondPickResult,
  });

  NavigationState copyWith({
    Set<Marker>? setMarkers,
    Set<Polyline>? polylines,
    PickResult? firstPickResult,
    secondPickResult,
  }) {
    return NavigationState(
      setMarkers: setMarkers ?? this.setMarkers,
      polylines: polylines ?? this.polylines,
      firstPickResult: firstPickResult ?? this.firstPickResult,
      secondPickResult: secondPickResult ?? this.secondPickResult,
    );
  }
}
