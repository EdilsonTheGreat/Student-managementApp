
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/services/storage_serv.dart';

class DisciplinaCtr {
  final Storageserv _storage = Storageserv();

  Future<List<Disciplina>> carregarDisciplinas() async {
    return await _storage.carregarDisciplinas();
  }

  Future<void> adicionarDisciplina(
      List<Disciplina> disciplinas,
      String nome,
      String codigo,
      int creditos,
      ) async {
    final nova = Disciplina(
      id: DateTime.now().millisecondsSinceEpoch,
      nome: nome,
      codigo: codigo,
      creditos: creditos,
    );
    disciplinas.add(nova);
    await _storage.salvarDisciplinas(disciplinas);
  }

  Future<void> editarDisciplina(
      List<Disciplina> disciplinas,
      Disciplina editando,
      String nome,
      String codigo,
      int creditos,
      ) async {
    final index = disciplinas.indexWhere((d) => d.id == editando.id);
    disciplinas[index] = Disciplina(
      id: editando.id,
      nome: nome,
      codigo: codigo,
      creditos: creditos,
    );
    await _storage.salvarDisciplinas(disciplinas);
  }

  Future<void> removerDisciplina(List<Disciplina> disciplinas, int id) async {
    disciplinas.removeWhere((d) => d.id == id);
    await _storage.salvarDisciplinas(disciplinas);
  }
}