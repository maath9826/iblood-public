import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'private_community_roles.g.dart';

@JsonSerializable()
class PrivateCommunityRoles{
  bool isEditor;
  PrivateCommunityRoles({
    this.isEditor = false,
  });

  factory PrivateCommunityRoles.fromJson(Map<String,dynamic> json) => _$PrivateCommunityRolesFromJson(json);
  Map<String,dynamic> toJson() => _$PrivateCommunityRolesToJson(this);
}