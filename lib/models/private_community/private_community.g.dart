// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateCommunity _$PrivateCommunityFromJson(Map<String, dynamic> json) =>
    PrivateCommunity(
      name: json['name'] as String,
      statistics: PrivateCommunityStatistics.fromJson(
          json['statistics'] as Map<String, dynamic>),
      creationDate: PrivateCommunity._dateTimeFromTimeStamp(
          json['creationDate'] as Timestamp),
    );

Map<String, dynamic> _$PrivateCommunityToJson(PrivateCommunity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'statistics': instance.statistics,
      'creationDate':
          PrivateCommunity._dateTimeToTimeStamp(instance.creationDate),
    };
