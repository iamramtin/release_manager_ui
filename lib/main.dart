import 'package:flutter/material.dart';
import 'package:release_manager_ui/main_theme.dart';
import 'package:provider/provider.dart';
import 'constant.dart';
import 'home.dart';
import 'models/form_data_provider.dart';
import 'models/page_switcher.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = MainTheme.light();
    return MaterialApp(
      theme: theme,
      title: projectTitle,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PageSwitcher()),
          ChangeNotifierProvider(create: (context) => FormDataProvider()),
        ],
        child: const Home(),
      ),
    );
  }
}
