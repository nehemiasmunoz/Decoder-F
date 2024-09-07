import 'package:flutter/material.dart';

class EnumDetail extends StatelessWidget {
  const EnumDetail({super.key, required this.title, required this.items});
  final String title;
  final List items;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, i) => ExpansionTile(
            title: Text(items[i].type),
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * .04,
                ),
                child: Text(
                  items[i].description,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
