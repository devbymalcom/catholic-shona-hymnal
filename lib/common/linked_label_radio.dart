import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkedLabelRadio extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final String groupValue;
  final String value;
  final ValueChanged<String> onChanged;

  const LinkedLabelRadio(
      {required this.label,
      required this.padding,
      required this.groupValue,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Radio<String>(
              //activeColor: lightColorScheme.primary,
              groupValue: groupValue,
              value: value,
              onChanged: (String? newValue) {
                onChanged(newValue!);
              }),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              text: label,
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ),
        ],
      ),
    );
  }
}
