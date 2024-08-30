import 'package:decoder/src/data/provider/user/user_database_provider.dart';
import 'package:decoder/src/presentation/ui/screens/screens.dart';
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
          accountName: Text('${user.name}'),
          accountEmail: Text("Edad: ${user.age}"),
        ),
        ListTile(
          title: Text("Tipo de diabetes: ${user.diabetesType.name} "),
        ),
        ListTile(
          title: Text("Tipo de hipertensión:${user.hypertensionType.name} "),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => UserRegisterScreen(
                        userData: user,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit)),
            IconButton(
              onPressed: () {
                Provider.of<UserDatabaseProvider>(context, listen: false)
                    .deleteUserData(user);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Usuario: ${user.name} Eliminado")));
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
