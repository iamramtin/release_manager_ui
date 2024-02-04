import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:release_manager_ui/components/components.dart';
import 'package:release_manager_ui/models/form_data_provider.dart';
import 'package:release_manager_ui/constant.dart';
import 'package:release_manager_ui/main_theme.dart';

class OptionalForm extends StatefulWidget {
  @override
  State<OptionalForm> createState() => _OptionalFormState();
}

class _OptionalFormState extends State<OptionalForm> {
  String testingStepsValue = '';
  String codeChangesValue = '';
  String additionalNotesValue = '';
  String additionalLinksValue = '';

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      collapsedBackgroundColor: lightBlue,
      backgroundColor: lightBlue,
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      title: Text(
        'OPTIONAL',
        style: MainTheme.darkTextTheme.headline6,
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.white,
          child: Column(
            children: [
              // TODO: move "Solution" box to required form
              CustomMultilineTextField(
                title: 'Solution:',
                onChanged: (newValue) {
                  Provider.of<FormDataProvider>(context, listen: false)
                      .setCodeChanges(newValue);
                },
              ),
              SizedBox(height: 20),
              CustomMultilineTextField(
                title: 'Testing and replication steps for the client:',
                onChanged: (newValue) {
                  Provider.of<FormDataProvider>(context, listen: false)
                      .setTestingSteps(newValue);
                },
              ),
              SizedBox(height: 20),
              CustomMultilineTextField(
                title: 'Additional notes:',
                onChanged: (newValue) {
                  Provider.of<FormDataProvider>(context, listen: false)
                      .setAdditionalNotes(newValue);
                },
              ),
              SizedBox(height: 20),
              CustomMultilineTextField(
                title: 'Additional links:',
                onChanged: (newValue) {
                  Provider.of<FormDataProvider>(context, listen: false)
                      .setAdditionalLinks(newValue);
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
