import 'package:release_manager_ui/screens/branching/branching_screen.dart';
import 'package:release_manager_ui/screens/release_notes/release_notes_screen.dart';
import 'package:release_manager_ui/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:release_manager_ui/menu_drawer.dart';
import 'package:release_manager_ui/models/responsive.dart';
import 'package:provider/provider.dart';

import 'constant.dart';
import 'models/page_switcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  final List _isSelected = [
    true,
    false,
  ];

  final List _isHovering = [
    false,
    false,
  ];

  static List<Widget> pages = <Widget>[
    ReleaseNotes(),
    Branching(),
  ];

  _scrollListener() {
    setState(() {});
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Consumer<PageSwitcher>(builder: (context, tabManager, child) {
      return Scaffold(
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? AppBar(
                iconTheme: IconThemeData(color: Colors.blueAccent),
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  projectTitle,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                  ),
                ),
              )
            : PreferredSize(
                preferredSize: Size(screenSize.width, 80),
                child: Container(
                  color: blue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage('assets/images/logo.png'),
                                    fit: BoxFit.contain,
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    projectTitle,
                                    style: MainTheme.darkTextTheme.headline2,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // TopBarItem(index: 0),
                                  // SizedBox(width: 30),
                                  // TopBarItem(index: 1),
                                  InkWell(
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      tabManager.goToReleaseNotes();
                                      _isSelected[0] = true;
                                      _isSelected[1] = false;
                                    },
                                    onHover: (value) {
                                      setState(() {
                                        value
                                            ? _isHovering[0] = true
                                            : _isHovering[0] = false;
                                      });
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          'Release Notes',
                                          style: _isHovering[0]
                                              ? MainTheme
                                                  .darkTextTheme.bodyText1
                                              : MainTheme
                                                  .darkTextTheme.bodyText2,
                                        ),
                                        SizedBox(height: 15),
                                        Visibility(
                                          maintainAnimation: true,
                                          maintainState: true,
                                          maintainSize: true,
                                          visible: _isSelected[0],
                                          child: Container(
                                            height: 4,
                                            width: 'Release Notes'
                                                    .length
                                                    .toDouble() *
                                                8,
                                            color: lightBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  InkWell(
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      tabManager.goToBranching();
                                      _isSelected[0] = false;
                                      _isSelected[1] = true;
                                    },
                                    onHover: (value) {
                                      setState(() {
                                        value
                                            ? _isHovering[1] = true
                                            : _isHovering[1] = false;
                                      });
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          'Branching',
                                          style: _isHovering[1]
                                              ? MainTheme
                                                  .darkTextTheme.bodyText1
                                              : MainTheme
                                                  .darkTextTheme.bodyText2,
                                        ),
                                        SizedBox(height: 15),
                                        Visibility(
                                          maintainAnimation: true,
                                          maintainState: true,
                                          maintainSize: true,
                                          visible: _isSelected[1],
                                          child: Container(
                                            height: 4,
                                            width:
                                                'Branching'.length.toDouble() *
                                                    8,
                                            color: lightBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        drawer: MenuDrawer(),
        body: pages[tabManager.selectedTab],
      );
    });
  }
}
