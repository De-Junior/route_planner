import 'package:flutter/foundation.dart';
import '../models/route_plan.dart';
import '../models/stop.dart';

class RoutePlanNotifier extends ChangeNotifier {
  RoutePlan _routePlan;

  RoutePlanNotifier()
      : _routePlan = RoutePlan(
          name: 'My Route',
          stops: [],
        );

  RoutePlan get routePlan => _routePlan;

  bool isValidName(String name) {
    return name.trim().isNotEmpty;
  }

  bool isValidLatitude(double lat) {
    return lat >= -90 && lat <= 90;
  }

  bool isValidLongitude(double lng) {
    return lng >= -180 && lng <= 180;
  }

  bool addStop({
    required String name,
    required double lat,
    required double lng,
  }) {
    if (!isValidName(name) ||
        !isValidLatitude(lat) ||
        !isValidLongitude(lng)) {
      return false;
    }

    final stop = Stop(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      lat: lat,
      lng: lng,
    );

    _routePlan.stops.add(stop);
    notifyListeners();
    return true;
  }

  void deleteStop(String id) {
    _routePlan.stops.removeWhere((stop) => stop.id == id);
    notifyListeners();
  }

  void optimizeStops() {
    _routePlan.stops.sort((a, b) {
      final latCompare = a.lat.compareTo(b.lat);
      if (latCompare != 0) {
        return latCompare;
      }
      return a.lng.compareTo(b.lng);
    });

    notifyListeners();
  }
}