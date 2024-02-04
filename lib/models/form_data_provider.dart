import 'package:flutter/material.dart';

class FormDataProvider extends ChangeNotifier {
  // required form data
  String repo = '';
  String client = '';
  String commitHash = '';
  String commitMessage = '';
  String title = '';
  String tickets = '';
  String impact = '';
  String category = '';
  String description = '';

  // optional form data
  String codeChanges = '';
  String testingSteps = '';
  String additionalNotes = '';
  String additionalLinks = '';

  FormDataProvider({
    this.repo = '',
    this.client = '',
    this.commitHash = '',
    this.commitMessage = '',
    this.title = '',
    this.tickets = '',
    this.impact = '',
    this.category = '',
    this.description = '',
    this.codeChanges = '',
    this.testingSteps = '',
    this.additionalNotes = '',
    this.additionalLinks = '',
  });

  void setRepo(String value) {
    repo = value;
    notifyListeners();
  }

  void setClient(String value) {
    client = value;
    notifyListeners();
  }

  void setCommitHash(String value) {
    commitHash = value;
    notifyListeners();
  }

  void setCommitMessage(String value) {
    commitMessage = value;
    notifyListeners();
  }

  void setTitle(String value) {
    title = value;
    notifyListeners();
  }

  void setTickets(String value) {
    tickets = value;
    notifyListeners();
  }

  void setImpact(String value) {
    impact = value;
    notifyListeners();
  }

  void setCategory(String value) {
    category = value;
    notifyListeners();
  }

  void setDescription(String value) {
    description = value;
    notifyListeners();
  }

  void setCodeChanges(String value) {
    codeChanges = value;
    notifyListeners();
  }

  void setTestingSteps(String value) {
    testingSteps = value;
    notifyListeners();
  }

  void setAdditionalNotes(String value) {
    additionalNotes = value;
    notifyListeners();
  }

  void setAdditionalLinks(String value) {
    additionalLinks = value;
    notifyListeners();
  }
}