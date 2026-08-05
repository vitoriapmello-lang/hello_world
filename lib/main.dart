import 'package:flutter/material.dart';

void main() {
  runApp(FinanceApp());
}

class FinanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Controle Financeiro",
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Arial"),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = [
    Dashboard(),
    Transactions(),
    AddMoney(),
    Categories(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,

        selectedItemColor: Colors.blue,

        unselectedItemColor: Colors.grey,

        onTap: (value) {
          setState(() {
            index = value;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),

          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Transações"),

          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "Adicionar",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categorias",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}

// TELA PRINCIPAL

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(title: Text("Meu Financeiro"), centerTitle: true),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Resumo do mês",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                CardFinance(
                  titulo: "Saldo",
                  valor: "R\$ 5.200,00",
                  cor: Colors.blue,
                ),

                CardFinance(
                  titulo: "Gastos",
                  valor: "R\$ 1.850,00",
                  cor: Colors.red,
                ),
              ],
            ),

            SizedBox(height: 30),

            Text(
              "Últimas movimentações",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            TransactionTile(
              nome: "Mercado",
              valor: "- R\$ 120,00",
              icone: Icons.shopping_cart,
            ),

            TransactionTile(
              nome: "Salário",
              valor: "+ R\$ 3000,00",
              icone: Icons.attach_money,
            ),

            TransactionTile(
              nome: "Internet",
              valor: "- R\$ 100,00",
              icone: Icons.wifi,
            ),
          ],
        ),
      ),
    );
  }
}

class CardFinance extends StatelessWidget {
  final String titulo;
  final String valor;
  final Color cor;

  CardFinance({required this.titulo, required this.valor, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),

        padding: EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: cor,

          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          children: [
            Text(titulo, style: TextStyle(color: Colors.white)),

            SizedBox(height: 10),

            Text(
              valor,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String nome;
  final String valor;
  final IconData icone;

  TransactionTile({
    required this.nome,
    required this.valor,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icone)),

        title: Text(nome),

        trailing: Text(valor, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// OUTRAS TELAS

class Transactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transações")),

      body: Center(child: Text("Lista de todas as transações")),
    );
  }
}

class AddMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adicionar")),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Descrição")),

            TextField(decoration: InputDecoration(labelText: "Valor")),

            SizedBox(height: 20),

            ElevatedButton(onPressed: () {}, child: Text("Salvar")),
          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categorias")),

      body: ListView(
        children: [
          ListTile(leading: Icon(Icons.home), title: Text("Casa")),

          ListTile(leading: Icon(Icons.food_bank), title: Text("Alimentação")),

          ListTile(leading: Icon(Icons.gamepad), title: Text("Lazer")),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

            SizedBox(height: 20),

            Text(
              "Usuário",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
