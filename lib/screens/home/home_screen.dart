import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventorisation_app/data/models/equipment.dart';
import 'package:inventorisation_app/features/inventory/view.dart';
import 'package:inventorisation_app/features/upload_document/view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isEquipmentsExist = Provider.of<EquipmentModel>(context).equipmentMap.entries.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Inventory'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: isEquipmentsExist 
            ? Inventory()
            : UploadDocument(),
        ),
      ),
    );
  }
}
