import 'package:flutter/material.dart';
import 'package:studente_managementapp/screens/avaliacoes/avaliacoesScreen.dart';
import 'package:studente_managementapp/screens/avaliacoes/notaScreen.dart';
import 'package:studente_managementapp/screens/estatisticas/estatisticasScreen.dart';
import 'package:studente_managementapp/screens/homeScreen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: '',
      home: Homescreen(),
      //home: Estatisticasscreen(),
      //home: Avaliacoesscreen(),
      //home: NotaScreen(),
    );
  }
}

