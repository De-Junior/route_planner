import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/route_plan_notifier.dart';
import 'screens/route_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoutePlanNotifier(),
      child: MaterialApp(
        title: 'Route Optimizer',
        home: const RouteScreen(),
      ),
    );
  }
}