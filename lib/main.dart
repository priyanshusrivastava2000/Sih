import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:simple_permissions/simple_permissions.dart';

void main(){
  runApp(new Myapp());
}

class Myapp extends StatefulWidget{
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Myapp>{
  String _reader = '';
  Permission permission = Permission.Camera;

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(title: new Text("Scanner"),),
        body: new Column(
          children: <Widget>[
            new Padding(padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            new RaisedButton(
              splashColor: Colors.blue,
                color: Colors.blueAccent,
                child: new Text("Scan", style: new TextStyle(fontSize: 20.0,color: Colors.black),),
                onPressed: scan,
            ),
            new Padding(padding: const EdgeInsets.symmetric(vertical: 10.0),),
            new Text('$_reader',softWrap: true,style: new TextStyle(fontSize: 30.0, color: Colors.blue),),
          ],
        ),
      ),
    );
  }
  requestPermission() async{
     var result = await SimplePermissions.requestPermission(permission);
  }
  scan() async{
    try{
      String reader = await BarcodeScanner.scan();
      if (!mounted){return;
    }
      setState(()=> _reader = reader);
  }on PlatformException catch(e){
      if (e.code==BarcodeScanner.CameraAccessDenied){
        requestPermission();
      }else{
        setState(()=> _reader = "user without Scanning");
      }
    }
    }
}
