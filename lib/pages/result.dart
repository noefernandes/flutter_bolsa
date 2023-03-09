import 'package:flutter/material.dart';

class Currency {
  String name = "";
  late String buy;
  late String sell;
  late String variation;
}

class Result extends StatelessWidget {
  final Map _data;
  final String _symbol;

  const Result(this._symbol, this._data, {super.key});

  List<Widget> getInfo(String symbol) {
    Currency currency = Currency();
    currency.name = _data["results"]["currencies"][_symbol.toUpperCase()]
            ["name"]
        .toString();

    currency.buy =
        _data["results"]["currencies"][_symbol.toUpperCase()]["buy"].toString();
    currency.sell = _data["results"]["currencies"][_symbol.toUpperCase()]
            ["sell"]
        .toString();
    currency.variation = _data["results"]["currencies"][_symbol.toUpperCase()]
            ["variation"]
        .toString();

    return <Widget>[
      Text("Nome: ${currency.name}",
          style: const TextStyle(color: Colors.blueAccent, fontSize: 25.0)),
      Text("Comprar: ${currency.buy}",
          style: const TextStyle(color: Colors.blueAccent, fontSize: 25.0)),
      Text("Vender: ${currency.sell}",
          style: const TextStyle(color: Colors.blueAccent, fontSize: 25.0)),
      Text("Variação: ${currency.variation}",
          style: const TextStyle(color: Colors.blueAccent, fontSize: 25.0))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Detalhes"), backgroundColor: Colors.blueAccent),
        backgroundColor: Colors.white,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getInfo(_symbol)));
  }
}
