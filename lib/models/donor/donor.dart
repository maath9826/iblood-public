import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data.dart';

part 'donor.g.dart';

@JsonSerializable()
class Donor {
  // String privateCommunityId;
  // String userId;
  String? phoneNumber;
  String memberId;
  String? name;
  String province;
  String city;
  String bloodGroup;
  Gender gender;
  @JsonKey(fromJson: _dateFromJson)
  final DateTime? creationDate;
  Donor({
    required this.bloodGroup,
    required this.province,
    required this.city,
    required this.memberId,
    required this.gender,
    this.name,
    this.creationDate,
    this.phoneNumber,
  });


  factory Donor.fromJson(Map<String, dynamic> data) => _$DonorFromJson(data);
  Map<String, dynamic> toJson() => _$DonorToJson(this);

  static DateTime _dateFromJson(Timestamp value) => value.toDate();

  List<DonorDetail> get details{
    return [
      DonorDetail(value: name!, key: 'name'),
      DonorDetail(value: bloodGroup, key: 'blood group'),
      DonorDetail(value: province, key: 'location'),
      DonorDetail(value: city, key: 'city'),
      if(phoneNumber != null && phoneNumber!.isNotEmpty) DonorDetail(value: phoneNumber!, key: 'phone number'),
    ];
  }
}

class DonorDetail {
  final String key;
  final String value;

  DonorDetail({required this.value, required this.key,});
}