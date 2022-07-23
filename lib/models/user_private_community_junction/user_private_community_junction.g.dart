// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_private_community_junction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPrivateCommunityJunction _$UserPrivateCommunityJunctionFromJson(
        Map<String, dynamic> json) =>
    UserPrivateCommunityJunction(
      privateCommunityId: json['privateCommunityId'] as String,
      userId: json['userId'] as String,
      memberId: json['memberId'] as String,
      roles: UserPrivateCommunityJunction._rolesFromJson(
          json['roles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserPrivateCommunityJunctionToJson(
        UserPrivateCommunityJunction instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'privateCommunityId': instance.privateCommunityId,
      'memberId': instance.memberId,
      'roles': UserPrivateCommunityJunction._rolesToJson(instance.roles),
    };
