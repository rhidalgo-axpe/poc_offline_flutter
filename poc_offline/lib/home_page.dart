import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:poc_offline/item.dart';
import 'file_type.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _readJson();
    super.initState();
  }

  final String _title = 'PoC Offline';

  List<Item> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return Card(
              child: Row(
                children: [
                  Image.network(item.url, width: 120),
                  Column(
                    children: [
                      Text(item.name),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          print("Abrir archivo");
                        },
                        child: const Text('Abrir'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _readJson() async {
    final String response = await rootBundle.loadString('assets/files.json');
    final data = await json.decode(response);
    final dataItems = data['files'];
    final List<Item> items = Item.fromList(dataItems);
    setState(() {
      _items = items;
    });
  }
}
