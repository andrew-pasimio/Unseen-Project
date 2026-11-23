//page for managing all devices
import 'package:flutter/material.dart';

class DeviceManagerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Device Manager'),
      ),
      body: Center(child: Text('Manage your devices here')),
    );
  }
}
