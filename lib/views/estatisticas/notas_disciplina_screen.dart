

import 'package:flutter/material.dart';
import 'package:studente_managementapp/controlers/avaliacao_ctr.dart';
import 'package:studente_managementapp/controlers/notas_ctr.dart';
import 'package:studente_managementapp/models/avaliacao.dart';
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/models/estudante.dart';
import 'package:studente_managementapp/models/nota.dart';


class NotasDisciplinaScreen extends StatelessWidget {
  const NotasDisciplinaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _DisciplinaNotas());
  }
}

class _DisciplinaNotas extends StatefulWidget {
  const _DisciplinaNotas();

  @override
  State<_DisciplinaNotas> createState() => _DisciplinaNotasState();
}

class _DisciplinaNotasState extends State<_DisciplinaNotas> {
  final NotaCtr _notaOp = NotaCtr();
  final AvaliacaoCtr _avaliacaoCtr = AvaliacaoCtr();
  List<Estudante> _estudantes = [];
  List<Disciplina> _disciplinas = [];
  List<Nota> _notas = [];
  List<Avaliacao> _avaliacoes = [];
  List<Avaliacao> _avaliacoesFiltradas = [];
  Disciplina? _disciplinaSelect;
  Avaliacao? _avaliacaoSelect;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    final estudantes = await _notaOp.carregarEstudantes();
    final disciplinas = await _notaOp.carregarDisciplinas();
    final notas = await _notaOp.carregarNotas();
    final avaliacoes = await _avaliacaoCtr.carregarAvaliacoes();
    setState(() {
      _estudantes = estudantes;
      _disciplinas = disciplinas;
      _notas = notas;
      _avaliacoes = avaliacoes;
    });
  }

  void _onDisciplinaChanged(Disciplina? d) {
    setState(() {
      _disciplinaSelect = d;
      _avaliacaoSelect = null;
      // filtra avaliações da disciplina selecionada
      _avaliacoesFiltradas = _avaliacoes
          .where((a) => a.disciplinaId == d!.id)
          .toList();
    });
  }

  List<Nota> get _notasFiltradas {
    if (_disciplinaSelect == null || _avaliacaoSelect == null) return [];
    return _notas
        .where((n) =>
    n.disciplinaId == _disciplinaSelect!.id &&
        n.avaliacaoId == _avaliacaoSelect!.id)
        .toList();
  }

  String _nomeEstudante(int id) {
    return _notaOp.nomeEstudante(_estudantes, id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notas por Disciplina')),
      body: Column(
        children: [
          DropdownButton<Disciplina>(
            isExpanded: true,
            hint: const Text('Seleciona Disciplina'),
            value: _disciplinaSelect,
            items: _disciplinas.map((d) => DropdownMenuItem(
              value: d,
              child: Text(d.nome),
            )).toList(),
            onChanged: _onDisciplinaChanged,
          ),
          const SizedBox(height: 12),
          DropdownButton<Avaliacao>(
            isExpanded: true,
            hint: const Text('Seleciona Tipo de Avaliação'),
            value: _avaliacaoSelect,
            items: _avaliacoesFiltradas.map((a) => DropdownMenuItem(
              value: a,
              child: Text('${a.nome} (${a.cotacao} pts)'),
            )).toList(),
            onChanged: (a) => setState(() => _avaliacaoSelect = a),
          ),
          const Divider(),
          Expanded(
            child: _notasFiltradas.isEmpty
                ? const Center(child: Text('Nenhuma nota encontrada.'))
                : ListView.builder(
              itemCount: _notasFiltradas.length,
              itemBuilder: (context, index) {
                final n = _notasFiltradas[index];
                return ListTile(
                  title: Text(_nomeEstudante(n.estudanteId)),
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