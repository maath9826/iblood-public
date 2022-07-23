import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class PhoneCallButton extends StatelessWidget {
  final String phoneNumber;
  const PhoneCallButton({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return                             ElevatedButton(
      onPressed: () => FlutterPhoneDirectCaller.callNumber(
          phoneNumber
        // donationRequests[i].phoneNumber
      ),
      child: const Icon(Icons.phone),
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all(Colors.green),
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(10),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
    );
  }
}
