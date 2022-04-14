import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'bluetooth.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'B1-06',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _fieldText = TextEditingController();
  late ConfettiController _controllerCenter;
  late BluetoothConnection connection;

// connect(String address) async {
//   try {
//     connection = await BluetoothConnection.toAddress(address);
//     print('Connected to the device');

//     connection.input!.listen((Uint8List data) {
//       //Data entry point
//       print(ascii.decode(data));
//     });

//   } catch (exception) {
//     print('Cannot connect, exception occured');
//   }
// }
  @override
void initState(){
  _controllerCenter = ConfettiController(duration: const Duration(microseconds: 50));
  _controllerCenter.play();
  // printBluetooth();
  super.initState();
}

// void printBluetooth() async
// {
//   FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
//   print('Heloooooooooooooooooooooooooo');
//   print(await _bluetooth.getBondedDevices());
// }

@override
void dispose() {
  _controllerCenter.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Image.asset('image/logo.png', height: 150, width: 100)),
        backgroundColor: Colors.white,
        actions: [Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => BluetoothApp()));
        },
        child: Icon(
          Icons.bluetooth,
          color: Colors.black,
          size: 26.0,
        )))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 64,width: 36,),
            SizedBox(
              width: 80,
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                showCursor: false,
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                controller: _fieldText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (text){
                  
                  _fieldText.text=text[0];
                  _controllerCenter.play();
                  print('done');
                },
              ),
            ),
            ConfettiWidget(
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  false, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
            )
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
