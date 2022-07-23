import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'private_community_member/private_community_member.dart';
import 'private_community_statistics/private_community_statistics.dart';

part 'private_community.g.dart';

@JsonSerializable()
class PrivateCommunity {
  final String name;
  final PrivateCommunityStatistics statistics;
  @JsonKey(fromJson: _dateTimeFromTimeStamp, toJson: _dateTimeToTimeStamp,)
  final DateTime creationDate;

  PrivateCommunity({
    required this.name,
    required this.statistics,
    required this.creationDate,
  });

  factory PrivateCommunity.fromJson(Map<String,dynamic> json) => _$PrivateCommunityFromJson(json);
  Map<String,dynamic> toJson() => _$PrivateCommunityToJson(this);

  static DateTime _dateTimeFromTimeStamp(Timestamp timestamp) => timestamp.toDate();
  static Timestamp _dateTimeToTimeStamp(DateTime dateTime) => Timestamp.fromDate(dateTime);
}



