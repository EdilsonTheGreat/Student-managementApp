import 'package:flutter/material.dart';
import 'package:studente_managementapp/models/avaliacao.dart';
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/operacoes/avaliacaoOpera.dart';


class AvaliacoesScreen extends StatelessWidget {
  const AvaliacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _Avaliacoes());
  }
}

class _Avaliacoes extends StatefulWidget {
  const _Avaliacoes();

  @override
  State<_Avaliacoes> createState() => _AvaliacoesState();
}

class _AvaliacoesState extends State<_Avaliacoes> {
  final AvaliacaoOpera _operacoes = AvaliacaoOpera();
  List<Avaliacao> _avaliacoes = [];
  List<Disciplina> _disciplinas = [];
  final _nomeCtrl = TextEditingController();
  final _pesoCtrl = TextEditingController();
  Disciplina? _disciplinaSelect;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _mostrarMSG(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Future<void> _carregar() async {
    final avaliacoes = await _operacoes.carregarAvaliacoes();
    final disciplinas = await _operacoes.carregarDisciplinas();
    setState(() {
      _avaliacoes = avaliacoes;
      _disciplinas = disciplinas;
    });
  }

  Future<void> _salvarAvaliacoes() async {
    if (_nomeCtrl.text.isEmpty ||
        _pesoCtrl.text.isEmpty ||
        _disciplinaSelect == null) {
      _mostrarMSG('Por favor preencha todos os campos');
      return;
    }

    await _operacoes.adicionarAvaliacao(
      _avaliacoes,
      _nomeCtrl.text,
      double.parse(_pesoCtrl.text),
      _disciplinaSelect!.id,
    );

    setState(() {});
    _nomeCtrl.clear();
    _pesoCtrl.clear();
    setState(() => _disciplinaSelect = null);
    _mostrarMSG('Avaliação adicionada com sucesso');
  }

  Future<void> _remover(int id) async {
    await _operacoes.removerAvaliacao(_avaliacoes, id);
    setState(() {});
  }

  void _confirmarRemocao(Avaliacao avaliacao) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover Avaliação'),
        content: Text('Tens a certeza que queres remover "${avaliacao.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _remover(avaliacao.id);
            },
            child: const Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avaliações')),
      body: Column(
        children: [
          TextField(
            controller: _nomeCtrl,
            decoration: const InputDecoration(labelText: 'Nome da Avaliação'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _pesoCtrl,
            decoration: const InputDecoration(labelText: 'Peso'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          DropdownButton<Disciplina>(
            isExpanded: true,
            hint: const Text('Selecione a Disciplina'),
            value: _disciplinaSelect,
            items: _disciplinas.map((d) => DropdownMenuItem(
              value: d,
              child: Text(d.nome),
            )).toList(),
            onChanged: (d) => setState(() => _disciplinaSelect = d),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _salvarAvaliacoes,
            child: const Text('Salvar Avaliação'),
          ),
          const Divider(height: 32),
          Expanded(
            child: _avaliacoes.isEmpty
                ? const Center(child: Text('Nenhuma avaliação registada.'))
                : ListView.builder(
              itemCount: _avaliacoes.length,
              itemBuilder: (context, index) {
                final a = _avaliacoes[index];
                return ListTile(
                  title: Text(a.nome),
                  subtitle: Text(
                    '${_operacoes.nomeDisciplina(_disciplinas, a.disciplinaId)} · Peso: ${(a.peso * 100).toStringAsFixed(0)}%',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmarRemocao(a),
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