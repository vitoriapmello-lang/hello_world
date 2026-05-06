import 'package:flutter/material.dart';

void main() {
  runApp(ScrollApp());
}

class ScrollApp extends StatelessWidget {
  const ScrollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Expended',
      home: Scaffold(
        appBar: AppBar(title: Text("Exemplo de Expended")),
        body: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.red,
              child: const Center(child: Text("header")),
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    "ocupa o espaço restante",
                    style: TextStyle(color: Colors.white),
                    ),
                ),
              ),
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.green,
              child: const Center(child: Text("footer")),
            ),
          ],
        ),
      ),
    );
  }
}