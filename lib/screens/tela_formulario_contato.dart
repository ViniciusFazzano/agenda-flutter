// lib/screens/tela_formulario_contato.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:email_validator/email_validator.dart';
import '../providers/contato_provider.dart';
import '../models/contato.dart';

class TelaFormularioContato extends StatefulWidget {
  final int? index;
  final Contato? contato;

  TelaFormularioContato({this.index, this.contato});

  @override
  _TelaFormularioContatoState createState() => _TelaFormularioContatoState();
}

class _TelaFormularioContatoState extends State<TelaFormularioContato> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();

  var telefoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####');

  @override
  void initState() {
    if (widget.contato != null) {
      _nomeController.text = widget.contato!.nome;
      _telefoneController.text = widget.contato!.telefone;
      _emailController.text = widget.contato!.email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contatoProvider = Provider.of<ContatoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.contato == null ? 'Adicionar Contato' : 'Editar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                inputFormatters: [telefoneFormatter],
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O telefone é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !EmailValidator.validate(value)) {
                    return 'Insira um e-mail válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final novoContato = Contato(
                      nome: _nomeController.text,
                      telefone: _telefoneController.text,
                      email: _emailController.text,
                    );

                    if (widget.contato == null) {
                      contatoProvider.adicionarContato(novoContato);
                    } else {
                      contatoProvider.editarContato(widget.index!, novoContato);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.contato == null ? 'Salvar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
