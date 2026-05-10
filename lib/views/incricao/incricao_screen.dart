


import 'package:flutter/material.dart';
import 'package:studente_managementapp/controlers/inscricao_ctr.dart';
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/models/estudante.dart';
import 'package:studente_managementapp/models/inscricao.dart';

class InscricaoScreen extends StatelessWidget {
  const InscricaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _InscricaoBody());
  }
}


class _InscricaoBody extends StatefulWidget {
  const _InscricaoBody();

  @override
  State<_InscricaoBody> createState() => _InscricaoBodyState();
}

class _InscricaoBodyState extends State<_InscricaoBody> {
  final InscricaoCtr _operacoes = InscricaoCtr();
  List<Estudante> _estudantes = [];
  List<Estudante> _estudantesFiltrados = [];
  List<Disciplina> _disciplinas = [];
  List<Inscricao> _inscricoes = [];
  Estudante? _estudanteSelect;
  Disciplina? _disciplinaSelect;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _mostrarMSG(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)));
  }

  Future<void> _carregar() async {
    final estudantes = await _operacoes.carregarEstudantes();
    final disciplinas = await _operacoes.carregarDisciplinas();
    final inscricoes = await _operacoes.carregarInscricoes();
    setState(() {
      _estudantes = estudantes;
      _estudantesFiltrados = estudantes;
      _disciplinas = disciplinas;
      _inscricoes = inscricoes;
    });
  }

  void _pesquisar(String texto) {
    setState(() {
      _estudantesFiltrados = _operacoes.pesquisar(_estudantes, texto);
    });
  }

  Future<void> _inscrever() async {
    if (_estudanteSelect == null || _disciplinaSelect == null) {
      _mostrarMSG('Seleciona estudante e disciplina');
      return;
    }

    if (_operacoes.jaInscrito(
      _inscricoes,
      _estudanteSelect!.id,
      _disciplinaSelect!.id,
    )) {
      _mostrarMSG('Estudante já inscrito nesta disciplina');
      return;
    }

    await _operacoes.inscrever(
      _estudanteSelect!.id,
      _disciplinaSelect!.id,
    );

    // Recarrega as inscrições após guardar
    final inscricoes = await _operacoes.carregarInscricoes();
    setState(() {
      _inscricoes = inscricoes;
      _estudanteSelect = null;
      _disciplinaSelect = null;
    });
    _mostrarMSG('Estudante inscrito com sucesso');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscrição')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: _pesquisar,
              decoration: const InputDecoration(
                hintText: 'Pesquisar estudante',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: _estudantesFiltrados.isEmpty
                  ? const Center(child: Text('Nenhum estudante encontrado.'))
                  : ListView.builder(
                itemCount: _estudantesFiltrados.length,
                itemBuilder: (context, index) {
                  final e = _estudantesFiltrados[index];
                  return Card(
                    child: ListTile(
                      title: Text(e.nome),
                      subtitle: Text(e.numero),
                      selected: _estudanteSelect == e,
                      onTap: () => setState(() => _estudanteSelect = e),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<Disciplina>(
              value: _disciplinaSelect,
              decoration: const InputDecoration(
                labelText: 'Disciplina',
                border: OutlineInputBorder(),
              ),
              items: _disciplinas.map((d) => DropdownMenuItem(
                value: d,
                child: Text(d.nome),
              )).toList(),
              onChanged: (d) => setState(() => _disciplinaSelect = d),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _inscrever,
                child: const Text('Inscrever'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}