import 'package:decoder/controllers/provider/user/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/models.dart';
import '../screens/views.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    // User user = context.watch<UserDatabaseProvider>().user;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            user.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          accountEmail: Text("Edad: ${user.age}"),
        ),
        ListTile(
          title: Text("Tipo de diabetes:"),
          subtitle: Text(
            user.diabetesType.type,
            style: TextStyle(fontSize: 17),
          ),
        ),
        ListTile(
          title: Text("Tipo de hipertensión: "),
          subtitle: Text(
            user.hypertensionType.type,
            style: TextStyle(fontSize: 17),
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => UserRegisterView(
                        user: user,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit)),
            IconButton(
              onPressed: () {
                Provider.of<UserDatabaseProvider>(context, listen: false)
                    .deleteUser(user.id);
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
