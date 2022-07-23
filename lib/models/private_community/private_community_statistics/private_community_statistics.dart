import 'package:json_annotation/json_annotation.dart';

part 'private_community_statistics.g.dart';

@JsonSerializable()
class PrivateCommunityStatistics {
  int totalMembers, totalDonors, females, males, femaleDonors, maleDonors;
  Map<String, int> bloodGroupsNumbers;

  PrivateCommunityStatistics({
    required this.totalMembers,
    required this.totalDonors,
    required this.females,
    required this.males,
    required this.femaleDonors,
    required this.maleDonors,
    required this.bloodGroupsNumbers,
  });

  factory PrivateCommunityStatistics.fromJson(Map<String,dynamic> json) => _$PrivateCommunityStatisticsFromJson(json);
  Map<String,dynamic> toJson() => _$PrivateCommunityStatisticsToJson(this);

}
