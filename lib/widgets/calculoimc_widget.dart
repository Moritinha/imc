import 'dart:math';

import 'package:flutter/material.dart';

class CalculoImcWidget extends StatefulWidget {
  @override
  _CalculoImcWidgetState createState() => _CalculoImcWidgetState();
}

class _CalculoImcWidgetState extends State<CalculoImcWidget> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController alturacontroller = TextEditingController();
  TextEditingController pesocontroller = TextEditingController();
  TextEditingController circunferenciacontroller = TextEditingController();

  String _resultadoimc, _resultadoiac;
  int _radioBtnValue = 1;
  int _radioTypeValue = 1;

  void _handleRadioBtnValChange(int value) {
    setState(() {
      _resultadoiac = _resultadoimc = null;
      _radioBtnValue = value;
    });
  }

  void _handleRadioTypeValChange(int value) {
    setState(() {
      _resultadoiac = _resultadoimc = null;
      _radioTypeValue = value;
    });
  }

  void _calcularimc() {
    double altura = double.parse(alturacontroller.text) / 100;
    double peso = double.parse(pesocontroller.text);
    double imc = peso / pow(altura, 2);

    setState(() {
      _resultadoiac = null;
      _resultadoimc = imc.toStringAsFixed(2) + "\n\n" + getClassificacao(imc);
    });
  }

  void _calculariac() {
    double altura = double.parse(alturacontroller.text) / 100;
    double circunferencia = double.parse(circunferenciacontroller.text);
    double iac = circunferencia / altura * sqrt(altura);

    setState(() {
      _resultadoimc = null;
      _resultadoiac =
          iac.toStringAsFixed(2) + "\n\n" + getClassificacaoIAC(iac);
    });
  }

  String getClassificacao(num imc) {
    String strclassificacao;

    if (_radioBtnValue == 1) {
      if (imc < 18.6)
        strclassificacao = "Peso Abaixo Do Esperado";
      else if (imc < 25)
        strclassificacao = "Peso ideal esperado";
      else if (imc < 30)
        strclassificacao = "Sobrepeso";
      else if (imc < 35)
        strclassificacao = "Obesidade grau I";
      else if (imc < 40)
        strclassificacao = "Obesidade grau II";
      else
        strclassificacao = "Obesidade grau III";
    } else {
      if (imc < 20)
        strclassificacao = "Peso Abaixo Do Esperado";
      else if (imc < 24.9)
        strclassificacao = "Peso ideal esperado";
      else if (imc < 29.9)
        strclassificacao = "Sobrepeso";
      else if (imc < 39.9)
        strclassificacao = "Obesidade grau I";
      else if (imc < 43)
        strclassificacao = "Obesidade grau II";
      else
        strclassificacao = "Obesidade grau III";
    }

    return strclassificacao;
  }

  String getClassificacaoIAC(num iac) {
    String strclassificacao;

    if (_radioBtnValue == 0) {
      if (iac < 8)
        strclassificacao = "Normal";
      else if (iac < 20.9)
        strclassificacao = "Na Media";
      else if (iac < 25)
        strclassificacao = "Sobrepeso";
      else
        strclassificacao = "Obesidade";
    } else {
      if (iac < 21)
        strclassificacao = "Normal";
      else if (iac < 32.9)
        strclassificacao = "Na Media";
      else if (iac < 38)
        strclassificacao = "Sobrepeso";
      else
        strclassificacao = "Obesidade";
    }

    return strclassificacao;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: 0,
                    groupValue: _radioTypeValue,
                    onChanged: _handleRadioTypeValChange,
                  ),
                  new Text("IMC"),
                  Radio(
                    value: 1,
                    groupValue: _radioTypeValue,
                    onChanged: _handleRadioTypeValChange,
                  ),
                  new Text("IAC")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: 0,
                    groupValue: _radioBtnValue,
                    onChanged: _handleRadioBtnValChange,
                  ),
                  new Text("Homem"),
                  Radio(
                    value: 1,
                    groupValue: _radioBtnValue,
                    onChanged: _handleRadioBtnValChange,
                  ),
                  new Text("Mulher")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: alturacontroller,
                validator: (value) {
                  return value.isEmpty ? "Informe sua altura" : null;
                },
                decoration:
                    InputDecoration(labelText: "Digite sua altura em cm:"),
              ),
            ),
            Visibility(
              child: Container(
                margin: EdgeInsets.all(16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: pesocontroller,
                  validator: (value) {
                    return value.isEmpty
                        ? "Informe seu peso, obs sem mentir"
                        : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Digite seu Peso em Kg sem mentir:"),
                ),
              ),
              visible: _radioTypeValue == 0,
            ),
            Visibility(
              child: Container(
                margin: EdgeInsets.all(16),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: circunferenciacontroller,
                  validator: (value) {
                    return value.isEmpty
                        ? "Informe a circunferência do quadril"
                        : null;
                  },
                  decoration:
                      InputDecoration(labelText: "Circunferência do quadril:"),
                ),
              ),
              visible: _radioTypeValue == 1,
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(_resultadoimc == null
                  ? _resultadoiac == null
                      ? ""
                      : "IAC: $_resultadoiac"
                  : "IMC: $_resultadoimc"),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    if (_radioTypeValue == 0)
                      _calcularimc();
                    else
                      _calculariac();
                  }
                },
                child: Text("Calcular resultado"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
