import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String s = '';
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String batteryL = "Unknown";
  void getBatteryLevel() {
    platform.invokeMethod('getBatteryLevel').then((value) {
      setState(() {
        batteryL = 'battery level is $value %.';
      });
    }).catchError((onError) {
      setState(() {
        batteryL = 'faild to get battery level $onError ';
      });
    });
  }

  var cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFECF0F3),
        elevation: 0,
        toolbarHeight: size.height / 200,
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFECF0F3),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                getBatteryLevel();
              },
              child: Text('$batteryL'),
            ),
          ),
        ),
      ),
    );
  }
}
