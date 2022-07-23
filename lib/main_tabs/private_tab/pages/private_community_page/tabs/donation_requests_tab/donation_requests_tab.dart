import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/data.dart';
import './pages/add_donation_request.dart';
import './widgets/donation_request_list_item.dart';
import '/models/donation_request/donation_request.dart';
import '/providers/donation_request_provider.dart';

import 'data.dart';

class DonationRequestsTab extends StatefulWidget {
  final String privateCommunityId;
  const DonationRequestsTab({required this.privateCommunityId,Key? key}) : super(key: key);

  @override
  State<DonationRequestsTab> createState() => _DonationRequestsTabState();
}

class _DonationRequestsTabState extends State<DonationRequestsTab> {
  late final DonationRequestProvider _donationRequestsProvider;

  // List<DonationRequest>
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _donationRequestsProvider = DonationRequestProvider(widget.privateCommunityId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _donationRequestsProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: _donationRequestsProvider.getAll(
                fieldName: 'creationDate',
                context: context,
                isDescending: true),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('There is no data'),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16, right: 16, bottom: 60),
                separatorBuilder: (ctx, i) => const SizedBox(
                  height: 5,
                ),
                itemBuilder: (ctx, i) => DonationRequestListItem(
                  donationRequests: DonationRequest.fromJson(
                      snapshot.data!.docs[i].data() as  Map<String, dynamic>),
                ),
                itemCount: snapshot.data!.docs.length,
                // donationRequests.length
              );
            }),
        Align(
          child: FloatingActionButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddDonationRequest.routeName),
            child: const Icon(Icons.add),
          ),
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}
