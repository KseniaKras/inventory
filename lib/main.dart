import 'package:flutter/material.dart';
import 'package:inventorisation_app/app.dart';
import 'package:inventorisation_app/data/models/equipment.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EquipmentModel(), 
      child: const App()),
  );
}
