import 'package:flutter/material.dart';
import 'package:pop_network/pop_network.dart';

class ConectionCheckScreen extends StatefulWidget {
  const ConectionCheckScreen({Key? key}) : super(key: key);

  @override
  State<ConectionCheckScreen> createState() => _ConectionCheckScreenState();
}

class _ConectionCheckScreenState extends State<ConectionCheckScreen> {
  bool? conection;

  String get stringConection {
    if (conection != null) {
      return conection!
          ? 'Device connected to the internet'
          : 'Device disconnected from internet';
    } else {
      return 'Not verified';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(stringConection),
            ),
            ElevatedButton(
              onPressed: () async {
                conection = await ConnectionChecker.isConnectedToInternet();

                setState(() {});
              },
              child: const Text(
                'Test Conaction',
              ),
            )
          ],
        ),
      ),
    );
  }
}
