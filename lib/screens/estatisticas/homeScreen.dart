
import 'package:flutter/material.dart';
import 'package:studente_managementapp/screens/avaliacoes/avaliacoesScreen.dart';
import 'package:studente_managementapp/screens/disciplinas/disciplinasScreen.dart';
import 'package:studente_managementapp/screens/estatisticas/estatisticasScreen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestao de Notas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=> DisciplinasScreen())
            );
          },
              child: const Text('Disciplinas'),
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => AvaliacoesScreen())
                );
              },
            child:const Text('Avaliacoes'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: (){},
            child: const Text('Lancamento de Notas'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: (){},
              child:const Text('Notas por Disciplina'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Estatisticasscreen())
            );
          },
              child: const Text('Estatisticas'),
          ),
        ],
      ),
    );
  }
}

