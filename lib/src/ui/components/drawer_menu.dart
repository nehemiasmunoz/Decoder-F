import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        UserAccountsDrawerHeader(
          accountName: Text('User Name'),
          accountEmail: Text("User Age"),
        ),
        ListTile(
          title: Text("Has Diabetes: "),
        ),
        ListTile(
          title: Text("Has Hypertension: "),
        ),
        ListTile(
          title: Text("Diabetes type: "),
        ),
        ListTile(
          title: Text("Hypertension type: "),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: null, icon: Icon(Icons.edit)),
            IconButton(onPressed: null, icon: Icon(Icons.delete))
          ],
        )
      ],
    );
  }
}
