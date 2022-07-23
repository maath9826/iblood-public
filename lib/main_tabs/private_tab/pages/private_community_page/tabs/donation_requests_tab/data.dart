import 'package:faker/faker.dart';
import 'package:iblood/data.dart';

bool _isRequestsGenerated = false;
List<DonationRequests> _donationRequests = [

];

List<DonationRequests> get donationRequests {
  if(!_isRequestsGenerated) {
    for (var i = 0; i < 10; i++) {
      _donationRequests.add(DonationRequests(
        id: i,
        userId: faker.randomGenerator.integer(10,min: 0),
        phoneNumber: faker.phoneNumber.us(),
        bloodGroup: bloodGroups[faker.randomGenerator.integer(bloodGroups.length, min: 0)],
      ));
    }
    _isRequestsGenerated = true;
  }
  return _donationRequests;
}

class DonationRequests {
  final int id;
  final int userId;
  final String bloodGroup;
  final String phoneNumber;

  DonationRequests({
    required this.id,
    required this.userId,
    required this.phoneNumber,
    required this.bloodGroup,
  });
}


