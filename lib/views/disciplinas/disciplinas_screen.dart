import 'package:flutter/material.dart';
import 'package:studente_managementapp/controlers/disciplina_ctr.dart';
import 'package:studente_managementapp/models/disciplina.dart';

class DisciplinasScreen extends StatelessWidget {
  const DisciplinasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _Disciplinab());
  }
}

class _Disciplinab extends StatefulWidget {
  const _Disciplinab();

  @override
  State<_Disciplinab> createState() => _DisciplinabState();
}

class _DisciplinabState extends State<_Disciplinab> {
  final DisciplinaCtr _operacoes = DisciplinaCtr();

  List<Disciplina> _disciplinas = [];
  final _nomeCtrl = TextEditingController();
  final _codigoCtrl = TextEditingController();
  final _creditosCtrl = TextEditingController();
  Disciplina? _edit;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _mostrarMSG(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _carregar() async {
    final lista = await _operacoes.carregarDisciplinas();
    setState(() => _disciplinas = lista);
  }

  Future<void> _salvar() async {
    if (_nomeCtrl.text.isEmpty ||
        _codigoCtrl.text.isEmpty ||
        _creditosCtrl.text.isEmpty) {
      _mostrarMSG('Preenche todos os campos');
      return;
    }

    if (_edit == null) {
      await _operacoes.adicionarDisciplina(
        _disciplinas,
        _nomeCtrl.text,
        _codigoCtrl.text,
        int.parse(_creditosCtrl.text),
      );
    } else {
      await _operacoes.editarDisciplina(
        _disciplinas,
        _edit!,
        _nomeCtrl.text,
        _codigoCtrl.text,
        int.parse(_creditosCtrl.text),
      );
      setState(() => _edit = null);
    }

    setState(() {});
    _nomeCtrl.clear();
    _codigoCtrl.clear();
    _creditosCtrl.clear();
    _mostrarMSG('Disciplina salva com sucesso');
  }

  Future<void> _remover(int id) async {
    await _operacoes.removerDisciplina(_disciplinas, id);
    setState(() {});
    _mostrarMSG('Disciplina removida');
  }

  void _preencher(Disciplina d) {
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
              _remover(d.id);
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
      appBar: AppBar(
        title: const Text(
          'Disciplinas',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: _nomeCtrl,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _codigoCtrl,
            decoration: const InputDecoration(labelText: 'Código'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _creditosCtrl,
            decoration: const InputDecoration(labelText: 'Créditos'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _salvar,
            child: Text(
              _edit == null ? 'Criar Disciplina' : 'Guardar Alterações',
            ),
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
                              onPressed: () => _preencher(d),
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
