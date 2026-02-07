import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/route_plan_notifier.dart';
import '../screens/add.stop_screen.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<RoutePlanNotifier>();
    final route = notifier.routePlan;

    return Scaffold(
      appBar: AppBar(
        title: Text(route.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              notifier.optimizeStops();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Stops optimized')),
              );
            },
          ),
        ],
      ),
      body: route.stops.isEmpty
          ? const Center(child: Text('No stops added yet'))
          : ListView.builder(
              itemCount: route.stops.length,
              itemBuilder: (context, index) {
                final stop = route.stops[index];

                return ListTile(
                  title: Text(stop.name),
                  subtitle: Text(
                    'Lat: ${stop.lat}, Lng: ${stop.lng}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      notifier.deleteStop(stop.id);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddStopScreen(),
            ),
          );
        },
      ),
    );
  }
}