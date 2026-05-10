import 'package:flutter/material.dart';
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/models/estudante.dart';
import 'package:studente_managementapp/models/nota.dart';
import 'package:studente_managementapp/services/storageServ.dart';

class NotasDisciplinaScreen extends StatelessWidget {
  const NotasDisciplinaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DisciplinaNotas(),
    );
  }
}

class DisciplinaNotas extends StatefulWidget {
  const DisciplinaNotas({super.key});

  @override
  State<DisciplinaNotas> createState() => _DisciplinaNotasState();
}

class _DisciplinaNotasState extends State<DisciplinaNotas> {
  final Storageserv _storage = Storageserv();
  List<Estudante> _estudantes = [];
  List<Disciplina> _disciplinas = [];
  List<Nota> _notas = [];
  Disciplina? _disciplinaselect;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    final estudantes = await _storage.carregarEstudante();
    final disciplinas = await _storage.carregarDisciplinas();
    final notas = await _storage.carregarNotas();
    setState(() {
      _estudantes = estudantes;
      _disciplinas = disciplinas;
      _notas = notas;
    });
  }

  String _nomeEstudante(int id) {
    return _estudantes.firstWhere((e) => e.id == id).nome;
  }

  List<Nota> get _notasFiltradas {
    if (_disciplinaselect == null) return [];
    return _notas.where((n) => n.disciplinaId == _disciplinaselect!.id).toList();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notas por Disciplina')),
      body: Column(
        children: [
          DropdownButton<Disciplina>(
            isExpanded: true,
            hint: const Text('Selecciona Disciplina'),
            value: _disciplinaselect,
            items: _disciplinas.map((d) => DropdownMenuItem(
              value: d,
              child: Text(d.nome),
            )).toList(),
            onChanged: (d) => setState(() => _disciplinaselect = d),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _notasFiltradas.isEmpty
                ? const Center(child: Text('Nenhuma nota encontrada.'))
                : ListView.builder(
              itemCount: _notasFiltradas.length,
              itemBuilder: (context, index) {
                final n = _notasFiltradas[index];
                return ListTile(
                  title: Text(_nomeEstudante(n.estudanteId)),
                  subtitle: Text(n.aprovado ? 'Aprovado' : 'Reprovado'),
                  trailing: Text(
                    n.valor.toString(),
                    style: TextStyle(
                      color: n.aprovado ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}

