import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

import '../../../data.dart';
import '../../detail.dart';

part 'private_community_member.g.dart';

@JsonSerializable()
class PrivateCommunityMember with ChangeNotifier {
  // String privateCommunityId;
  // String userId;
  String? userId;
  final String name;
  final Gender gender;
  final String bloodGroup;
  final String province;
  final String city;
  final String department;
  final String job;
  final bool isDonatedBefore;
  final bool isAuthBloodGroup;
  bool isDonor;
  final String? grade;
  final String? phoneNumber;
  // @TimestampConverter()
  @JsonKey(fromJson: _dateFromJson,toJson: _dateToJson)
  final DateTime creationDate;
  @JsonKey(fromJson: _dateFromJson,toJson: _dateToJson)
  final DateTime birthDate;
  PrivateCommunityMember({
    required this.bloodGroup,
    required this.province,
    required this.creationDate,
    required this.birthDate,
    required this.gender,
    required this.name,
    required this.city,
    required this.isDonor,
    required this.department,
    required this.isAuthBloodGroup,
    required this.isDonatedBefore,
    required this.job,
    this.grade,
    this.phoneNumber,
    this.userId,
  });


  factory PrivateCommunityMember.fromJson(Map<String, dynamic> data) => _$PrivateCommunityMemberFromJson(data);
  Map<String, dynamic> toJson() => _$PrivateCommunityMemberToJson(this);

  static DateTime _dateFromJson(Timestamp value) => value.toDate();
  static Timestamp _dateToJson(DateTime value) => Timestamp.fromDate(value);

  changeIsDonor(bool isDonor){
    this.isDonor = isDonor;
    notifyListeners();
  }
}