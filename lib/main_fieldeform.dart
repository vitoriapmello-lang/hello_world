import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaComparacao(),
    );
  }
}

class TelaComparacao extends StatefulWidget {
  @override
  _TelaComparacaoState createState() => _TelaComparacaoState();
}

class _TelaComparacaoState extends State<TelaComparacao> {
  
  final controllerSimples = TextEditingController();
  final controllerForm = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comparação de TextField e Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("TextField Simples:"),
            TextField(
              controller: controllerSimples,
              decoration: InputDecoration(labelText: "Digite algo",
              border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: () {
                print("Valor do TextField Simples: ${controllerSimples.text}");
              },
              child: Text("Enviar TextField Simples"),
            ),

            SizedBox(height: 30),

            Text("Form com Validação:"),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerForm,
                    decoration: InputDecoration(labelText: "Digite algo",
                    border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("Valor do Form: ${controllerForm.text}");
                      }
                    },
                    child: Text("Enviar Form"),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  } 
} 
