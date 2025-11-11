// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cluans_model.dart';
/**
 * Name: Dane Patzlaff
 * Date: 10/12/25
 * Description: Components of the AppBar and CluansWidget, which uses a ListView
 * to display each Cluan's clue, answer, and date
 * Known Bugs: None
 */

class CluansWidget extends StatelessWidget {
  const CluansWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //Needed for the trailing output
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    var curday;
    //Calling watch on the model to display the Cluans in the ListView
    final model = context.watch<CluansModel>();
    
    return ListView.builder(
      itemCount: model.cluans.length,
      itemBuilder: (context, index) {
        final cluan = model.cluans[index];

        //Each ListTile gets a clue, answer, weekday, and date
        return ListTile(
          title: Text(cluan.clue),
          subtitle: Text(cluan.answer.toUpperCase()),
          trailing: Text(
            '${curday = days[cluan.date.weekday - 1]},${cluan.date.month}/${cluan.date.day}/${cluan.date.year}',
          ),
        );
      },
    );
  }
}
