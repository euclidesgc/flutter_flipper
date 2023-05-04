import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlipperClient flipperClient = FlipperClient.getDefault();

  flipperClient.addPlugin(FlipperNetworkPlugin());
  flipperClient.addPlugin(FlipperReduxInspectorPlugin());
  flipperClient.addPlugin(FlipperSharedPreferencesPlugin());
  flipperClient.start();
  
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'lalala',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Dio dio = Dio();
          dio
              .get('https://cat-fact.herokuapp.com/facts')
              .then((value) => debugPrint('$value'));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
