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
    _carregar();
  }

  Future<void> _carregar() async{
    final disciplinas = await _storage.carregarDisciplinas();
    final notas = await _storage.carregarNotas();
    setState(() {
      _disciplinas =disciplinas;
      _notas = notas;
    });
  }

   double _media(int disciplinaId){
    final notas = _notas.where((e) => e.disciplinaId == disciplinaId).toList();
   return Nota.calcularMedia(notas);
  }

  void mostrMSG(String msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estatisticas'),
      ),
      body: _disciplinas.isEmpty? const Center(
        child: Text('Nenhuma disciplina encontrada'),
      ) : ListView.builder(
        itemCount: _disciplinas.length,
          itemBuilder: (context, index){
            final disciplina = _disciplinas[index];
            final media = _media(disciplina.id);
              return ListTile(
                title: Text(disciplina.nome),
                subtitle: Text('Medis: ${media.toStringAsFixed(1)}'),
                trailing: Text(
                    media >= 10 ? 'Aprovado' : 'Reprovado',
                  style: TextStyle(
                    color: media >= 10 ? Colors.green : Colors.red,
                  ),
                ),
              );
          }
          )
    );
  }
}

