import 'package:decoder/src/data/provider/user/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/models.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserDatabaseProvider>().user;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('User Name ${user.name}'),
          accountEmail: Text("User Age ${user.age}"),
        ),
        ListTile(
          title: Text("Has Diabetes: ${user.hasDiabetes} "),
        ),
        ListTile(
          title: Text("Has Hypertension: ${user.hasHypertension}"),
        ),
        ListTile(
          title: Text("Diabetes type: ${user.diabetesType} "),
        ),
        ListTile(
          title: Text("Hypertension type:${user.hypertensionType} "),
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
