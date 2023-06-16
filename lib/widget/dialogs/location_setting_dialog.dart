import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class LocationSettingsDialog extends StatelessWidget {
  const LocationSettingsDialog({super.key,});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location Permission'),
      content: const Text(
          'Location permission is required to proceed. Would you like to open the location settings?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await openAppSettings();
            if(context.mounted) Navigator.of(context).pop();
          },
          child: const Text('Open Settings'),
        ),
      ],
    );
  }


}