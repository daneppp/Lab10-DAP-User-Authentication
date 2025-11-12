// ignore_for_file: slash_for_doc_comments
import 'package:flutter/foundation.dart';
import 'cluans.dart';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
/**
 * Name: Dane Patzlaff
 * Date: 11/5/25
 * Description: Contains the CluansList and its sort methods that get used by cluans_widget
 * Known Bugs: None
 * Reflection: Had no issue creating the methods for mean, min, max, and sd of answer length
 */

class CluansModel extends ChangeNotifier {
  final List<Cluans> cluansList = [];
  final int MIN_SIZE = 1;

  SupabaseClient client = Supabase.instance.client;

  //Getter for the cluanList
  List<Cluans> get cluans => cluansList;

  CluansModel() {
    getAllCluans();
  }

  operator [](int index) {
    return cluans[index];
  }

  void addCluan(Cluans newCluan) async {
    await client.from('cluans').insert(toJson(newCluan));
    getAllCluans();
  }

  void getAllCluans() async {
    List<Map<String,dynamic>> result = await client 
    .from('cluans')
    .select();
    cluans.clear();
    for(Map<String, dynamic> row in result) {
      //Uses a defined factory constructor in cluans.dart
      cluans.add(Cluans.fromMap(row));
    }
    notifyListeners();
  }

  List<Cluans> getMyCluans() {
    final curUserId = client.auth.currentUser?.id;
    if(curUserId == null) {
      return [];
    }
    return cluansList.where((c) => c.userId == curUserId).toList();
  }

  void removeCluan(Cluans trashyCluan) async {
    await client
    .from('cluans')
    .delete()
    .eq('id', trashyCluan.id);
    getAllCluans();
  }
  
  /**
   * Takes a list of Cluans and sorts them alphabetically by clue
   * if ifSortingByAlpha is true, otherwise sorts by answer length if false
   */
  void sortCluans(bool isSortingByAlpha) {
    if (isSortingByAlpha) {
      cluansList.sort((a, b) => a.clue.compareTo(b.clue));
      notifyListeners();
    } else {
      cluansList.sort((a, b) => a.answer.length.compareTo(b.answer.length));
      notifyListeners();
    }
  }

  /**
   * Gets the avg, min/max length, and sd of the Cluan answers and returns them
   * in a List of doubles in that order
   */
  List<double> collectStatistics() {
    List<double> allCluanStats = [];

    if (cluansList.isEmpty) {
      return allCluanStats;
    }

    allCluanStats.add(getCluanAnsAvg());
    allCluanStats.add(getCluanAnsMin().toDouble());
    allCluanStats.add(getCluanAnsMax().toDouble());
    allCluanStats.add(getCluanAnsSD());

    return allCluanStats;
  }

  /**
   * Get the avg of the answers in cluanList
   */
  double getCluanAnsAvg() {
    double mean = 0;
    for (Cluans clue in cluansList) {
      mean += clue.answer.length;
    }
    return mean / cluansList.length;
  }

  /**
   * Get the min length answer in cluanList
   */
  int getCluanAnsMin() {
    int curMinAns = cluansList[0].answer.length;
    //If the list's size is 1, just return the cluan's answers length
    if (cluansList.length == MIN_SIZE) {
      return curMinAns;
    }

    for (int i = 0; i < cluansList.length - 1; i++) {
      int nextCluanAns = cluansList[i + 1].answer.length;
      if (curMinAns > nextCluanAns) {
        curMinAns = nextCluanAns;
      }
    }
    return curMinAns;
  }

  /**
   * Get the maximum length answer in cluanList
   */
  int getCluanAnsMax() {
    int curMaxAns = cluansList[0].answer.length;
    //If the list's size is 1, just return the cluan's answers length
    if (cluansList.length == MIN_SIZE) {
      return curMaxAns;
    }

    for (int i = 0; i < cluansList.length - 1; i++) {
      int nextCluanAns = cluansList[i + 1].answer.length;
      if (curMaxAns < nextCluanAns) {
        curMaxAns = nextCluanAns;
      }
    }
    return curMaxAns;
  }

  /**
   * Get the standard deviation of the answers in cluanList
   */
  double getCluanAnsSD() {
    double mean = getCluanAnsAvg();
    double standardDeviation = 0;
    double n = cluansList.length - 1;
    double curDeviation = 0;

    for (Cluans clue in cluansList) {
      //Get the length of each Cluans answer and subtract it from the mean,
      //before squaring the result
      int curLength = clue.answer.length;
      curDeviation = (curLength - mean) * (curLength - mean);
      standardDeviation += curDeviation;
    }
    //Take the sd and divide it by n before taking the square root
    return standardDeviation = sqrt((standardDeviation / n));
  }
}
