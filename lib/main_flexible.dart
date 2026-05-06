import 'package:flutter/material.dart';

void main() {
  runApp(ScrollApp());
}

class ScrollApp extends StatelessWidget {
  const ScrollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Flexible',
      home: Scaffold(
        appBar: AppBar(title: Text("Exemplo de Flexible")),
        body: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 120,
                color: Colors.red,
                child: const Center(child: Text("1 parte")),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                height: 120,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    "2 partes",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}