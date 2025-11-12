// ignore_for_file: slash_for_doc_comments, dangling_library_doc_comments

/**
 * 
 * Name: Dane Patzlaff
 * Date: 11/5/25
 * Description: Cluans have four fields: a clue, answer, date, and id
 * and can be sorted either alphabetically by clue or in ascending order by answer
 * Bugs: None known
 * Reflection: 
 * 
 */

class Cluans {
  final String clue;
  final String answer;
  final DateTime date;
  final dynamic id;
  final dynamic userId;

  //Constructor with one optional named param: date
  //and two required named parameters: clue and answer
  Cluans({DateTime? date, required String clue, required String answer, this.id, this.userId})
    : clue = clue.length > 150 ? clue.substring(0, 150) : clue,
      answer = answer.length > 21 ? answer.substring(0, 21) : answer,
      date = date ?? DateTime.now();
      //added id field

  //Getters for answer and clue
  String getCluanAnswer() => answer;

  String getCluanClue() => clue;

  //Added a .fromMap conversion method for working with supabase
  factory Cluans.fromMap(Map<String, dynamic> row) {
    return Cluans(  
      answer: row['answer'],
      clue: row['clue'],
      date: DateTime.parse(row['created_at']),
      id: row['id'].toString(),
      userId: row['user_id'].toString(),
    );
  }

//Added a toJson method for converting transferring the data
  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'clue': clue,
    };
  }



}
