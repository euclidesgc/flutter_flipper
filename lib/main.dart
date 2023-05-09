import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // const isHomologationApp = true;

  // if (isHomologationApp) {
  //   FlipperClient flipperClient = FlipperClient.getDefault();
  //   flipperClient.addPlugin(FlipperNetworkPlugin());
  //   flipperClient.addPlugin(FlipperSharedPreferencesPlugin());
  //   flipperClient.start();
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final catFacts = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder(
                valueListenable: catFacts,
                builder: (context, value, _) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cat Fact:\n$value'),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final int randomFact = Random().nextInt(5);

          final dio = Dio();
          const url = 'https://cat-fact.herokuapp.com/facts';
          final response = await dio.get(url);
          catFacts.value = response.data[randomFact]['text'];
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    catFacts.dispose();
    super.dispose();
  }
}
