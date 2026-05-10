import 'package:flutter/material.dart';
import 'package:studente_managementapp/controlers/estudante_ctr.dart';
import 'package:studente_managementapp/models/estudante.dart';

class EstudanteScreen extends StatelessWidget {
  const EstudanteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _EstudanteBody());
  }
}

class _EstudanteBody extends StatefulWidget {
  const _EstudanteBody();

  @override
  State<_EstudanteBody> createState() => _EstudanteBodyState();
}

class _EstudanteBodyState extends State<_EstudanteBody> {
  final EstudanteCtr _operacoes = EstudanteCtr();
  List<Estudante> _estudantes = [];
  List<Estudante> _estudantesFiltrados = [];
  Estudante? _edit;
  final _nomeCtrl = TextEditingController();
  final _numeroCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _mostrarMSG(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _carregar() async {
    final lista = await _operacoes.carregarEstudantes();
    setState(() {
      _estudantes = lista;
      _estudantesFiltrados = lista;
    });
  }

  void _pesquisar(String texto) {
    setState(() {
      _estudantesFiltrados = _operacoes.pesquisar(_estudantes, texto);
    });
  }

  bool _emailValido(String email) {
    return email.contains('@') && email.contains('.');
  }

  Future<void> _salvar() async {
    if (_nomeCtrl.text.isEmpty ||
        _numeroCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty) {
      _mostrarMSG('Preenche todos os campos');
      return;
    }

    if (!_emailValido(_emailCtrl.text)) {
      _mostrarMSG('Email inválido');
      return;
    }

    if (_edit == null) {
      await _operacoes.adicionarEstudante(
        _estudantes,
        _nomeCtrl.text,
        _numeroCtrl.text,
        _emailCtrl.text,
      );
    } else {
      await _operacoes.editarEstudante(
        _estudantes,
        _edit!,
        _nomeCtrl.text,
        _numeroCtrl.text,
        _emailCtrl.text,
      );
      setState(() => _edit = null);
    }

    setState(() => _estudantesFiltrados = _estudantes);
    _nomeCtrl.clear();
    _numeroCtrl.clear();
    _emailCtrl.clear();
    _mostrarMSG('Estudante salvo com sucesso');
  }

  Future<void> _remover(int id) async {
    await _operacoes.removerEstudante(_estudantes, id);
    setState(() => _estudantesFiltrados = _estudantes);
    _mostrarMSG('Estudante removido');
  }

  void _preencher(Estudante e) {
    setState(() => _edit = e);
    _nomeCtrl.text = e.nome;
    _numeroCtrl.text = e.numero;
    _emailCtrl.text = e.email;
  }

  void _confirmarRemocao(Estudante e) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover'),
        content: Text('Remover ${e.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _remover(e.id);
            },
            child: const Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _mostrarFormulario() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(_edit == null ? 'Novo Estudante' : 'Editar Estudante'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomeCtrl,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _numeroCtrl,
              decoration: const InputDecoration(labelText: 'Número'),
              keyboardType: TextInputType.number, // ✅ teclado numérico
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress, // ✅ teclado email
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _salvar();
            },
            child: const Text('Guardar'),
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
          'Estudantes',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: _pesquisar,
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: _estudantesFiltrados.isEmpty
                ? const Center(child: Text('Nenhum estudante encontrado.'))
                : ListView.builder(
                    itemCount: _estudantesFiltrados.length,
                    itemBuilder: (context, index) {
                      final e = _estudantesFiltrados[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(e.nome),
                          subtitle: Text(e.numero),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _preencher(e);
                                  _mostrarFormulario();
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () => _confirmarRemocao(e),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormulario,
        child: const Icon(Icons.add),
      ),
    );
  }
}
