import 'dart:convert';

import 'package:exemple/conection_check.dart';
import 'package:exemple/data.dart';
import 'package:flutter/material.dart';
import 'package:pop_network/pop_network.dart';

Future<void> main() async {
  await PopNetwork.config(
    baseUrl: "https://pokeapi.co/api/v2/pokemon/",
    mockedEnvironment: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon> list = [];

  void requestApi() {
    final Endpoint endpoint = Endpoint(
      mockStrategy: MockCustom(),
    );
    ApiManager.requestApi(endpoint: endpoint).then((value) {
      if (value is Success) {
        final listMaps = value.data['results'] as List;
        final listGenerate = List.generate(
            listMaps.length, (index) => Pokemon.fromMap(listMaps[index]));
        setState(() {
          list.addAll(listGenerate);
        });
      }
    });
  }

  List<Widget> get listWidget => list.isEmpty
      ? [const Text('Not request Pokemons')]
      : List.generate(list.length, (index) => Text(list[index].name));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const ConectionCheckScreen(),
                ));
              },
              icon: const Icon(Icons.connect_without_contact))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listWidget,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: requestApi,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MockCustom implements MockStrategy {
  @override
  String? getJson() {
    return jsonEncode({
      "results": [
        {
          "name": "Pokemo",
        },
        {
          "name": "Pokemo",
        },
        {
          "name": "Pokemo",
        },
        {
          "name": "Pokemo",
        },
        {
          "name": "Pokemo",
        },
        {
          "name": "Pokemo",
        },
        {
          "name": "Pokemo",
        },
        {
          "name": "Pokemo",
        },
      ]
    });
  }
}
