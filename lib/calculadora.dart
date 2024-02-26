import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculadora/memoria.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final _memoria = Memoria();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora"),
      ),
      body: Column(
        children: [
          _bildDisplay(),
          Divider(
            height: 0.1,
          ),
          _buildTeclado()
        ],
      ),
    );
  }

  _bildDisplay() {
    return Expanded(
        child: Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: AutoSizeText(
              _memoria.resultado,
              maxFontSize: 80,
              minFontSize: 20,
              maxLines: 1,
              textAlign: TextAlign.end,
              style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 80),
            ),
          )
        ],
      ),
    ));
  }

  _buildTecla(String texto,
      {Color textColor = Colors.white,
      int flex = 1,
      Color fundo = Colors.black}) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: fundo),
        onPressed: () {
          setState(() {
            _memoria.applyCommand(texto);
          });
        },
        child: Text(
          texto,
          style: TextStyle(color: textColor, fontSize: 24),
        ),
      ),
    );
  }

  ///

  _buildTeclado() {
    return Container(
      color: Colors.white,
      height: 400,
      child: Column(
        children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTecla('AC', textColor: Colors.orange),
              _buildTecla('DEL', textColor: Colors.orange),
              _buildTecla('%', textColor: Colors.orange),
              _buildTecla('/', textColor: Colors.orange),
            ],
          )),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTecla('7'),
              _buildTecla('8'),
              _buildTecla('9'),
              _buildTecla('*', textColor: Colors.orange),
            ],
          )),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTecla('4'),
              _buildTecla('5'),
              _buildTecla('6'),
              _buildTecla('+', textColor: Colors.orange),
            ],
          )),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTecla('1'),
              _buildTecla('2'),
              _buildTecla('3'),
              _buildTecla('-', textColor: Colors.orange),
            ],
          )),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTecla('0', flex: 2),
              _buildTecla('.'),
              _buildTecla('EXP'),
              _buildTecla('=', textColor: Colors.orange),
            ],
          ))
        ],
      ),
    );
  }
}
