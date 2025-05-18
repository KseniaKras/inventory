import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static Future<bool> requestStoragePermission(BuildContext context) async {
    if (!Platform.isAndroid) return true;

    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = deviceInfo.version.sdkInt;

    // Android 13+ (SDK >= 33)
    if (sdkInt >= 33) {
      final status = await Permission.storage.request();
      if (status.isGranted) return true;

      _showPermissionDialog(context);
      return false;
    }

    // Android 11–12 (SDK 30–32): use MANAGE_EXTERNAL_STORAGE
    if (sdkInt >= 30) {
      final status = await Permission.manageExternalStorage.status;

      if (status.isGranted) return true;

      final result = await Permission.manageExternalStorage.request();
      if (result.isGranted) return true;

      _showPermissionDialog(context, isManageStorage: true);
      return false;
    }

    // Android 10 and below: regular storage permission
    final storageStatus = await Permission.storage.status;
    if (storageStatus.isGranted) return true;

    final requested = await Permission.storage.request();
    if (requested.isGranted) return true;

    _showPermissionDialog(context);
    return false;
  }

  static void _showPermissionDialog(BuildContext context, {bool isManageStorage = false}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Storage Permission Required'),
        content: Text(
          isManageStorage
              ? 'To access all files on your device, please enable "All files access" in app settings.'
              : 'Please allow storage access in app settings to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
