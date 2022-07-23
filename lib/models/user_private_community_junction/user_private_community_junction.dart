import 'package:iblood/models/private_community/private_community_roles/private_community_roles.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_private_community_junction.g.dart';

@JsonSerializable()
class UserPrivateCommunityJunction {
  String userId, privateCommunityId, memberId;
  @JsonKey(fromJson: _rolesFromJson, toJson: _rolesToJson)
  PrivateCommunityRoles roles;
  UserPrivateCommunityJunction({
    required this.privateCommunityId,
    required this.userId,
    required this.memberId,
    required this.roles,
  });

  factory UserPrivateCommunityJunction.fromJson(Map<String,dynamic> json) => _$UserPrivateCommunityJunctionFromJson(json);
  Map<String,dynamic> toJson() => _$UserPrivateCommunityJunctionToJson(this);

  static PrivateCommunityRoles _rolesFromJson(Map<String,dynamic> json) => PrivateCommunityRoles.fromJson(json);
  static Map<String,dynamic> _rolesToJson(PrivateCommunityRoles roles) => roles.toJson();
}


