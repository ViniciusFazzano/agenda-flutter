// lib/providers/contato_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/contato.dart';

class ContatoProvider with ChangeNotifier {
  List<Contato> _contatos = [];

  List<Contato> get contatos => _contatos;

  Future<void> carregarContatos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? contatosString = prefs.getString('contatos');

    if (contatosString != null) {
      final List<dynamic> decoded = jsonDecode(contatosString);
      _contatos = decoded.map((item) => Contato.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> adicionarContato(Contato contato) async {
    _contatos.add(contato);
    await _salvarContatos();
    notifyListeners();
  }

  Future<void> editarContato(int index, Contato contato) async {
    _contatos[index] = contato;
    await _salvarContatos();
    notifyListeners();
  }

  Future<void> removerContato(int index) async {
    _contatos.removeAt(index);
    await _salvarContatos();
    notifyListeners();
  }

  Future<void> _salvarContatos() async {
    final prefs = await SharedPreferences.getInstance();
    final String contatosString = jsonEncode(
      _contatos.map((contato) => contato.toJson()).toList(),
    );
    prefs.setString('contatos', contatosString);
  }
}
