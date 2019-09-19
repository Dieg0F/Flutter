import 'package:flutter/material.dart';

class BreedDetailsPopupMenu {
  const BreedDetailsPopupMenu({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<BreedDetailsPopupMenu> popupMenuItems =
    const <BreedDetailsPopupMenu>[
  const BreedDetailsPopupMenu(title: 'Update', icon: Icons.update),
  const BreedDetailsPopupMenu(title: 'Remove', icon: Icons.remove)
];

class BreedDetailsPopupMenuCard extends StatelessWidget {
  const BreedDetailsPopupMenuCard({Key key, this.popupMenuItem})
      : super(key: key);

  final BreedDetailsPopupMenu popupMenuItem;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(popupMenuItem.icon, size: 128.0, color: textStyle.color),
            Text(popupMenuItem.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
