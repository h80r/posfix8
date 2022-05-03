import 'package:flutter/material.dart';

class StyledSwitch extends StatelessWidget {
  const StyledSwitch({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  final String text;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).buttonTheme.colorScheme?.primary;
    final primaryContrastColor = Color.fromARGB(
      255,
      ((primaryColor?.red ?? 0) * 0.4).toInt(),
      ((primaryColor?.green ?? 0) * 0.4).toInt(),
      ((primaryColor?.blue ?? 0) * 0.4).toInt(),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(text),
        Switch(
          value: value,
          onChanged: null,
          thumbColor: MaterialStateProperty.all(
            value ? primaryColor : Colors.grey.shade400,
          ),
          trackColor: MaterialStateProperty.all(
            value ? primaryContrastColor : Colors.white30,
          ),
        ),
      ],
    );
  }
}
