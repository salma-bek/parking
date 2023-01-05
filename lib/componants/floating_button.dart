import 'package:flutter/material.dart';

import '../views/admin/add_place.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlace()),
          );
        },
        tooltip: 'New Place',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        highlightElevation: 50,
      ),
    );
  }
}