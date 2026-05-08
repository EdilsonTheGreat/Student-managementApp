import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:studente_managementapp/models/avaliacao.dart';
import 'package:studente_managementapp/models/nota.dart';

class Storageserv {

  Future<String> get _pastaDoc async{
    final pasta = await getApplicationDocumentsDirectory();
    return pasta.path;
  }

  Future<List<Avaliacao>> carregarAvaliacoes()async{
    try{
      final caminho = await _pastaDoc;
      final file = File('$caminho/avaliacoes.json');

      if(!await file.exists())
        return [];

      final content = await file.readAsString();
      final List<dynamic> list = jsonDecode(content);
      return list.map((item)=> Avaliacao.fromJson(item)).toList();
    }catch (e){
      return [];
    }
  }

  Future<void> guardarAvalicoes(List<Avaliacao> avalicoes) async{
    try{
      final caminho = await _pastaDoc;
      final file = File('$caminho/avaliacoes.json');
      final list = avalicoes.map((a) => a.toJson()).toList();
      await file.writeAsString(jsonEncode(list));
    }catch (e){
      throw Exception('Falha ao salvar avalicoes: $e');
    }
  }

  Future<List<Nota>> carregarNotas() async{
    try{
      final caminho =await _pastaDoc;
      final file = File('$caminho/notas.json');

      if(!await file.exists())
        return [];

      final content = await file.readAsString();
      final List<dynamic> list = jsonDecode(content);
      return list.map((item)=>Nota.fromJson(item)).toList();
    }catch(e){
      return [];
    }
  }

  Future<void> guardarNotas(List<Nota> notas)async{
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