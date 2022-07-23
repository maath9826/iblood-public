import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:iblood/models/user/user_roles/user_roles.dart';
import 'package:iblood/providers/users_provider.dart';
import 'package:json_annotation/json_annotation.dart';

import '../detail.dart';

part 'user.g.dart';

@JsonSerializable()
class User with ChangeNotifier{
  String? clientId;
  String userName;
  String email;
  @JsonKey(fromJson: _rolesFromJson, toJson: _rolesToJson)
  UserRoles roles;
  @JsonKey(fromJson: _dateFromJson)
  final DateTime? creationDate;
  User({
    required this.userName,
    required this.email,
    required this.roles,
    this.creationDate,
    this.clientId,
  });

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  static DateTime _dateFromJson(Timestamp value) => value.toDate();

  static UserRoles _rolesFromJson(Map<String,dynamic> json) => UserRoles.fromJson(json);
  static Map<String,dynamic> _rolesToJson(UserRoles roles) => roles.toJson();

  List<Detail> get details {
    return [
      Detail(value: email, key: 'email'),
      // Detail(value: bloodGroup, key: 'blood group'),
      // Detail(value: location, key: 'location'),
      // Detail(value: gender.toString().split('.')[1], key: 'gender'),
      // if (phoneNumber != null && phoneNumber!.isNotEmpty)
      //   Detail(value: phoneNumber!, key: 'phone number'),
    ];
  }

  get jsonEncodable {
    var jsonEncodedUser = toJson();
    jsonEncodedUser['creationDate'] = creationDate.toString();
    return jsonEncodedUser;
  }

  factory User.fromInternalLinkedHashMap(Map<String, dynamic> json) => User(
        // bloodGroup: json['bloodGroup'] as String,
        // location: json['location'] as String,
        creationDate: DateTime.parse(json['creationDate']),
        // gender: $enumDecode(_$GenderEnumMap, json['gender']),
        userName: json['userName'] as String,
        email: json['email'] as String,
        // phoneNumber: json['phoneNumber'] as String?,
        clientId: json['clientId'] as String?,
        roles: UserRoles.fromJson(json['roles']),
      );

  activateUser(String userId,String clientId) async {
    try{
      await UsersProvider().update(
        userId,
        {"clientId": clientId},
      );
      this.clientId = clientId;
      notifyListeners();
      print('user activeeeeeeeeeeeee');
    }catch(e){
      rethrow;
    }
  }
}
