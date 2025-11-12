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

class MyCluansWidget extends StatelessWidget {
  const MyCluansWidget({super.key});

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

    final myCluans = model.getMyCluans();

    return ListView.builder(
      itemCount: myCluans.length,
      itemBuilder: (context, index) {
        final cluan = myCluans[index];

        //Each ListTile gets a clue, answer, weekday, and date
        return ListTile(
          onLongPress: () {
            model.removeCluan(cluan);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cluan has been deleted')),
            );
          },
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
