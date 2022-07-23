// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Donor _$DonorFromJson(Map<String, dynamic> json) => Donor(
      bloodGroup: json['bloodGroup'] as String,
      province: json['province'] as String,
      city: json['city'] as String,
      memberId: json['memberId'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      name: json['name'] as String?,
      creationDate: Donor._dateFromJson(json['creationDate'] as Timestamp),
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$DonorToJson(Donor instance) => <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'memberId': instance.memberId,
      'name': instance.name,
      'province': instance.province,
      'city': instance.city,
      'bloodGroup': instance.bloodGroup,
      'gender': _$GenderEnumMap[instance.gender],
      'creationDate': instance.creationDate?.toIso8601String(),
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
