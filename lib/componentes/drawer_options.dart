import 'package:flutter/material.dart';

class DescriptionTileOnDrawer extends StatelessWidget {
  const DescriptionTileOnDrawer(
      {Key? key, required this.title, this.trailing, required this.proximaTela})
      : super(key: key);

  final String title;
  final Widget? trailing;
  final Widget proximaTela;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => proximaTela),
        );
      },
      child: ListTile(
        trailing: trailing,
        title: Text(title),
      ),
    );
  }
}
