import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:release_manager_ui/constant.dart';
import 'package:release_manager_ui/screens/release_notes/add_note/optional_form.dart';
import 'package:release_manager_ui/screens/release_notes/add_note/required_form.dart';
import 'package:release_manager_ui/models/form_data_provider.dart';
import 'package:release_manager_ui/main_theme.dart';
import 'package:release_manager_ui/screens/release_notes/add_note/commit.dart';

String repo = '';
String client = '';
String commitHash = '';
String commitMessage = '';
String title = '';
String tickets = '';
String impact = '';
String category = '';
String description = '';
String codeChanges = '';
String testingSteps = '';
String additionalNotes = '';
String additionalLinks = '';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class User {
  final String name, username, email;
  User(this.name, this.username, this.email);
}

class _AddNoteState extends State<AddNote> {
  List<Commit> commits = [];

  Future<Response> createNote() async {
    // TODO: delete when ready to use real input data
    String repo = 'Test Project';
    String client = 'Nameless Bank';
    String commitHash = '3290ac1';
    String commitMessage = 'This is a commit message';
    String title = 'New Test Data';
    String tickets = 'TEST-111';
    String impact = 'Everything';
    String category = 'Bugfix';
    String description = 'This is a description';
    String codeChanges = 'This is a code change';
    String testingSteps = 'This is a testing step';
    String additionalNotes = 'This is an additional note';
    String additionalLinks = 'This is an additional link';

    Map<String, String> queryParams = {
      'repo': repo,
      'client': client,
      'commitHash': commitHash,
      'commitMessage': commitMessage,
      'title': title,
      'tickets': tickets,
      'impact': impact,
      'category': category,
      'description': description,
      'codeChanges': codeChanges,
      'testingSteps': testingSteps,
      'additionalNotes': additionalNotes,
      'additionalLinks': additionalLinks
    };

    return await http.get(Uri.http('$apiUrl:8000', 'create-note', queryParams));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    // TODO: uncomment to use real input data
    // String repoProvider = Provider.of<FormDataProvider>(context).repo;
    // String clientProvider = Provider.of<FormDataProvider>(context).client;
    // String commitHashProvider = Provider.of<FormDataProvider>(context).commitHash;
    // String commitMessageProvider = Provider.of<FormDataProvider>(context).commitMessage;
    // String titleProvider = Provider.of<FormDataProvider>(context).title;
    // String ticketsProvider = Provider.of<FormDataProvider>(context).tickets;
    // String impactProvider = Provider.of<FormDataProvider>(context).impact;
    // String categoryProvider = Provider.of<FormDataProvider>(context).category;
    // String descriptionProvider = Provider.of<FormDataProvider>(context).description;
    // String codeChangesProvider = Provider.of<FormDataProvider>(context).codeChanges;
    // String testingStepsProvider = Provider.of<FormDataProvider>(context).testingSteps;
    // String additionalNotesProvider = Provider.of<FormDataProvider>(context).additionalNotes;
    // String additionalLinksProvider = Provider.of<FormDataProvider>(context).additionalLinks;

    return Container(
      color: lightGrey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width / 6, vertical: 20),
        child: ListView(
          children: <Widget>[
            RequiredForm(),
            SizedBox(height: 25),
            OptionalForm(),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 40,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(lightBlue),
                      overlayColor: MaterialStateProperty.all(Colors.black12),
                    ),
                    onPressed: () async {
                      // TODO: uncomment to use real input data
                      // repo = repoProvider;
                      // client = clientProvider;
                      // commitHash = commitHashProvider;
                      // commitMessage = commitMessageProvider;
                      // title = titleProvider;
                      // tickets = ticketsProvider;
                      // impact = impactProvider;
                      // category = categoryProvider;
                      // description = descriptionProvider;
                      // codeChanges = codeChangesProvider;
                      // testingSteps = testingStepsProvider;
                      // additionalNotes = additionalNotesProvider;
                      // additionalLinks = additionalLinksProvider;

                      Response response = await createNote();
                      Map<String, dynamic> json_response =
                          json.decode(response.body);

                      String status = json_response['status'];
                      String note_name = json_response['response']['note_name'];
                      String repo_name = json_response['response']['repo_name'];

                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Note added in $repo_name: $note_name')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: failed to add note')),
                        );
                      }
                    },
                    child: Text(
                      'Create Note',
                      style: MainTheme.darkTextTheme.bodyText2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
