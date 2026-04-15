import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Cartão de Perfil', home: const ProfileCard());
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil do Usuário'), centerTitle: true),
      body: Center(
        child: Container(
          width: 300,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Color(0xFF412962), Color(0xFFAE82B8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 50,
                backgroundImage: Image.asset('assets/images/roxinha.png').image,
              ),
              SizedBox(height: 10),
              Text(
                'Vitória Pierre Mello',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Desenvolvedora Flutter',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'vitoriapierre@gmail.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),

              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    '(xx) xxxxx-xxxx',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),

              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Mococa, SP',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),

              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5),
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5),
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5),
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5),
                  Icon(Icons.star_half, color: Colors.amber),
                  SizedBox(width: 8),
                  Text(
                    '4.5',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Editar Perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
