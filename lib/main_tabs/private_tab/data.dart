import 'package:faker/faker.dart';

bool _isCommunitiesGenerated = false;
// final List<PrivateCommunity> _privateCommunities = [
//   PrivateCommunity(
//     id: 0,
//     usersIds: faker.randomGenerator.numbers(30, 10),
//     label: 'Al-Nahrain Univ.',
//   )
// ];

// get privateCommunities {
//   // if(!_isCommunitiesGenerated) {
//   //   for (var i = 1; i < 10; i++) {
//   //     _privateCommunities.add(PrivateCommunity(
//   //       id: i,
//   //       usersIds: faker.randomGenerator.numbers(30, 10),
//   //       label: faker.company.name(),
//   //     ));
//   //   }
//   //   _isCommunitiesGenerated = true;
//   // }
//   return _privateCommunities;
// }

// List<UniversityMember> universityMembers = [
//   PrivateCommunity(
//     id: 0,
//     label: 'Al-Nahrain Univ.',
//   ),
// ];

// class PrivateCommunity {
//   final int id;
//   final String label;
//   final List<int> usersIds;
//
//   PrivateCommunity({
//     required this.id,
//     required this.usersIds,
//     required this.label,
//   });
// }

// class UniversityMember {
//   final int id;
//   final int userId;
//   final UniversityRole role;
//   final String bloodGroup;
//
//   UniversityMember({
//     required this.id,
//     required this.role,
//     required this.bloodGroup,
//     this.userId,
//   });
// }

// enum BloodGroup{
//   staff,
//   student,
// }
