import 'package:faker/faker.dart';

//
// bool _isUsersGenerated = false;
// final List<User> _users = [];
//
// List<User> get users {
//   if (!_isUsersGenerated) {
//     for (var i = 0; i < 30; i++) {
//       _users.add(User(
//         id: i,
//         isVerified: faker.randomGenerator.boolean(),
//         bloodGroup: bloodGroups[
//             faker.randomGenerator.integer(bloodGroups.length, min: 0)],
//         location: governorates[
//             faker.randomGenerator.integer(governorates.length, min: 0)],
//         status: faker.randomGenerator.integer(3, min: 0),
//         userName: faker.person.name(),
//         gender: faker.randomGenerator.integer(2, min: 0),
//         phoneNumber: faker.phoneNumber.us(),
//       ));
//     }
//     _isUsersGenerated = true;
//   }
//   return _users;
// }

var bloodGroupsNumbers = {
  'A+': 0,
  'A-': 0,
  'B+': 0,
  'B-': 0,
  'AB+': 0,
  'AB-': 0,
  'O+': 0,
  'O-': 0,
};
var bloodGroups = [
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-',
];

var governorates = [
  'Al Anbar',
  'Babylon',
  'Baghdad',
  'Basra',
  'Dhi Qar',
  'Diyala',
  'Duhok',
  'Erbil',
  'Karbala',
  'Kirkuk',
  'Maysan',
  'Muthanna',
  'Najaf',
  'Saladin',
  'Sulaymaniyah',
  'Wasit',
];

// class User {
//   final int id;
//   final String userName;
//   final String location;
//   final String bloodGroup;
//   final bool isVerified;
//   final int status;
//   final int gender;
//   final String phoneNumber;
//
//   User({
//     required this.id,
//     required this.userName,
//     required this.location,
//     required this.bloodGroup,
//     required this.isVerified,
//     required this.status,
//     required this.gender,
//     required this.phoneNumber,
//   });
//
//   List<MemberDetail> get details {
//     return [
//       MemberDetail(value: bloodGroup, key: 'blood group'),
//       MemberDetail(value: userName, key: 'name'),
//       MemberDetail(value: location, key: 'location'),
//       MemberDetail(value: phoneNumber, key: 'phone number'),
//       MemberDetail(
//           value: Gender.values[gender].toString().split(".")[1], key: 'gender'),
//     ];
//   }
// }

enum Status {
  available,
  permanentBan,
  temporaryBan,
}
enum Gender { male, female }

var jobs =  [ 'student', 'teacher', 'employee' ];

var departments = [
  'Biomedical Engineering',
  'Civil Engineering',
  'Electronic and Communication Engineering',
  'Mechanical  Engineering',
  'Chemical  Engineering',
  'Computer  Engineering',
  'Laser and Optoelectronics Engineering',
  'Prosthetics and Orthotics Engineering',
  'Architectural Engineering',
];

var grades = [
  'first',
  'second',
  'third',
  'fourth',
  'fifth',
];

enum Role {
  user,
  admin,
}

enum PrivateCommunityRole {
  member,
  editor,
}
// class MemberDetail {
//   final String key;
//   final String value;
//
//   MemberDetail({
//     required this.value,
//     required this.key,
//   });
// }
