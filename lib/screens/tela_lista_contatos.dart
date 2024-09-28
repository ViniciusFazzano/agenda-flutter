// lib/screens/tela_lista_contatos.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/contato_provider.dart';
import 'tela_formulario_contato.dart';

class TelaListaContatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contatoProvider = Provider.of<ContatoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Contatos'),
      ),
      body: ListView.builder(
        itemCount: contatoProvider.contatos.length,
        itemBuilder: (context, index) {
          final contato = contatoProvider.contatos[index];
          return ListTile(
            title: Text(contato.nome),
            subtitle: Text('${contato.telefone} \n${contato.email}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TelaFormularioContato(index: index, contato: contato),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaFormularioContato()),
          );
        },
      ),
    );
  }
}
