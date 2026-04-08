import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Imagem SENAI")),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("bem vindo ", style: TextStyle(fontSize: 24)),
              const SizedBox(width: 20),
              Image.asset('assets/images/senaisp.png'),
            ],
          ),
        ),
      ),
    );
  }
}