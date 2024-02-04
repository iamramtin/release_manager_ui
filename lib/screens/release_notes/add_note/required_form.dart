import 'dart:convert';

import 'package:release_manager_ui/components/multiselect_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:release_manager_ui/components/components.dart';
import 'package:release_manager_ui/models/form_data_provider.dart';
import 'package:release_manager_ui/constant.dart';
import 'package:release_manager_ui/main_theme.dart';
import 'package:release_manager_ui/screens/release_notes/add_note/commit.dart';

class RequiredForm extends StatefulWidget {
  const RequiredForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RequiredForm> createState() => _RequiredFormState();
}

class _RequiredFormState extends State<RequiredForm> {
  final List<String> _repos = [
    'Test Project',
    'Test Project 2',
    'Test Project 3',
    'Test Project 4',
    'Test Project 5',
    'Test Project 6',
    'Test Project 7',
    'Test Project 8',
    'Test Project 9',
    'Test Project 10',
  ];

  final List<String> _client = [
    'General',
    'Test Bank',
    'Bank of Testing',
    'Nameless Bank',
    'Bank of Test',
    'Test Bank 2',
    'Bank of Testing',
  ];

  late String _commitHashDefaultValue = 'No hash';
  late String _commitMessageDefaultValue = 'No message';

  late String titleInitValue = '';

  List<Commit> commits = [];
  List<String> commitHashes = ['No hash'];
  List<String> commitMessages = ['No message'];

  String selectedRepo = 'none';

  getCommits() async {
    if (!commits.isEmpty) {
      commits = [];
      commitHashes = ['No hash'];
      commitMessages = ['No message'];
    }

    Map<String, String> queryParams = {
      'repo': selectedRepo,
    };

    var data = await http
        .get(Uri.http('$apiUrl:8000', 'get-git-commits', queryParams));
    var jsonData = json.decode(data.body);

    for (var i = 0; i < jsonData.length; i++) {
      var d = jsonData['commit_$i'];
      commits.add(Commit(d['author'], d['hash'], d['message'], d['repo']));
    }

    if (commitHashes.length <= 1) {
      for (var c in commits) commitHashes.add(c.getShortenedHash());
    }

    if (commitMessages.length <= 1) {
      for (var c in commits) commitMessages.add(c.getShortenedMessage());
    }
  }

  @override
  Widget build(BuildContext context) {
    alignMessageWithHash(String value) {
      setState(() {
        var index = commitHashes.indexOf(value);
        _commitHashDefaultValue = value.toString();
        Provider.of<FormDataProvider>(context, listen: false)
            .setCommitHash(value);
        _commitMessageDefaultValue = commitMessages[index];
        Provider.of<FormDataProvider>(context, listen: false)
            .setCommitMessage(commitMessages[index]);

        titleInitValue = commitMessages[index];
        Provider.of<FormDataProvider>(context, listen: false)
            .setTitle(commitMessages[index]);
      });
    }

    alignHashWithMessage(String value) {
      setState(() {
        var index = commitMessages.indexOf(value);
        _commitMessageDefaultValue = value.toString();
        Provider.of<FormDataProvider>(context, listen: false)
            .setCommitMessage(value);
        _commitHashDefaultValue = commitHashes[index];
        Provider.of<FormDataProvider>(context, listen: false)
            .setCommitHash(commitHashes[index]);

        titleInitValue = value;
        Provider.of<FormDataProvider>(context, listen: false).setTitle(value);
        print(titleInitValue);
      });
    }

    updatedSelectedRepo(String value) {
      setState(() {
        selectedRepo = value.replaceAll(' ', '-');
      });
    }

    return ExpansionTile(
        initiallyExpanded: true,
        collapsedBackgroundColor: lightBlue,
        backgroundColor: lightBlue,
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        title: Text(
          'REQUIRED',
          style: MainTheme.darkTextTheme.headline6,
        ),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth > 800) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownField(
                            title: 'Repo:',
                            buttonLabel: 'Repo',
                            data: _repos,
                            width: MediaQuery.of(context).size.width / 3.3,
                            onChanged: (newValue) {
                              Provider.of<FormDataProvider>(context,
                                      listen: false)
                                  .setRepo(newValue);
                              updatedSelectedRepo(newValue);
                            },
                          ),
                          DropdownField(
                            title: 'Client:',
                            buttonLabel: 'Client',
                            data: _client,
                            width: MediaQuery.of(context).size.width / 3.3,
                            onChanged: (newValue) {
                              Provider.of<FormDataProvider>(context,
                                      listen: false)
                                  .setClient(newValue);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 5),

                      Visibility(
                        visible: selectedRepo == 'none' ? false : true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Commit:',
                                    style: const TextStyle(
                                        fontSize: 18, color: lightBlue),
                                  ),
                                ),
                              ],
                            ),

                            // TODO: Fix error in dropdown list when identical git message/hash/dropdown value appears more than once
                            FutureBuilder(
                                future: getCommits(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            'Fetching data from BitBucket...'));
                                  } else {
                                    if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'));
                                    } else {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8,
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                labelStyle: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                contentPadding: EdgeInsets.only(
                                                    left: 16, right: 4),
                                                labelText: 'Hash',
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  value:
                                                      _commitHashDefaultValue,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                  items: commitHashes
                                                      .map((dropValue) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: dropValue,
                                                      child: Text(dropValue),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newValue) {
                                                    alignMessageWithHash(
                                                        newValue.toString());
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                labelStyle: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                contentPadding: EdgeInsets.only(
                                                    left: 16, right: 4),
                                                labelText: 'Message',
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  value:
                                                      _commitMessageDefaultValue,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                  items: commitMessages
                                                      .map((dropValue) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: dropValue,
                                                      child: Text(dropValue),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newValue) {
                                                    alignHashWithMessage(
                                                        newValue.toString());
                                                  },
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                  }
                                }),
                          ],
                        ),
                      ),
                      SizedBox(height: 17),
                      CustomTextField(
                        title: 'Title:',
                        initValue: titleInitValue,
                        onChanged: (newValue) {
                          Provider.of<FormDataProvider>(context, listen: false)
                              .setTitle(newValue);
                        },
                      ),
                      SizedBox(height: 17),

                      // TODO: Extract & sync ticket from git message
                      CustomTextField(
                        title: 'Tickets:',
                        initValue: '',
                        onChanged: (newValue) {
                          Provider.of<FormDataProvider>(context, listen: false)
                              .setTickets(newValue);
                        },
                      ),
                      SizedBox(height: 17),

                      // TODO: Change to multi-select checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MultiselectDropdownField(
                            title: 'Impact:',
                            buttonLabel: 'Impact',
                            data: ['impact1', 'impact2', 'impact3'],
                            width: MediaQuery.of(context).size.width / 3.3,
                            onChanged: (newValue) {
                              Provider.of<FormDataProvider>(context,
                                      listen: false)
                                  .setImpact(newValue);
                            },
                          ),
                          MultiselectDropdownField(
                            title: 'Category:',
                            buttonLabel: 'Category',
                            data: ['category1', 'category2', 'category3'],
                            width: MediaQuery.of(context).size.width / 3.3,
                            onChanged: (newValue) {
                              Provider.of<FormDataProvider>(context,
                                      listen: false)
                                  .setCategory(newValue);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 17),
                      CustomMultilineTextField(
                        title: 'Description of Issue:',
                        onChanged: (newValue) {
                          Provider.of<FormDataProvider>(context, listen: false)
                              .setDescription(newValue);
                        },
                      ),
                      SizedBox(height: 17),
                    ],
                  );
                } else {
                  return new Text('SCREEN TOO SMALL - MODIFY ACCORDINGLY');
                }
              },
            ),
          ),
        ]);
  }
}
