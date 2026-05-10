import 'package:flutter/material.dart';
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/models/nota.dart';
import 'package:studente_managementapp/services/storageServ.dart';

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
  Storageserv _storage = Storageserv();
  List<Disciplina> _disciplinas = [];
  List<Nota> _notas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //carregar();
  }


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

