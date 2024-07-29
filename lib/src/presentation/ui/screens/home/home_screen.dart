import 'package:decoder/src/presentation/ui/components/components.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: DrawerMenu()),
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: HomeScreenBody(),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
              flex: 3,
              child: TextField(
                maxLines: 1,
                autocorrect: false,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton.filled(
                onPressed: null,
                icon: Icon(Icons.search),
              ),
            )
          ]),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i) => GestureDetector(
                onTap: () => Navigator.pushNamed(context, "detail"),
                child: const Card(
                  child: ListTile(
                    title: Text("hi"),
                    trailing: Icon(Icons.arrow_forward_ios_sharp),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
