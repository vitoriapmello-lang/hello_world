import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Distância até em casa',
      home: const DistanciaCasaPage(),
    );
  }
}

class DistanciaCasaPage extends StatefulWidget {
  const DistanciaCasaPage({super.key});

  @override
  State<DistanciaCasaPage> createState() => _DistanciaCasaPageState();
}

class _DistanciaCasaPageState extends State<DistanciaCasaPage> {
  final double latitudeCasa = -21.44955173462684;
  final double longitudeCasa = -47.00878539535877;
  
  String resultadoDistancia = 'Clique no botão para calcular a distância.';

  Future<void> calcularDistancia() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if (!servicoAtivo) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }

    if (permissao == LocationPermission.denied ||
        permissao == LocationPermission.deniedForever) {
      setState(() {
        resultadoDistancia = "Permissão de localização negada.";
      });
      return;
    }

    Position posicaoAtual = await Geolocator.getCurrentPosition();

    double distanciaEmMetros = Geolocator.distanceBetween(
      posicaoAtual.latitude,
      posicaoAtual.longitude,
      latitudeCasa,
      longitudeCasa,
    );

    setState(() {
      if (distanciaEmMetros > 1000) {
        resultadoDistancia =
            'A distância é de ${(distanciaEmMetros / 1000).toStringAsFixed(2)} km';
      } else {
        resultadoDistancia =
            'A distância é de ${distanciaEmMetros.toStringAsFixed(0)} metros';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distância até minha casa'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.home,
                size: 80,
                color: Color.fromARGB(255, 236, 34, 158),
              ),
              const SizedBox(height: 20),
              const Text(
                'Distância entre a escola e minha casa',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                resultadoDistancia,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: calcularDistancia,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 222, 95, 156),
                  foregroundColor: const Color.fromARGB(255, 161, 13, 77),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Calcular distância'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}