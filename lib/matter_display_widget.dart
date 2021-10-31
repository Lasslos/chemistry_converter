import 'package:flutter/material.dart';

import 'matter_old.dart';

class MatterDisplayerWidget extends StatefulWidget {
  const MatterDisplayerWidget({final Key? key}) : super(key: key);

  @override
  MatterDisplayerWidgetState createState() => MatterDisplayerWidgetState();
}

class MatterDisplayerWidgetState extends State<MatterDisplayerWidget> {
  Matter? _matter;

  @override
  Widget build(final BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(35),
            decoration: BoxDecoration(
              border: Border.all(),
              shape: BoxShape.circle,
            ),
          ),
          const Align(
            child: MatterElementDisplayWidget(), //TODO: moles
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: MatterElementDisplayWidget(), //TODO: Number of atoms
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: MatterElementDisplayWidget(), //TODO: grams
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: MatterElementDisplayWidget(), //TODO: Liters
          ),
        ],
      ),
    );
  }

  set matter(final Matter? matter) {
    setState(() {
      _matter = matter;
    });
  }

  Matter? get matter => _matter;
}

class MatterElementDisplayWidget extends StatelessWidget {
  const MatterElementDisplayWidget({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(11),
      child: const Placeholder(color: Colors.deepOrange),
    );
  }
}
