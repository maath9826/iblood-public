import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final void Function()? onPressed;
  const SubmitButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                 SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
        onPressed: onPressed,
        child: const Text('Submit'),
      ),
    );
  }
}
