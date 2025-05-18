

import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventorisation_app/data/models/equipment.dart';
import 'package:inventorisation_app/features/inventory/inventory_list/view.dart';
import 'package:inventorisation_app/shared/constants/view.dart';
import 'package:inventorisation_app/shared/widgets/widgets.dart';
import 'package:inventorisation_app/utills/view.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  bool isSaveLoading = false;

  @override
  initState() {
    super.initState();
  }

  Future<void> scanBarcode() async {
    try {
      final cameraPermission = await Permission.camera.request();

      if (!cameraPermission.isGranted) {
        NotificationUtil.showNotificationMessage(
          context, 
          InfoMessages.permissionDenied,
          type: NotificationType.info,
        );
        return;
      }

      final scanResult = await BarcodeScanner.scan();
      final code = scanResult.rawContent.trim();

      if (code.isEmpty) {
        NotificationUtil.showNotificationMessage(
          context, 
          InfoMessages.scanningCancelled,
          type: NotificationType.info,
        );
        return;
      }

      Provider.of<EquipmentModel>(context, listen: false).addEquipment(code);
    } catch (error) {
      NotificationUtil.showNotificationMessage(
        context, 
        ErrorMessages.unknown
      );
    }
  }

  Future<void> saveResults() async {
    if (isSaveLoading) return;

    try {
      setState(() {
        isSaveLoading = true;
      });    

      final granted = await PermissionUtil.requestStoragePermission(context);
      
      if (!granted) {
        NotificationUtil.showNotificationMessage(
          context,
          ErrorMessages.permissionRequired,
          type: NotificationType.error,
        );
        return;
      }

      final dir = await FileUtil.getDownloadDirectory();
      final file = File('${dir?.path}/inventory_result.txt');
      final lines = Provider.of<EquipmentModel>(context, listen: false).getEquipmentLines();
      
      await file.writeAsString(lines);

      NotificationUtil.showNotificationMessage(
        context, 
        InfoMessages.documentSaved,
        type: NotificationType.success,
      );
    } catch (error) {
      NotificationUtil.showNotificationMessage(
        context, 
        ErrorMessages.unknown,
        type: NotificationType.error
      );
    } finally {
      setState(() {
        isSaveLoading = false;
      });
    }   
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OverflowBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            SecondaryButton(
              onPressed: Provider.of<EquipmentModel>(context, listen: false).clear, 
              title: 'Clear',
            ),
            PrimaryButton(
              onPressed: scanBarcode, 
              title: 'Scan',
            ),
          ],
        ),
        SizedBox(height: 10),
        InventoryList(),
        SizedBox(height: 10),
        PrimaryButton(
          onPressed: isSaveLoading ? () {} : saveResults, 
          title: 'Save',
          isLoading: isSaveLoading,
        ),
      ]
    );
  }
}