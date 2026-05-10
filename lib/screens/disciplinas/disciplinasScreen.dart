
import 'package:flutter/material.dart';
import 'package:studente_managementapp/services/storageServ.dart';

class DisciplinasScreen extends StatelessWidget {
  const DisciplinasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Disciplina(),
    );
  }
}

class Disciplina extends StatefulWidget {
  const Disciplina({super.key});

  @override
  State<Disciplina> createState() => _DisciplinaState();
}

class _DisciplinaState extends State<Disciplina> {
  final Storageserv _storage = Storageserv();
  List<Disciplina> _disciplinas = [];
  final _nomeCtrl = TextEditingController();
  final _codigoCtrl = TextEditingController();
  final _creditosCtrl = TextEditingController();
  Disciplina? _edit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

