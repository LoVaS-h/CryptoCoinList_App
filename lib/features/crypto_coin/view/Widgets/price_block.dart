import 'package:flutter/material.dart';

class priceBlock extends StatelessWidget {
  const priceBlock({
    super.key,
    required this.priceInUSD,
  });

  final double priceInUSD;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 390,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 24, 24, 24),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Center(child: Text('$priceInUSD\$', style: Theme.of(context).textTheme.labelMedium,))
      );
  }
}