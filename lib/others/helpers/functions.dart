import 'package:iblood/models/donor/donor.dart';
import 'package:iblood/models/private_community/private_community_member/private_community_member.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:intl/intl.dart';
import 'package:iblood/models/private_community/private_community.dart';

import '../../data.dart';
import 'enums.dart';

// List<User> getUsersOfCommunity(List<int> communityUsersIds){
//   return users.where((element) => communityUsersIds.contains(element.id)).toList();
// }

enumToString(dynamic theEnum) {
  return theEnum.toString().split('.')[1];
}

dateTimeToString(DateTime dateTime) {
  return DateFormat.yMMMd().format(dateTime).toString();
}


bool isAssigned(dynamic variable){
  return variable != null && variable != "";
}

String generateRejectionCauseMessage({required RejectionCause cause, String? note,}){
  if(cause == RejectionCause.hbDeficiency){
    return 'Hb deficiency';
  }
  if(cause == RejectionCause.hIV){
    return 'HIV';
  }
  if(cause == RejectionCause.hBV){
    return 'HBV';
  }
  if(cause == RejectionCause.hCV){
    return 'HCV';
  }
  if(cause == RejectionCause.syphilis){
    return 'Syphilis';
  }
  if(cause == RejectionCause.other){
    return note ?? '';
  }
  return '';
}

updateStatisticsForAddMember(PrivateCommunityMember member) async {
  var privateCommunity = PrivateCommunitiesProvider.currentPrivateCommunity!;
  var privateCommunityId =
      PrivateCommunitiesProvider.currentPrivateCommunityId!;
  var privateCommunitiesProvider = PrivateCommunitiesProvider();

  // increase blood group number
  privateCommunity.statistics
          .bloodGroupsNumbers[changeBloodGroupWritingStyle(member.bloodGroup)] =
      privateCommunity.statistics.bloodGroupsNumbers[
              changeBloodGroupWritingStyle(member.bloodGroup)]! +
          1;

  // increase members
  privateCommunity.statistics.totalMembers += 1;
  if (member.gender == Gender.male) {
    privateCommunity.statistics.males += 1;
  } else {
    privateCommunity.statistics.females += 1;
  }

  // send
  await privateCommunitiesProvider.update(
      privateCommunityId, privateCommunity.statistics.toJson());
}

updateStatisticsForDeleteMember(
  PrivateCommunityMember member,
  String memberId,
) async {
  var privateCommunity = PrivateCommunitiesProvider.currentPrivateCommunity!;
  var privateCommunityId =
      PrivateCommunitiesProvider.currentPrivateCommunityId!;
  var privateCommunitiesProvider = PrivateCommunitiesProvider();

  // increase blood group number
  privateCommunity.statistics
          .bloodGroupsNumbers[changeBloodGroupWritingStyle(member.bloodGroup)] =
      privateCommunity.statistics.bloodGroupsNumbers[
              changeBloodGroupWritingStyle(member.bloodGroup)]! -
          1;

  // increase members
  privateCommunity.statistics.totalMembers -= 1;
  if (member.gender == Gender.male) {
    privateCommunity.statistics.males -= 1;
  } else {
    privateCommunity.statistics.females -= 1;
  }

  // send
  await privateCommunitiesProvider.update(
    privateCommunityId,
    privateCommunity.statistics.toJson(),
  );
}

updateStatisticsForAddDonor(Donor donor) async {
  var privateCommunity = PrivateCommunitiesProvider.currentPrivateCommunity!;
  var privateCommunityId =
      PrivateCommunitiesProvider.currentPrivateCommunityId!;
  var privateCommunitiesProvider = PrivateCommunitiesProvider();

  // increase donors
  privateCommunity.statistics.totalDonors += 1;
  if (donor.gender == Gender.male) {
    privateCommunity.statistics.maleDonors += 1;
  } else {
    privateCommunity.statistics.femaleDonors += 1;
  }

  // send
  await privateCommunitiesProvider.update(
    privateCommunityId,
    privateCommunity.statistics.toJson(),
  );
}

updateStatisticsForDeleteDonor(Donor donor) async {
  var privateCommunity = PrivateCommunitiesProvider.currentPrivateCommunity!;
  var privateCommunityId =
      PrivateCommunitiesProvider.currentPrivateCommunityId!;
  var privateCommunitiesProvider = PrivateCommunitiesProvider();

  // increase donors
  privateCommunity.statistics.totalDonors -= 1;
  if (donor.gender == Gender.male) {
    privateCommunity.statistics.maleDonors -= 1;
  } else {
    privateCommunity.statistics.femaleDonors -= 1;
  }

  // send
  await privateCommunitiesProvider.update(
    privateCommunityId,
    privateCommunity.statistics.toJson(),
  );
}

changeBloodGroupWritingStyle(String bloodGroup) {
  return bloodGroupWritingStyle[bloodGroup];
}

var bloodGroupWritingStyle = {
  'A+': 'aPos',
  'A-': 'aNeg',
  'B+': 'bPos',
  'B-': 'bNeg',
  'AB+': 'abPos',
  'AB-': 'abNeg',
  'O+': 'oPos',
  'O-': 'oNeg',
};
