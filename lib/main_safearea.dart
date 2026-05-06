import 'package:flutter/material.dart';

void main() {
  runApp(const SafeAreaExample());
}

class SafeAreaExample extends StatelessWidget {
  const SafeAreaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de SafeArea',
      home: Scaffold(
        appBar: AppBar(title: Text("Exemplo de SafeArea")),
        body: SafeArea(
          child: Column(
            children: const[
              Text(
                "aplicação flutter",
                style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
              Text(
                "conteudo protegido da barra de status"),
            ],
          ),
        ),
      ),
    );
  }
}