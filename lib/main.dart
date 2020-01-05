import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() => runApp(QrClass());

class QrClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result="Welcome!";

  Future qrscan() async{
    try
    {
      String qrresult = await BarcodeScanner.scan();
      setState(() {
        result = qrresult;
      });

    }
    on PlatformException catch (exception)                   //When camera permission is denied
    {
      if(exception.code == BarcodeScanner.CameraAccessDenied)
      {
      setState(() {
        result = "Camera Permmission denied!";
      });
    }
    else
    {
      setState(() {
        result = "Unknown error $exception!";
      });
    }  
  }
  on FormatException                       //When you press the back button before scanning
  {
    setState(() {
      result = "You pressed the back button before scanning!";
    });
  }
  catch (exception)
  {
      setState(() {
        result = "Unknown error $exception!";
      });
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        title: Text("QR Scanner"),
        backgroundColor: Colors.purpleAccent,

      ),
      body: 
      Center(
        child: Text(
          result,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500
        ),),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: qrscan,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}