import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'donation_request.g.dart';

@JsonSerializable()
class DonationRequest {
  String phoneNumber;
  String location;
  String bloodGroup;
  // @TimestampConverter()
  @JsonKey(fromJson: _dateFromJson,toJson: _dateToJson)
  final DateTime creationDate;
  DonationRequest({
    required this.bloodGroup,
    required this.phoneNumber,
    required this.location,
    required this.creationDate,
  });


  factory DonationRequest.fromJson(Map<String, dynamic> data) => _$DonationRequestFromJson(data);
  Map<String, dynamic> toJson() => _$DonationRequestToJson(this);



  // Map<String, dynamic> toMap() {
  //   return {
  //     'phoneNumber': phoneNumber,
  //     'location': location,
  //     'bloodGroup': bloodGroup,
  //     'creationDate':_creationDate,
  //   };
  // }

  static DateTime _dateFromJson(Timestamp value) => value.toDate();
  static Timestamp _dateToJson(DateTime value) => Timestamp.fromDate(value);
}