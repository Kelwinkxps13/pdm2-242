import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Tela1(),
  ));
}

class Tela1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela 1'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegar para a TelaForm (Formulário)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaForm()),
            );
          },
          child: Text('Ir para o Formulário'),
        ),
      ),
    );
  }
}

class TelaForm extends StatefulWidget {
  @override
  _TelaFormState createState() => _TelaFormState();
}

class _TelaFormState extends State<TelaForm> {
  // Chave para o formulário
  final _formKey = GlobalKey<FormState>();

  // Variáveis para armazenar os valores dos campos
  String? _nome;
  String? _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Criação do formulário
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para o Nome
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Digite seu nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value;
                },
              ),
              SizedBox(height: 16),
              // Campo para o Email
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Digite seu email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  // Você pode adicionar validação extra de email, se desejar
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 16),
              // Botão para enviar o formulário
              ElevatedButton(
                onPressed: () {
                  // Valida o formulário
                  if (_formKey.currentState!.validate()) {
                    // Salva os dados dos campos
                    _formKey.currentState!.save();
                    // Exibe uma mensagem com os dados
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nome: $_nome, Email: $_email'),
                      ),
                    );
                  }
                },
                child: Text('Enviar'),
              ),
              SizedBox(height: 16),
              // Botão para voltar à Tela1
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
