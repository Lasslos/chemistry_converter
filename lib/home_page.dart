import 'package:flutter/material.dart';
import 'package:periodic_table/periodic_table.dart';

import 'matter_old.dart';
import 'matter_display_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({final Key? key}) : super(key: key);
  final GlobalKey<MatterDisplayerWidgetState> matterDisplayerKey = GlobalKey();

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Chemistry Converter'),
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(15).copyWith(bottom: 0),
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: MatterDisplayerWidget(key: matterDisplayerKey),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    matterDisplayerKey.currentState?.matter = Matter(formula: [
                      periodicTable.first,
                      periodicTable.first,
                      periodicTable
                          .firstWhere((final element) => element.symbol == 'O')
                    ]);
                  }, // TODO: Implement onPressed
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    matterDisplayerKey.currentState?.matter = null;
                  }, //TODO
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      );
}
