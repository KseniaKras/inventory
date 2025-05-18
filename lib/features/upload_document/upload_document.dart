
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:inventorisation_app/data/models/equipment.dart';
import 'package:inventorisation_app/shared/constants/view.dart';
import 'package:inventorisation_app/shared/widgets/widgets.dart';
import 'package:inventorisation_app/utills/view.dart';
import 'package:provider/provider.dart';

class UploadDocument extends StatefulWidget {
  const UploadDocument({super.key});

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  bool isUploadLoading = false;

  Future<void> loadFile() async {
    try {
    setState(() {
      isUploadLoading = true;
    });

    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final lines = await file.readAsLines();

      Provider.of<EquipmentModel>(context, listen: false).fillEquipments(lines);
    }
    } catch(error) {
      NotificationUtil.showNotificationMessage(
        context, 
        ErrorMessages.unknown,
        type: NotificationType.error
      );
    } finally {
      setState(() {
        isUploadLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PrimaryButton(
            onPressed: loadFile,
            title: 'Upload document',
            isLoading: isUploadLoading,
          ),
        ],
      ),
    );
  }
}

