import 'package:flutter/material.dart';

class TextAmount extends StatelessWidget {
  const TextAmount({
    Key? key,
    required this.amount,
    required this.smallStyle,
    required this.bigStyle,
    this.bigValue,
    this.smallValue,
    this.prefix,
    this.prefixCapitalize = true,
    this.color = Colors.black,
  }) : super(key: key);

  final double amount;
  final String? bigValue;
  final String? smallValue;
  final TextStyle bigStyle;
  final TextStyle smallStyle;
  final String? prefix;
  final bool prefixCapitalize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bigStyleColored = bigStyle.copyWith(color: color);
    final smallStyleColored = smallStyle.copyWith(color: color);
    final diff = amount < 0 ? 1 : 0;
    return RichText(
      text: TextSpan(
        children: <InlineSpan>[
          if (prefix != null)
            TextSpan(
              text: prefix,
              style: prefixCapitalize ? bigStyleColored : smallStyleColored,
            ),
          TextSpan(
            text: bigValue ?? amount.floor().toString(),
            style: bigStyleColored,
          ),
          TextSpan(
            text: smallValue ?? '.${(amount - amount.toInt()).toStringAsFixed(2).substring(2 + diff, 4 + diff)}',
            style: smallStyleColored,
          ),
        ],
      ),
    );
  }
}
