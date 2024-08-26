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
          accountName: Text('Hi ${user.name}'),
          accountEmail: Text("Age ${user.age}"),
        ),
        ListTile(
          title: Text("Diabetes type: ${user.diabetesType.name} "),
        ),
        ListTile(
          title: Text("Hypertension type:${user.hypertensionType} "),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            IconButton(
              onPressed: () {
                Provider.of<UserDatabaseProvider>(context, listen: false)
                    .deleteUserData(user);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("User: ${user.name} Deleted")));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        )
      ],
    );
  }
}
