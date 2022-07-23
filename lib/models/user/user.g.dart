// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userName: json['userName'] as String,
      email: json['email'] as String,
      roles: User._rolesFromJson(json['roles'] as Map<String, dynamic>),
      creationDate: User._dateFromJson(json['creationDate'] as Timestamp),
      clientId: json['clientId'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'clientId': instance.clientId,
      'userName': instance.userName,
      'email': instance.email,
      'roles': User._rolesToJson(instance.roles),
      'creationDate': instance.creationDate?.toIso8601String(),
    };
