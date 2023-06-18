import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PermissionSettingsDialog extends StatelessWidget {
  const PermissionSettingsDialog({
    super.key,
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$type Permission'),
      content: Text(
          '$type permission is required to proceed. Would you like to open the location settings?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await openAppSettings();
            if (context.mounted) Navigator.of(context).pop();
          },
          child: const Text('Open Settings'),
        ),
      ],
    );
  }
}
