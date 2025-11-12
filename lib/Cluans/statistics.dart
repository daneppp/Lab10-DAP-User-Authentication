// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cluans_model.dart';
/**
 * Name: Dane Patzlaff
 * Date: 10/12/25
 * Description: Displays the Statistics from the Statistics Widget, gets those stats by calling model.collectStatistics from cluans_model
 * Known Bugs: None
 * Reflection: Not too bad
 */

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CluansModel>();
    final stats = model.collectStatistics();

    if (stats.isEmpty) {
      return const Center(
        child: Text(
          'No Cluans means no stats, add a few.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    //List will always contain mean, min, max, and sd in that order
    final mean = stats[0];
    final min = stats[1];
    final max = stats[2];
    final sd = stats[3];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DefaultTextStyle(
        // FIXED: Added closing parenthesis ')' after the color
        style: const TextStyle(
          fontSize: 24.0,
          color: Color.fromARGB(255, 6, 102, 181),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text('Minimum answer length: ${min.toStringAsFixed(1)}'),
            Text('Maximum answer length: ${max.toStringAsFixed(1)}'),
            Text('Average answer length: ${mean.toStringAsFixed(1)}'),
            Text('Sample standard deviation: ${sd.toStringAsFixed(1)}'),
          ],
        ),
      ),
    );
  }
}
