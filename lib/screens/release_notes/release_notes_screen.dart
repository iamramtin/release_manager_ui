import 'package:release_manager_ui/constant.dart';
import 'package:release_manager_ui/screens/release_notes/collate_notes/collate_notes_dialog.dart';
import 'package:flutter/material.dart';

import 'add_note/add_note.dart';

class ReleaseNotes extends StatefulWidget {
  @override
  State<ReleaseNotes> createState() => _ReleaseNotesState();
}

class _ReleaseNotesState extends State<ReleaseNotes> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white,
                          height: 50,
                          width: 550,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TabBar(
                                isScrollable: true,
                                indicatorColor: lightBlue,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black87,
                                indicator: BoxDecoration(
                                  color: lightBlue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                tabs: [
                                  Tab(
                                    text: 'Add Note',
                                  ),
                                  Tab(
                                    text: 'Add Summary',
                                  ),
                                  Tab(
                                    text: 'Add Deployment Steps',
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MaterialButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CollateNotesDialog();
                            });
                      },
                      child: Text('Collate Notes',
                          style: TextStyle(
                            color: Colors.blue,
                          )),
                      textColor: lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                            color: lightBlue,
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height - 112,
              child: TabBarView(
                children: [
                  AddNote(),
                  Container(
                    color: Colors.deepPurpleAccent,
                    child: Center(
                        child: Text(
                      'Add Summary',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  Container(
                    color: Colors.pinkAccent,
                    child: Center(
                        child: Text(
                      'Add Deployment Steps',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
