// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonationRequest _$DonationRequestFromJson(Map<String, dynamic> json) =>
    DonationRequest(
      bloodGroup: json['bloodGroup'] as String,
      phoneNumber: json['phoneNumber'] as String,
      location: json['location'] as String,
      creationDate:
          DonationRequest._dateFromJson(json['creationDate'] as Timestamp),
    );

Map<String, dynamic> _$DonationRequestToJson(DonationRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'bloodGroup': instance.bloodGroup,
      'creationDate': DonationRequest._dateToJson(instance.creationDate),
    };
