


import 'package:studente_managementapp/models/avaliacao.dart';
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/services/storage_serv.dart';

class AvaliacaoCtr {
  final Storageserv _storage = Storageserv();

  Future<List<Avaliacao>> carregarAvaliacoes() async {
    return await _storage.carregarAvaliacoes();
  }

  Future<List<Disciplina>> carregarDisciplinas() async {
    return await _storage.carregarDisciplinas();
  }

  Future<void> adicionarAvaliacao(
      List<Avaliacao> avaliacoes,
      String nome,
      int cotacao,
      int disciplinaId,
      ) async {
    final nova = Avaliacao(
      id: DateTime.now().millisecondsSinceEpoch,
      nome: nome,
      cotacao: cotacao,
      disciplinaId: disciplinaId,
    );
    avaliacoes.add(nova);
    await _storage.salvarAvalicoes(avaliacoes);
  }

  Future<void> removerAvaliacao(List<Avaliacao> avaliacoes, int id) async {
    avaliacoes.removeWhere((a) => a.id == id);
    await _storage.salvarAvalicoes(avaliacoes);
  }

  String nomeDisciplina(List<Disciplina> disciplinas, int id) {
    return disciplinas.firstWhere((d) => d.id == id).nome;
  }
}