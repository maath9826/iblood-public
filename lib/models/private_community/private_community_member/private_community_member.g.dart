// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_community_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateCommunityMember _$PrivateCommunityMemberFromJson(
        Map<String, dynamic> json) =>
    PrivateCommunityMember(
      bloodGroup: json['bloodGroup'] as String,
      province: json['province'] as String,
      creationDate: PrivateCommunityMember._dateFromJson(
          json['creationDate'] as Timestamp),
      birthDate:
          PrivateCommunityMember._dateFromJson(json['birthDate'] as Timestamp),
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      name: json['name'] as String,
      city: json['city'] as String,
      isDonor: json['isDonor'] as bool,
      department: json['department'] as String,
      isAuthBloodGroup: json['isAuthBloodGroup'] as bool,
      isDonatedBefore: json['isDonatedBefore'] as bool,
      job: json['job'] as String,
      grade: json['grade'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$PrivateCommunityMemberToJson(
        PrivateCommunityMember instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender],
      'bloodGroup': instance.bloodGroup,
      'province': instance.province,
      'city': instance.city,
      'department': instance.department,
      'job': instance.job,
      'isDonatedBefore': instance.isDonatedBefore,
      'isAuthBloodGroup': instance.isAuthBloodGroup,
      'isDonor': instance.isDonor,
      'grade': instance.grade,
      'phoneNumber': instance.phoneNumber,
      'creationDate': PrivateCommunityMember._dateToJson(instance.creationDate),
      'birthDate': PrivateCommunityMember._dateToJson(instance.birthDate),
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
