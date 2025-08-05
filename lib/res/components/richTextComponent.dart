import 'package:flutter/material.dart';

Widget RichTextComponent(String label, String value, BuildContext context) {
  return RichText(
    text: TextSpan(
      text: "$label: ",
      style: Theme.of(context).textTheme.bodyLarge,
      children: [
        TextSpan(
          text: value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
  );
}
