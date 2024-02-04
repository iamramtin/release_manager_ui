import 'package:release_manager_ui/constant.dart';
import 'package:flutter/material.dart';

class Branching extends StatefulWidget {
  @override
  State<Branching> createState() => _BranchingState();
}

class _BranchingState extends State<Branching> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
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
                                    text: 'Create Branches',
                                  ),
                                  Tab(
                                    text: 'Merge Branches',
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height - 112,
              child: TabBarView(
                children: [
                  Container(
                    color: Colors.greenAccent,
                    child: Center(
                        child: Text(
                      'Create Branches',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  Container(
                    color: Colors.cyan,
                    child: Center(
                        child: Text(
                      'Merge Branches',
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
