import 'package:flutter/material.dart';
import 'package:iblood/widgets/custom_field.dart';

class ThreeFieldsDate extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController monthController;
  final TextEditingController dayController;
  final String title;
  final void Function(DateTime) onChange;

  const ThreeFieldsDate({
    Key? key,
    required this.dayController,
    required this.monthController,
    required this.yearController,
    required this.title,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(title),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: CustomField(
                label: 'year',
                controller: yearController,
                keyboardType: TextInputType.number,
                onChange: (value) {
                  _updateDate();
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: CustomField(
                label: 'month',
                controller: monthController,
                keyboardType: TextInputType.number,
                onChange: (value) {
                  _updateDate();
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: CustomField(
                label: 'day',
                controller: dayController,
                keyboardType: TextInputType.number,
                onChange: (value) {
                  _updateDate();
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  _updateDate() {
    if (yearController.text.isEmpty ||
        monthController.text.isEmpty ||
        dayController.text.isEmpty) return ;

    var date = DateTime(
      int.parse(yearController.text),
      int.parse(monthController.text),
      int.parse(dayController.text),
    );

    onChange(date);
  }
}
