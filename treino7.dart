import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Treino7 extends StatefulWidget {
  @override
  _Treino7State createState() => _Treino7State();
}

class _Treino7State extends State<Treino7> {

  TextEditingController cepDigitado = TextEditingController();

  String _bairro ='0';
  String _localidade='0';
  String _logradouro='0';
  String _cep;

  _calcularCep() async{
    String _url = 'https://viacep.com.br/ws/${_cep}/json/';

    http.Response response;

    response= await http.get( _url);

    print(response.statusCode.toString());

    setState(() {
      if (response.statusCode.toString()=='200'){
        setState(() {
          Map<String, dynamic> resposta = json.decode(response.body);
          _bairro = resposta['bairro'];
          _localidade = resposta['localidade'];
          _logradouro = resposta['logradouro'];
        });
      }else{
        setState(() {
          String _bairro ='não encontrado';
          String _localidade='não encontrado';
          String _logradouro='não encontrado';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        AppBar(
          title: Text('CEP'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body:
        Container(
          child:
          Padding(padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Digite o CEP'),
                    controller: cepDigitado,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                    RaisedButton(
                        child: Text('Pesquisar endereço',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                        ),
                        color: Colors.deepPurple,
                        onPressed:(){
                          setState(() {
                            _cep= cepDigitado.text;
                            _calcularCep();
                          });
                        }
                    ),
                  ],
                  ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 8),
                      child: Text(_logradouro,
                      style: TextStyle(
                        fontSize: 20
                      ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 8),
                      child: Text(_bairro,
                      style: TextStyle(
                        fontSize: 20
                      ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 8),
                      child: Text(_localidade,
                      style: TextStyle(
                        fontSize: 20
                      ),
                      ),
                    ),
                  ],)
                ],
              ),
            ),
          ),
        )
    );
  }
}

