import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iblood/models/detail.dart';
import 'package:iblood/models/user/user_roles/user_roles.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../data.dart';


part 'blood_warehouse.g.dart';

@JsonSerializable()
class BloodWarehouse {
  final int aPos;
  final int aNeg;
  final int bPos;
  final int bNeg;
  final int abPos;
  final int abNeg;
  final int oPos;
  final int oNeg;
  BloodWarehouse({
    required this.aPos,
    required this.aNeg,
    required this.bPos,
    required this.bNeg,
    required this.abPos,
    required this.abNeg,
    required this.oPos,
    required this.oNeg,
  });

  factory BloodWarehouse.fromJson(Map<String, dynamic> data) => _$BloodWarehouseFromJson(data);
}
