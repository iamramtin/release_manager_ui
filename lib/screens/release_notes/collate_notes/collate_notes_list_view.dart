import 'package:flutter/material.dart';
import 'package:release_manager_ui/main_theme.dart';

class CollateNotesListView extends StatefulWidget {
  final notes;

  const CollateNotesListView({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  State<CollateNotesListView> createState() => _CollateNotesListViewState();
}

class _CollateNotesListViewState extends State<CollateNotesListView> {
  @override
  build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      height: 400,
      width: screenSize.width / 1.8,

      // List of repo titles
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.notes.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        cleanText(widget.notes[i].getRepo()),
                        style: MainTheme.lightTextTheme.headline2,
                      ),
                    ),

                    // List of notes under each repo
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.notes[i].getNoteList().length,
                        itemBuilder: (BuildContext context, int j) {
                          return CheckboxListTile(
                            title: Text(widget.notes[i].getNoteList()[j]),
                            value: widget.notes[i].getSelectedList()[j],
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (newValue) {
                              setState(() {
                                widget.notes[i].setSelected(j, newValue!);
                              });
                            },
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            );
          }),
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
      final String newWord = firstLetter + remainingLetters;

      if (newWord == 'Bop') return 'BOP';
      if (newWord == 'Cicd') return 'CICD';
      if (newWord == 'Txstream') return 'TXstream';

      return newWord;
    }

    return '';
  });

  return capitalizedWords.join(' ');
}
