// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/contato_provider.dart';
import 'screens/tela_lista_contatos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContatoProvider(),
      child: MaterialApp(
        title: 'Agenda de Contatos',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TelaListaContatos(),
      ),
    );
  }
}
