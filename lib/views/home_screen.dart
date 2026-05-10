import 'package:flutter/material.dart';
import 'package:studente_managementapp/views/avaliacoes/avaliacoes_screen.dart';
import 'package:studente_managementapp/views/avaliacoes/lancamento_notas_screen.dart';
import 'package:studente_managementapp/views/disciplinas/disciplinas_screen.dart';
import 'package:studente_managementapp/views/estatisticas/notas_disciplina_screen.dart';
import 'package:studente_managementapp/views/estudante/estudante_screen.dart';
import 'package:studente_managementapp/views/incricao/incricao_screen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final ButtonStyle estilo = ElevatedButton.styleFrom(
    backgroundColor: Colors.brown,
    foregroundColor: Colors.white,
    elevation: 2,
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gestão de Notas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Text(
              'Registo',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: estilo,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => EstudanteScreen())),
              child: const Text('Estudantes'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: estilo,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DisciplinasScreen())),
              child: const Text('Disciplinas'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: estilo,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => InscricaoScreen())),
              child: const Text('Inscrições'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: estilo,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AvaliacoesScreen())),
              child: const Text('Avaliações'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: estilo,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => LancamentoNotasScreen())),
              child: const Text('Lançamento de Notas'),
            ),

            const SizedBox(height: 24),


            const Text(
              'Visualização',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: estilo,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NotasDisciplinaScreen())),
              child: const Text('Notas por Disciplina'),
            ),
          ],
        ),
      ),
    );
  }
}