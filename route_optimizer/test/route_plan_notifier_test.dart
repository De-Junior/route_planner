 import 'package:flutter_test/flutter_test.dart';
import 'package:route_optimizer/state/route_plan_notifier.dart';
import 'package:route_optimizer/models/stop.dart';

void main() {
  group('Validation tests', () {
    late RoutePlanNotifier notifier;

    setUp(() {
      notifier = RoutePlanNotifier();
    });

    test('rejects invalid latitude values', () {
      expect(notifier.isValidLatitude(100), false);
      expect(notifier.isValidLatitude(-100), false);
    });

    test('rejects invalid longitude values', () {
      expect(notifier.isValidLongitude(200), false);
      expect(notifier.isValidLongitude(-200), false);
    });

    test('rejects empty stop names', () {
      expect(notifier.isValidName(''), false);
      expect(notifier.isValidName('   '), false);
    });
  });

  group('Optimization tests', () {
    late RoutePlanNotifier notifier;

    setUp(() {
      notifier = RoutePlanNotifier();
    });

    test('sorts stops by latitude ascending', () {
      notifier.routePlan.stops.addAll([
        Stop(id: '1', name: 'A', lat: 10, lng: 0),
        Stop(id: '2', name: 'B', lat: -20, lng: 0),
        Stop(id: '3', name: 'C', lat: 5, lng: 0),
      ]);

      notifier.optimizeStops();

      final stops = notifier.routePlan.stops;
      expect(stops[0].lat, -20);
      expect(stops[1].lat, 5);
      expect(stops[2].lat, 10);
    });

    test('uses longitude as tie-breaker when latitude is equal', () {
      notifier.routePlan.stops.addAll([
        Stop(id: '1', name: 'A', lat: 10, lng: 20),
        Stop(id: '2', name: 'B', lat: 10, lng: 5),
        Stop(id: '3', name: 'C', lat: 10, lng: 15),
      ]);

      notifier.optimizeStops();

      final stops = notifier.routePlan.stops;
      expect(stops[0].lng, 5);
      expect(stops[1].lng, 15);
      expect(stops[2].lng, 20);
    });
  });
}