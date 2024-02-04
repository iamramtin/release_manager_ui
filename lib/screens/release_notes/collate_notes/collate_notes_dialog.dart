import 'dart:convert';

import 'package:release_manager_ui/screens/release_notes/collate_notes/collate_notes_list_view.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:release_manager_ui/constant.dart';
import 'package:release_manager_ui/main_theme.dart';

class CollateNotesDialog extends StatefulWidget {
  @override
  State<CollateNotesDialog> createState() => _CollateNotesDialogState();
}

class _CollateNotesDialogState extends State<CollateNotesDialog> {
  List<Note> notes = [];

  // TODO: make API call with list of notes
  Future<http.Response> collateNotes(List<String> notesToCollate) async {
    return await http.post(Uri.http('$apiUrl:5001', 'collate-notes'));
  }

  getNotes() async {
    var data =
        await http.get(Uri.http('$apiUrl:8000', 'list-uncollated-notes'));
    var jsonData = json.decode(data.body);

    for (var obj in jsonData['data']) {
      String repoName = obj['repo_name'];
      List<String> notesList = convertJsonToList(obj['notes_list'].toString());
      List<bool> selectedList =
          List.filled(notesList.length, false, growable: true);

      notes.add(Note(repoName, notesList, selectedList));
    }
  }

  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      child: SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
            child: Text('Collate Notes',
                style: MainTheme.lightTextTheme.headline1),
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
            child: FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 400,
                    width: screenSize.width / 1.8,
                    child: Center(child: Text('Fetching data...')),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return CollateNotesListView(notes: notes);
                  }
                }
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                List<String> notesToCollate = [];
                for (var i = 0; i < notes.length; i++) {
                  for (var j = 0; j < notes[i].getSelectedList().length; j++) {
                    if (notes[i].getSelectedList()[j]) {
                      notesToCollate.add(
                          notes[i].getRepo() + "/" + notes[i].getNoteList()[j]);
                    }
                  }
                }

                // TODO: make API call with list of notes
                // collateNotes(notesToCollate);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Collating notes...')),
                );
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 40),
                primary: lightBlue,
              ),
              child: Text('Collate Notes'),
            ),
          ),
        ],
      ),
    );
  }
}

String cleanText(String str) {
  // remove hyphens
  str = str.replaceAll(RegExp(r'-'), ' ');

  // convert to title case
  final List<String> words = str.split(' ');
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }

    return '';
  });

  return capitalizedWords.join(' ');
}

class Note {
  final String repo;
  final List<String> noteList;
  List<bool> selectedList;

  List<String> getNoteList() {
    return noteList;
  }

  String getRepo() {
    return repo;
  }

  List<bool> getSelectedList() {
    return selectedList;
  }

  setSelected(int index, bool value) {
    selectedList[index] = value;
  }

  Note(this.repo, this.noteList, this.selectedList);
}

List<String> convertJsonToList(String json) {
  String result = json.substring(1, json.length - 1);
  return result.split(', ');
}
