import 'package:flutter/material.dart';
import 'package:studente_managementapp/models/avaliacao.dart';
import 'package:studente_managementapp/services/storageServ.dart';

class Avaliacoesscreen extends StatelessWidget {
  const Avaliacoesscreen({super.key});

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
  final Storageserv _storageserv = Storageserv();
  List<Avaliacao> _avalicoes = [];

  @override
  void initState() {
    super.initState();
    _carregarAvaliacoes();
  }


  Future<void> _carregarAvaliacoes() async {
    final list = await _storageserv.carregarAvaliacoes();
    ;
    setState(() => _avalicoes = list);
  }

  Future<void> _removerAvalicoes(int id) async {
    setState(() => _avalicoes.removeWhere((a) => a.id == id));
    await _storageserv.guardarAvalicoes(_avalicoes);
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
          title: Text('Avaliacoes'),
        ),
        body: _avalicoes.isEmpty ? const Center(
          child: Text('Sem avalicoes registradas, por favor adicine',
            style: TextStyle(color: Colors.grey),
          ),
        ) : ListView.builder(
            itemCount: _avalicoes.length,
            itemBuilder: (context, index) {
              final avaliacao = _avalicoes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(leading: Icon(Icons.assignment),
                  title: Text(avaliacao.nome
                  ),
                  subtitle: Text(
                      'Peso: ${(avaliacao.peso * 100).toStringAsFixed(0)}%'),
                  trailing: IconButton(
                    onPressed: () => _confirmarRemocao(avaliacao),
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
              );
            },
        ),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },
      child: Icon(Icons.add),
      ),
    );
  }


}
