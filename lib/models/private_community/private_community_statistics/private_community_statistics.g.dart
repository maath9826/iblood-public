// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_community_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateCommunityStatistics _$PrivateCommunityStatisticsFromJson(
        Map<String, dynamic> json) =>
    PrivateCommunityStatistics(
      totalMembers: json['totalMembers'] as int,
      totalDonors: json['totalDonors'] as int,
      females: json['females'] as int,
      males: json['males'] as int,
      femaleDonors: json['femaleDonors'] as int,
      maleDonors: json['maleDonors'] as int,
      bloodGroupsNumbers:
          Map<String, int>.from(json['bloodGroupsNumbers'] as Map),
    );

Map<String, dynamic> _$PrivateCommunityStatisticsToJson(
        PrivateCommunityStatistics instance) =>
    <String, dynamic>{
      'totalMembers': instance.totalMembers,
      'totalDonors': instance.totalDonors,
      'females': instance.females,
      'males': instance.males,
      'femaleDonors': instance.femaleDonors,
      'maleDonors': instance.maleDonors,
      'bloodGroupsNumbers': instance.bloodGroupsNumbers,
    };
