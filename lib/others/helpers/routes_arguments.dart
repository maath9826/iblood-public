import 'package:iblood/data.dart';
import 'package:iblood/main_tabs/private_tab/data.dart';
import 'package:iblood/models/donor/donor.dart';
import 'package:iblood/models/private_community/private_community_member/private_community_member.dart';
import 'package:iblood/models/user/user.dart';
import 'package:iblood/models/private_community/private_community.dart';

class BloodBankBagsPageArguments {
  final int id;
  final String label;

  BloodBankBagsPageArguments({required this.id, required this.label});
}

class PrivateCommunityPageArguments {
  final PrivateCommunity privateCommunity;
  final String id;

  PrivateCommunityPageArguments({
    required this.privateCommunity,
    required this.id,
  });
}

class AddDonorArguments {
  final String privateCommunityId;

  AddDonorArguments({
    required this.privateCommunityId,
  });
}

class MemberDetailsPageArguments {
  final String memberId;
  final PrivateCommunityMember member;

  MemberDetailsPageArguments({
    required this.memberId,
    required this.member,
  });
}

class DonorDetailsPageArguments {
  final Donor donor;

  DonorDetailsPageArguments({required this.donor});
}
