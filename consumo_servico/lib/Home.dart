import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCep = TextEditingController();

  String _resultado = "Resultado";


  _recuperarCep() async {

    String cepDigitado = _controllerCep.text;

    String url = "https://viacep.com.br/ws/${cepDigitado}/json";
    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode( response.body );
    String logradouro = retorno["logradouro"];
    String uf = retorno["uf"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = " ${uf},   ${localidade},   ${bairro},   ${logradouro}";
    });


    print(
      "Respota: logradouro: ${logradouro}, uf: ${uf}, bairo: ${bairro}, localidade: ${localidade}"
    );



    //print("resposta: " + response.body);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de Serviços WEB"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o CEP: EX: 00000000"
              ),
              style: TextStyle(
                fontSize: 20
              ),
              controller: _controllerCep,
            ),
            RaisedButton(
              child: Text("Clique Aqui"),
              onPressed: _recuperarCep,
            ),
            Text( _resultado )
          ],
        ),
      ),
    );
  }
}
