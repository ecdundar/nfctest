import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("NFC Test")),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder<bool>(
                  future: NfcManager.instance.isAvailable(),
                  builder: (context, snapshot) => SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: _readTag, child: const Text('Read Tag'))
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }

  String kartNo = "";
  void _readTag() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var list = tag.data.entries.first;
      kartNo = "";
      var index = 0;
      for (var item in list.value.entries.first.value) {
        int sayi = item;
        kartNo =
            "$kartNo${(index == 0 ? "" : "-")}${sayi.toRadixString(16).padLeft(2, '0')}"
                .trim()
                .toUpperCase();
        index++;
      }
      print(kartNo);
      NfcManager.instance.stopSession();
    });
  }
}
