import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_field.dart';

class FieldDialog {
  final void Function({
    required FieldDialog fieldDialog,
    required BuildContext dialogContext,
    required void Function(void Function()) dialogSetState,
  }) onSubmit;
  final String dialogTitle;
  final String fieldLabel;
  final TextEditingController fieldController;
  final String? Function(String?)? validator;
  final int? fieldLength;
  FieldDialog({
    required this.onSubmit,
    required this.dialogTitle,
    required this.fieldLabel,
    required this.fieldController,
    this.validator,
    this.fieldLength
  });

  bool isOpened = false;
  bool isActivationSucceeded = false;
  String? errorMessage;
  var isLoading = false;
  final formKey = GlobalKey<FormState>();

  show({
    required BuildContext context,
  }) async {
    isOpened = true;
    await showDialog(
      context: context,
      builder: (dialogCtx) => WillPopScope(
        onWillPop: () {
          isOpened = false;
          return Future.value(true);
        },
        child: StatefulBuilder(
          builder: (ctx, dialogSetState) => SimpleDialog(
            title: Text(dialogTitle),
            contentPadding: const EdgeInsets.all(24),
            children: isActivationSucceeded
                ? [
                    Center(
                      child: Column(
                        children: const [
                          Icon(
                            CupertinoIcons.checkmark_circle,
                            size: 45,
                            color: Colors.green,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('successfully activated'),
                        ],
                      ),
                    ),
                  ]
                : [
                    Form(
                      key: formKey,
                      child: CustomField(
                        label: fieldLabel,
                        controller: fieldController,
                        validator: fieldLength == null ? (value) {
                          if (value == null || value.isEmpty) {
                            return 'required';
                          }
                          return null;
                        } : (value) {
                          if (value == null || value.isEmpty) {
                              return 'required';
                          }
                          else if(value.length != fieldLength){
                            return 'wrong code!';
                          }
                          return null;
                        },
                        errorMessage: errorMessage,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    isLoading
                        ? Column(
                            children: const [CircularProgressIndicator()],
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                const Size(
                                  double.maxFinite,
                                  45,
                                ),
                              ),
                            ),
                            onPressed: () => onSubmit(
                              fieldDialog: this,
                              dialogSetState: dialogSetState,
                              dialogContext: dialogCtx,
                            ),
                            child: const Text(
                              'Submit',
                            ),
                          ),
                  ],
          ),
        ),
      ),
    );
  }
}
