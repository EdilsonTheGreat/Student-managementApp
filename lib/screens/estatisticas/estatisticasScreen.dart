import 'package:flutter/material.dart';

class Estatisticasscreen extends StatelessWidget {
  const Estatisticasscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Estatisticas(),
    );
  }
}

class _Estatisticas extends StatefulWidget {
  const _Estatisticas({super.key});

  @override
  State<_Estatisticas> createState() => _EstatisticasState();
}

class _EstatisticasState extends State<_Estatisticas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estatisticas'),
      ),
      body: Center(child: Text('Processando'),),
    );
  }
}

