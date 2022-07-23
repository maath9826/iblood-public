import 'package:flutter/material.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/donation_requests_tab/widgets/phone_call_button.dart';
import 'package:iblood/models/donation_request/donation_request.dart';

class DonationRequestListItem extends StatelessWidget {
  final DonationRequest donationRequests;

  const DonationRequestListItem({required this.donationRequests});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () => showDialog(
                context: context,
                builder: (ctx) => SimpleDialog(
                  contentPadding: const EdgeInsets.all(16),
                  children: [
                    DialogElement(
                        label: 'Blood Group',
                        value:
                            // donationRequests[i].bloodGroup
                            donationRequests.bloodGroup),
                    const SizedBox(
                      height: 10,
                    ),
                    DialogElement(
                      label: 'Location',
                      value: donationRequests.location,
                      // users
                      //     .firstWhere(
                      //         (user) => user.id == donationRequests[i].userId)
                      //     .location,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DialogElement(
                        label: 'Phone Number',
                        value: donationRequests.phoneNumber
                        // donationRequests[i].phoneNumber
                        ),
                    const SizedBox(
                      height: 10,
                    ),
                    PhoneCallButton(
                      phoneNumber: (donationRequests.phoneNumber
                          ),
                    ),
                  ],
                ),
              ),
          title: Text(
            donationRequests.bloodGroup,
            // donationRequests[i].bloodGroup,
            style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          subtitle: Text(
            donationRequests.location,
              // users
            //     .firstWhere((user) => user.id == donationRequests[i].userId)
            //     .location
          )
          ),
    );
  }
}

class DialogElement extends StatelessWidget {
  final String label;
  final String value;

  const DialogElement({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    );
  }
}
