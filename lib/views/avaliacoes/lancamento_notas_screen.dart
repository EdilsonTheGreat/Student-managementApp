


import 'package:flutter/material.dart';
import 'package:studente_managementapp/controlers/avaliacao_ctr.dart';
import 'package:studente_managementapp/controlers/notas_ctr.dart';
import 'package:studente_managementapp/models/avaliacao.dart';
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/models/estudante.dart';
import 'package:studente_managementapp/models/inscricao.dart';
import 'package:studente_managementapp/models/nota.dart';


class LancamentoNotasScreen extends StatelessWidget {
  const LancamentoNotasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _LancamentoNotas());
  }
}

class _LancamentoNotas extends StatefulWidget {
  const _LancamentoNotas();

  @override
  State<_LancamentoNotas> createState() => _LancamentoNotasState();
}

class _LancamentoNotasState extends State<_LancamentoNotas> {
  final NotaCtr _notaOp = NotaCtr();
  final AvaliacaoCtr _avaliacaoOp = AvaliacaoCtr();
  List<Estudante> _estudantes = [];
  List<Disciplina> _disciplinas = [];
  List<Inscricao> _inscricoes = [];
  List<Nota> _notas = [];
  List<Avaliacao> _avaliacoes = [];
  List<Disciplina> _disciplinasDoEstudante = [];
  List<Avaliacao> _avaliacoesDaDisciplina = [];
  Estudante? _estudanteSelect;
  Disciplina? _disciplinaSelect;
  Avaliacao? _avaliacaoSelect;
  final _valorCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _mostrarMSG(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _carregar() async {
    final estudantes = await _notaOp.carregarEstudantes();
    final disciplinas = await _notaOp.carregarDisciplinas();
    final inscricoes = await _notaOp.carregarInscricoes();
    final notas = await _notaOp.carregarNotas();
    final avaliacoes = await _avaliacaoOp.carregarAvaliacoes();
    setState(() {
      _estudantes = estudantes;
      _disciplinas = disciplinas;
      _inscricoes = inscricoes;
      _notas = notas;
      _avaliacoes = avaliacoes;
    });
  }

  void _onEstudanteChanged(Estudante? e) {
    setState(() {
      _estudanteSelect = e;
      _disciplinaSelect = null;
      _avaliacaoSelect = null;
      _avaliacoesDaDisciplina = [];
      _disciplinasDoEstudante = _notaOp.disciplinasDoEstudante(
        _disciplinas,
        _inscricoes,
        e!.id,
      );
    });
  }

  void _onDisciplinaChanged(Disciplina? d) {
    setState(() {
      _disciplinaSelect = d;
      _avaliacaoSelect = null;
      _avaliacoesDaDisciplina = _avaliacoes
          .where((a) => a.disciplinaId == d!.id)
          .toList();
    });
  }

  Future<void> _lancar() async {
    if (_estudanteSelect == null ||
        _disciplinaSelect == null ||
        _avaliacaoSelect == null ||
        _valorCtrl.text.isEmpty) {
      _mostrarMSG('Preenche todos os campos');
      return;
    }

    await _notaOp.lancarNota(
      _notas,
      _estudanteSelect!.id,
      _disciplinaSelect!.id,
      _avaliacaoSelect!.id, // ✅ novo
      double.parse(_valorCtrl.text),
    );

    setState(() {
      _estudanteSelect = null;
      _disciplinaSelect = null;
      _avaliacaoSelect = null;
      _disciplinasDoEstudante = [];
      _avaliacoesDaDisciplina = [];
    });
    _valorCtrl.clear();
    _mostrarMSG('Nota lançada com sucesso');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lançamento de Notas')),
      body: Column(
        children: [
          DropdownButton<Estudante>(
            isExpanded: true,
            hint: const Text('Seleciona Estudante'),
            value: _estudanteSelect,
            items: _estudantes.map((e) => DropdownMenuItem(
              value: e,
              child: Text(e.nome),
            )).toList(),
            onChanged: _onEstudanteChanged,
          ),
          const SizedBox(height: 12),
          DropdownButton<Disciplina>(
            isExpanded: true,
            hint: const Text('Seleciona Disciplina'),
            value: _disciplinaSelect,
            items: _disciplinasDoEstudante.map((d) => DropdownMenuItem(
              value: d,
              child: Text(d.nome),
            )).toList(),
            onChanged: _onDisciplinaChanged,
          ),
          const SizedBox(height: 12),
          DropdownButton<Avaliacao>(
            isExpanded: true,
            hint: const Text('Seleciona Avaliação'),
            value: _avaliacaoSelect,
            items: _avaliacoesDaDisciplina.map((a) => DropdownMenuItem(
              value: a,
              child: Text('${a.nome} (${a.cotacao} pts)'),
            )).toList(),
            onChanged: (a) => setState(() => _avaliacaoSelect = a),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _valorCtrl,
            decoration: const InputDecoration(labelText: 'Nota'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _lancar,
            child: const Text('Lançar Nota'),
          ),
        ],
      ),
    );
  }
}