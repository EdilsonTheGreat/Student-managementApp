

import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/models/estudante.dart';
import 'package:studente_managementapp/models/inscricao.dart';
import 'package:studente_managementapp/models/nota.dart';
import 'package:studente_managementapp/services/storage_serv.dart';

class NotaCtr {
  final Storageserv _storage = Storageserv();

  Future<List<Estudante>> carregarEstudantes() async {
    return await _storage.carregarEstudante();
  }

  Future<List<Disciplina>> carregarDisciplinas() async {
    return await _storage.carregarDisciplinas();
  }

  Future<List<Nota>> carregarNotas() async {
    return await _storage.carregarNotas();
  }

  Future<List<Inscricao>> carregarInscricoes() async {
    return await _storage.carregarInscricoes();
  }

  Future<void> lancarNota(
      List<Nota> notas,
      int estudanteId,
      int disciplinaId,
      int avaliacaoId,
      double valor,
      ) async {
    final nova = Nota(
      id: DateTime.now().millisecondsSinceEpoch,
      estudanteId: estudanteId,
      disciplinaId: disciplinaId,
      avaliacaoId: avaliacaoId,
      valor: valor,
    );
    notas.add(nova);
    await _storage.salvarNotas(notas);
  }

  List<Disciplina> disciplinasDoEstudante(
      List<Disciplina> disciplinas,
      List<Inscricao> inscricoes,
      int estudanteId,
      ) {
    final ids = inscricoes
        .where((i) => i.estudanteId == estudanteId)
        .map((i) => i.disciplinaId)
        .toList();
    return disciplinas.where((d) => ids.contains(d.id)).toList();
  }

  String nomeEstudante(List<Estudante> estudantes, int id) {
    return estudantes.firstWhere((e) => e.id == id).nome;
  }

  List<Nota> notasPorDisciplina(List<Nota> notas, int disciplinaId) {
    return notas.where((n) => n.disciplinaId == disciplinaId).toList();
  }

  double calcularMedia(List<Nota> notas, int disciplinaId) {
    final filtradas = notasPorDisciplina(notas, disciplinaId);
    return Nota.calcularMedia(filtradas);
  }
}