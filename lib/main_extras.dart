import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ContadorCurtidas());
  }
}

class ContadorCurtidas extends StatefulWidget {
  const ContadorCurtidas({super.key});

  @override
  _ContadorCurtidasState createState() => _ContadorCurtidasState();
}

class _ContadorCurtidasState extends State<ContadorCurtidas> {
  int curtidas = 0;

  void curtir() {
    setState(() {
      curtidas++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Curtidas")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, size: 80, color: Colors.red),

            SizedBox(height: 20),

            Text(
              "$curtidas curtidas",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: curtir, child: Text("Curtir")),

                SizedBox(width: 15),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (curtidas > 0) {
                        curtidas--;
                      }
                    });
                  },
                  child: Text("Descurtir👍"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
