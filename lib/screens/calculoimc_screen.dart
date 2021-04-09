import 'package:flutter/material.dart';
import 'package:lab8/widgets/calculoimc_widget.dart';

class CalculoImcScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("Cálculos de IMC E IAC",
            style: TextStyle(color: Colors.black)),
      ),
      body: CalculoImcWidget(),
    );
  }
}
