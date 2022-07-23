import 'package:json_annotation/json_annotation.dart';

part 'user_roles.g.dart';

@JsonSerializable()
class UserRoles{
  bool isAdmin;
  UserRoles({
    this.isAdmin = false,
  });

  factory UserRoles.fromJson(Map<String,dynamic> json) => _$UserRolesFromJson(json);
  Map<String,dynamic> toJson() => _$UserRolesToJson(this);
}