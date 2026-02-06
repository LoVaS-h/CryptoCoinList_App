import 'package:flutter/material.dart';

class HighLowhoursBlock extends StatelessWidget {
  const HighLowhoursBlock({
    super.key,
    required this.finalLow24hours,
    required this.finalHigh24hours,
  });

  final double finalLow24hours;
  final double finalHigh24hours;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        width: 390,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 24, 24, 24),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [     
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('High 24 hours'),
                  Text('Low 24 hours')
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$finalHigh24hours\$'),
                  Text('$finalLow24hours\$')
                ],
              ),
            ),
            SizedBox(width: 20,)
          ],
        )
      );
  }
}