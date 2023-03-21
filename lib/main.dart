import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  void _readTag() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      print(tag.toString());
      NfcManager.instance.stopSession();
    });
  }
}
