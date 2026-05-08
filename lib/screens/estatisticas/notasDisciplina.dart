import 'package:flutter/material.dart';

class Notasdisciplina extends StatelessWidget {
  const Notasdisciplina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _DisciplinaNotas(),
    );
  }
}

class _DisciplinaNotas extends StatefulWidget {
  const _DisciplinaNotas({super.key});

  @override
  State<_DisciplinaNotas> createState() => _DisciplinaNotasState();
}

class _DisciplinaNotasState extends State<_DisciplinaNotas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notas'),
      ),
      body: Center(child: Text('Processando...'),
      ),
    );
  }
}

