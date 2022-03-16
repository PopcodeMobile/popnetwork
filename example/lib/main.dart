import 'package:exemple/data.dart';
import 'package:flutter/material.dart';
import 'package:pop_network/pop_network.dart';

Future<void> main() async {
  await Network.config(baseUrl: "https://pokeapi.co/api/v2/pokemon/");
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
      home: const MyHomePage(title: 'Flutter Demo Request'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon> list = [];

  void requestApi() {
    ApiManager.requestApi().then((value) {
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
        title: Text(widget.title),
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
