import 'package:flutter/material.dart';
import 'package:studente_managementapp/models/avaliacao.dart';
import 'package:studente_managementapp/services/storageServ.dart';

class Avaliacoesscreen extends StatelessWidget {
  const Avaliacoesscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Avaliacoes());
  }
}

class Avaliacoes extends StatefulWidget {
  const Avaliacoes({super.key});

  @override
  State<Avaliacoes> createState() => _AvaliacoesState();
}

class _AvaliacoesState extends State<Avaliacoes> {
  final Storageserv _storageserv = Storageserv();
  List<Avaliacao> _avalicoes = [];

  @override
  void initState() {
    super.initState();
    _carregarAvaliacoes();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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

}
