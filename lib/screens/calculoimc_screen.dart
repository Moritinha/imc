import 'package:flutter/material.dart';
import 'package:lab8/widgets/calculoimc_widget.dart';

class CalculoImcScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo IMC"),
      ),
      body: CalculoImcWidget(),
    );
  }
}
