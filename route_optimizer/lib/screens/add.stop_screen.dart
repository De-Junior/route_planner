 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/route_plan_notifier.dart';

class AddStopScreen extends StatefulWidget {
  const AddStopScreen({super.key});

  @override
  State<AddStopScreen> createState() => _AddStopScreenState();
}

class _AddStopScreenState extends State<AddStopScreen> {
  final _nameController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  String? _errorMessage;

  void _saveStop() {
    final notifier = context.read<RoutePlanNotifier>();

    final name = _nameController.text;
    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);

    if (lat == null || lng == null) {
      setState(() {
        _errorMessage = 'Latitude and longitude must be numbers';
      });
      return;
    }

    final success = notifier.addStop(
      name: name,
      lat: lat,
      lng: lng,
    );

    if (!success) {
      setState(() {
        _errorMessage = 'Invalid input values';
      });
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Stop')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _latController,
              decoration: const InputDecoration(labelText: 'Latitude'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _lngController,
              decoration: const InputDecoration(labelText: 'Longitude'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveStop,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}