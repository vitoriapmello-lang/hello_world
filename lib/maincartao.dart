import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Carteira Digital"),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            CartaoComBandeira(
              cor: const Color.fromARGB(255, 214, 121, 222),
              banco: "Santander",
              numero: "1234 5678 9012 3456",
              nome: "Vitoria Pierre Mello",
              validade: "12/30",
              bandeira: "assets/images/visalogo.webp",
              logo: "assets/images/sant.png",
            ),

            const SizedBox(height: 20),

            CartaoComIcones(
              cor: const Color.fromARGB(255, 151, 81, 165),
              banco: "Nubank",
              numero: "9999 8888 7777 6666",
              nome: "Luciana Marques",
              validade: "01/29",
              icone1: Icons.credit_card,
              icone2: Icons.contactless,
              logo: "assets/images/Nubank.png",
            ),

            const SizedBox(height: 20),

            CartaoComIcones(
              cor: const Color.fromARGB(255, 101, 78, 147),
              banco: "Caixa",
              numero: "1111 2222 3333 4444",
              nome: "Rafael Leme Mega",
              validade: "05/28",
              icone1: Icons.account_balance,
              icone2: Icons.savings,
              logo: "assets/images/caixalogo.png",
            ),
          ],
        ),
      ),
    );
  }
}

class CartaoComBandeira extends StatelessWidget {
  final Color cor;
  final String banco;
  final String numero;
  final String nome;
  final String validade;
  final String bandeira;
  final String logo;

  const CartaoComBandeira({
    super.key,
    required this.cor,
    required this.banco,
    required this.numero,
    required this.nome,
    required this.validade,
    required this.bandeira,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [cor, cor.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOPO: logo + nome + bandeira
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(logo, width: 30, height: 30),
                  const SizedBox(width: 8),
                  Text(
                    banco,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Image.asset(bandeira, width: 60, height: 30),
            ],
          ),

          const Icon(Icons.sim_card, color: Colors.amber, size: 40),

          Text(
            numero,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nome,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                validade,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartaoComIcones extends StatelessWidget {
  final Color cor;
  final String banco;
  final String numero;
  final String nome;
  final String validade;
  final IconData icone1;
  final IconData icone2;
  final String? logo;

  const CartaoComIcones({
    super.key,
    required this.cor,
    required this.banco,
    required this.numero,
    required this.nome,
    required this.validade,
    required this.icone1,
    required this.icone2,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [cor, cor.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (logo != null) Image.asset(logo!, width: 30, height: 30),
                  const SizedBox(width: 8),
                  Text(
                    banco,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(icone1, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Icon(icone2, color: Colors.white, size: 20),
                ],
              ),
            ],
          ),

          const Icon(Icons.sim_card, color: Colors.amber, size: 40),

          Text(
            numero,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nome,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                validade,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
