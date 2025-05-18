import 'package:flutter/material.dart';
import 'package:inventorisation_app/data/models/equipment.dart';
import 'package:provider/provider.dart';

class InventoryList extends StatelessWidget {
  const InventoryList({super.key});

  @override
  Widget build(BuildContext context) {  
    final equipmentMap = Provider.of<EquipmentModel>(context).equipmentMap;

    return Expanded(
      child: ListView(
        children: equipmentMap.values.map((e) => ListTile(
          title: Text(e.name),
          subtitle: Text('Code: ${e.code}'),
          trailing: Text('${e.actual}/${e.planned}'),
        )).toList(),
      ),
    );
  }
}
