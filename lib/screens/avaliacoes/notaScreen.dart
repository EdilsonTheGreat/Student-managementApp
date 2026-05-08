import 'package:flutter/material.dart';

class Notascreen extends StatelessWidget {
  const Notascreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Notas(),
    );
  }
}

class _Notas extends StatefulWidget {
  const _Notas({super.key});

  @override
  State<_Notas> createState() => _NotasState();
}

class _NotasState extends State<_Notas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Atribuir Nota')
        ),
        body: const Center(child: Text('Processando...')
        ),
    );
  }
}

