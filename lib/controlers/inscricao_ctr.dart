

import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/models/estudante.dart';
import 'package:studente_managementapp/models/inscricao.dart';
import 'package:studente_managementapp/services/storage_serv.dart';

class InscricaoCtr {
  final Storageserv _storage = Storageserv();

  Future<List<Estudante>> carregarEstudantes() async {
    return await _storage.carregarEstudante();
  }

  Future<List<Disciplina>> carregarDisciplinas() async {
    return await _storage.carregarDisciplinas();
  }

  Future<List<Inscricao>> carregarInscricoes() async {
    return await _storage.carregarInscricoes();
  }

  Future<void> inscrever(
      int estudanteId,
      int disciplinaId,
      ) async {
    // Carrega as inscrições existentes primeiro
    final inscricoes = await _storage.carregarInscricoes();

    final nova = Inscricao(
      id: DateTime.now().millisecondsSinceEpoch,
      estudanteId: estudanteId,
      disciplinaId: disciplinaId,
    );
    inscricoes.add(nova);
    await _storage.salvarInscricoes(inscricoes);
  }

  bool jaInscrito(
      List<Inscricao> inscricoes,
      int estudanteId,
      int disciplinaId,
      ) {
    return inscricoes.any(
          (i) => i.estudanteId == estudanteId && i.disciplinaId == disciplinaId,
    );
  }

  List<Estudante> pesquisar(List<Estudante> estudantes, String texto) {
    if (texto.isEmpty) return estudantes;
    return estudantes
        .where((e) => e.nome.toLowerCase().contains(texto.toLowerCase()))
        .toList();
  }
}