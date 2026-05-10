import 'package:flutter/material.dart';
import 'package:studente_managementapp/models/avaliacao.dart';
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/services/storageServ.dart';

class AvaliacoesScreen extends StatelessWidget {
  const AvaliacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _Avaliacoes());
  }
}

class _Avaliacoes extends StatefulWidget {
  const _Avaliacoes({super.key});

  @override
  State<_Avaliacoes> createState() => _AvaliacoesState();
}

class _AvaliacoesState extends State<_Avaliacoes> {
  final Storageserv _storage = Storageserv();
  List<Avaliacao> _avalicoes = [];
  List<Disciplina> _disciplinas = [];
  final _nomeCtrl = TextEditingController();
  final _pesoCtrl = TextEditingController();
  Disciplina? _disciplinaSelect;

  @override
  void initState() {
    super.initState();
    _carregarAvaliacoes();
  }

  void mostrarMSG(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Future<void> _carregarAvaliacoes() async {
    final avaliacoes = await _storage.carregarAvaliacoes();
    final disciplinas = await _storage.carregarDisciplinas();
    setState(() {
      _avalicoes = avaliacoes;
      _disciplinas = disciplinas;
    });
  }

  Future<void> _salvarAvaliacoes() async {
    if (_nomeCtrl.text.isEmpty || _pesoCtrl.text.isEmpty ||
        _disciplinaSelect == null) {
      mostrarMSG('Por favor preencha todos os campos');
    }
    final nova = Avaliacao(
        id: DateTime.now().millisecondsSinceEpoch,
        nome: _nomeCtrl.text,
        peso: double.parse(_pesoCtrl.text),
        disciplinaId: _disciplinaSelect!.id);

    setState(() => _avalicoes.add(nova));
    await _storage.guardarAvalicoes(_avalicoes);

    _nomeCtrl.clear();
    _pesoCtrl.clear();
    setState(() => _disciplinaSelect =null);

    mostrarMSG('Avaliacao adicionda com sucesso');
  }

  Future<void> _removerAvalicoes(int id) async {
    setState(() => _avalicoes.removeWhere((a) => a.id == id));
    await _storage.guardarAvalicoes(_avalicoes);
  }

  String nomeDisciplina(int id){
    return _disciplinas.firstWhere((e) => e.id == id).nome;
  }

  void _confirmarRemocao(Avaliacao avaliacao) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Remover Avaliação'),
            content: Text(
                'Tens a certeza que queres remover "${avaliacao.nome}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _removerAvalicoes(avaliacao.id);
                },
                child: const Text(
                    'Remover', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alvaliacoes'),
      ),
      body: Column(
        children: [
        TextField(
          controller: _nomeCtrl,
          decoration: const InputDecoration(labelText: 'Nome da Avaliacao'
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _pesoCtrl,
          decoration: InputDecoration(labelText: 'Peso'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        DropdownButton<Disciplina>(
          isExpanded: true,
          hint: const Text('Selecione a Disciplina'),
          value: _disciplinaSelect,
          items: _disciplinas.map((e) => DropdownMenuItem(
            value: e,
              child: Text(e.nome),
          )).toList(),
          onChanged: (e) => setState(() => _disciplinaSelect =e ),
        ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: _salvarAvaliacoes,
              child: const Text("Salvar Avaliacao"),
          ),
          const Divider(height: 32),
          Expanded(
              child: _avalicoes.isEmpty? const Center(
                child: Text('Nenhuma avaliacao resgitrada'))
                  : ListView.builder(
                itemCount: _avalicoes.length,
                  itemBuilder: (context, index){
                  final ava = _avalicoes[index];
                  return ListTile(
                    title: Text(ava.nome),
                    subtitle: Text(
                      '${nomeDisciplina(ava.disciplinaId)} .Peso: ${(ava.peso*100).toStringAsFixed(0)}%',
                    ),
                    trailing: IconButton(
                        onPressed: () => _removerAvalicoes(ava.id),
                        icon: const Icon(Icons.delete)),
                  );
                  })
          ),
        ],
      ),
    );
  }


}
