import 'dart:collection';
import 'package:flutter/material.dart';

class EquipmentModel extends ChangeNotifier {
  final Map<String, Equipment> _equipmentMap = {};

  UnmodifiableMapView<String, Equipment> get equipmentMap => UnmodifiableMapView(_equipmentMap);

  void clear() {
    _equipmentMap.clear();
    notifyListeners();
  }

  void fillEquipments(lines) {
    clear();

    for (var line in lines) {
      final parts = line.split('\t');

      if (parts.length >= 3) {
        final code = parts[0].trim();
        final planned = int.tryParse(parts[1].trim()) ?? 0;
        final name = parts[2].trim();
        _equipmentMap[code] = Equipment(code: code, name: name, planned: planned);
      }
    }
    notifyListeners();
  }

  void addEquipment(String code) {
    if (_equipmentMap.containsKey(code)) {
      _equipmentMap[code]!.actual += 1;
      notifyListeners();
    }
  }

  String getEquipmentLines() {
    final lines = _equipmentMap.values.map((e) =>
      '${e.code}\t${e.actual}\t${e.name}'
    ).join('\n');

    return lines;
  }
}

class Equipment {
  final String code;
  final String name;
  final int planned;
  int actual;

  Equipment({
    required this.code,
    required this.name,
    required this.planned,
    this.actual = 0,
  });
}
