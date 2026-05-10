import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:studente_managementapp/models/avaliacao.dart';
import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/models/estudante.dart';
import 'package:studente_managementapp/models/inscricao.dart';
import 'package:studente_managementapp/models/nota.dart';

class Storageserv {

  Future<String> get _pastaDoc async{
    final pasta = await getApplicationDocumentsDirectory();
    return pasta.path;
  }
  //Incricoes
  Future<List<Inscricao>> carregarInscricoes() async {
    try {
      final file = File('${await _pastaDoc}/inscricoes.json');
      print('Ficheiro existe: ${await file.exists()}');
      print('Caminho: ${file.path}');

      if (!await file.exists()) return [];

      final content = await file.readAsString();
      print('Conteudo: $content');

      final List<dynamic> list = jsonDecode(content);
      return list.map((e) => Inscricao.fromJson(e)).toList();
    } catch (e) {
      print('Erro: $e');
      return [];
    }
  }
  
  Future<void> salvarInscricoes(List<Inscricao> inscricao) async{
    try{
      final file = File('${await _pastaDoc}/inscricoes.json');
      final list = inscricao.map((e) => e.toJson()).toList();
      await file.writeAsString(jsonEncode(list));
    }catch(e){
      throw Exception('Falha ao salvar dados');
    }
  }

  //Estudante
  Future<List<Estudante>> carregarEstudante() async{
    try{
      final file = File('${await _pastaDoc}/estudantes.json');
      if(!await file.exists())
        return [];

      final content = await file.readAsString();
      final List<dynamic> list = jsonDecode(content);
      return list.map((e) => Estudante.fromJson(e)).toList();
    }catch(e){
      return [];
    }
  }

  Future<void> salvarEstudante(List<Estudante> estudante) async{
    try{
      final file = File('${await _pastaDoc}/estudantes.json');
      final list = estudante.map((e) => e.toJson()).toList();
      await file.writeAsString(jsonEncode(list));
    }catch(e){
      throw Exception('Falha ao salvar dados');
    }
  }
  
  //Disciplinas
  Future<List<Disciplina>> carregarDisciplinas() async{
    try{
      final file = File('${await _pastaDoc}/disciplinas.json');
      if(!await file.exists())
        return [];

      final content = await file.readAsString();
      final List<dynamic> list = jsonDecode(content);
      return list.map((e) => Disciplina.fromJson(e)).toList();
    }catch(e){
      return [];
    }
  }

  Future<void> salvarDisciplinas(List<Disciplina> disciplina) async{
    try{
      final file = File('${await _pastaDoc}/disciplinas.json');
      final list = disciplina.map((e) => e.toJson()).toList();
      await file.writeAsString(jsonEncode(list));
    }catch(e){
      throw Exception('Falhas ao salvar Diciplinas');
    }
  }

  //Avaliacoes
  Future<List<Avaliacao>> carregarAvaliacoes()async{
    try{
      final file = File('${await _pastaDoc}/avaliacoes.json');
      if(!await file.exists())
        return [];

      final content = await file.readAsString();
      final List<dynamic> list = jsonDecode(content);
      return list.map((e)=> Avaliacao.fromJson(e)).toList();
    }catch (e){
      return [];
    }
  }

  Future<void> salvarAvalicoes(List<Avaliacao> avalicoes) async {
    try {
      final file = File('${await _pastaDoc}/avaliacoes.json');
      final list = avalicoes.map((e) => e.toJson()).toList();
      await file.writeAsString(jsonEncode(list));
    }catch(e){
      throw Exception('Falha ao salvar Avaliacoes!');
    }
  }

  //Notas
  Future<List<Nota>> carregarNotas() async{
    try{
      final file = File('${await _pastaDoc}/notas.json');

      if(!await file.exists())
        return [];

      final content = await file.readAsString();
      final List<dynamic> list = jsonDecode(content);
      return list.map((item)=>Nota.fromJson(item)).toList();
    }catch(e){
      return [];
    }
  }

  Future<void> salvarNotas(List<Nota> notas)async{
    try{
      final caminho = await _pastaDoc;
      final file = File('$caminho/notas.json');
      final list = notas.map((n)=> n.toJson()).toList();
      await file.writeAsString(jsonEncode(list));
    }catch(e){
      throw Exception('Falha ao salvar notas: $e');
    }
  }
}