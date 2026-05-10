import 'package:flutter/material.dart';
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/services/storageServ.dart';

class DisciplinasScreen extends StatelessWidget {
  const DisciplinasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Disciplinab());
  }
}

class Disciplinab extends StatefulWidget {
  const Disciplinab({super.key});

  @override
  State<Disciplinab> createState() => _DisciplinabState();
}

class _DisciplinabState extends State<Disciplinab> {
  final Storageserv _storage = Storageserv();
  List<Disciplina> _disciplinas = [];
  final _nomeCtrl = TextEditingController();
  final _codigoCtrl = TextEditingController();
  final _creditosCtrl = TextEditingController();
  Disciplina? _edit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    final list = await _storage.carregarDisciplinas();
    setState(() => _disciplinas = list);
  }

  void mostraMSG(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> salvarDisciplina() async {
    print('_salvarDisciplina chamado');
    if (_nomeCtrl.text.isEmpty ||
        _codigoCtrl.text.isEmpty ||
        _creditosCtrl.text.isEmpty) {
      mostraMSG('Preenche todos os campos');
      return;
    }
    if (_edit == null) {
      final nova = Disciplina(
        id: DateTime.now().millisecondsSinceEpoch,
        nome: _nomeCtrl.text,
        codigo: _codigoCtrl.text,
        creditos: int.parse(_creditosCtrl.text),
      );
      setState(() => _disciplinas.add(nova));
    } else {
      final index = _disciplinas.indexWhere((e) => e.id == _edit!.id);
      setState(() {
        _disciplinas[index] = Disciplina(
          id: _edit!.id,
          nome: _nomeCtrl.text,
          codigo: _codigoCtrl.text,
          creditos: int.parse(_creditosCtrl.text),
        );
        _edit = null;
      });
    }
    await _storage.salvarDisciplinas(_disciplinas);
    _nomeCtrl.clear();
    _codigoCtrl.clear();
    _creditosCtrl.clear();
    mostraMSG('Disciplina salva com sucesso');
  }

  Future<void> _removerDisciplina(int id) async {
    setState(() => _disciplinas.removeWhere((d) => d.id == id));
    await _storage.salvarDisciplinas(_disciplinas);
    mostraMSG('Dicisplina removida');
  }

  void prencher(Disciplina d) {
    setState(() => _edit = d);
    _nomeCtrl.text = d.nome;
    _codigoCtrl.text = d.codigo;
    _creditosCtrl.text = d.creditos.toString();
  }

  void _confirmarRemocao(Disciplina d) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover'),
        content: Text('Remover ${d.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removerDisciplina(d.id);
            },
            child: const Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('Disciplinas')),
      body: Column(
        children: [
          Column(
            children: [
              TextField(
                controller: _nomeCtrl,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _codigoCtrl,
                decoration: const InputDecoration(labelText: 'Codigo'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _creditosCtrl,
                decoration: const InputDecoration(labelText: 'Creditos'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: salvarDisciplina,
                child: Text(
                  _edit == null ? 'Criar Disciplina' : 'Guardar Alteracoes',
                ),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: _disciplinas.isEmpty
                ? const Center(child: Text('Nenhuma disciplina registada.'))
                : ListView.builder(
                    itemCount: _disciplinas.length,
                    itemBuilder: (context, index) {
                      final d = _disciplinas[index];
                      return ListTile(
                        title: Text(d.nome),
                        subtitle: Text('${d.codigo} · ${d.creditos} créditos'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => prencher(d),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _confirmarRemocao(d),
                            ),
                          ],
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
