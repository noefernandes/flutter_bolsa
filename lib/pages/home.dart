import 'package:bolsa_app/pages/result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<Map> getData(String symbol) async {
  var request = Uri.parse("https://api.hgbrasil.com/finance?key=b37d1ec9");
  http.Response response = await http.get(request);
  //print(response.statusCode);
  return json.decode(response.body);
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController symbolController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Map _data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ações na bolsa"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Insira o código da empresa',
                            hintStyle: TextStyle(color: Colors.blueAccent)),
                        style: const TextStyle(
                            color: Colors.blueAccent, fontSize: 25.0),
                        controller: symbolController,
                        validator: (value) {
                          if (value!.isEmpty) return "Insira a empresa!";
                          return null;
                        },
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _data = await getData(symbolController.text);

                                if (!mounted) return;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Result(
                                            symbolController.text, _data)));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent),
                            child: const Text("Buscar",
                                style: TextStyle(color: Colors.white)),
                          ))
                    ]))));
  }
}
