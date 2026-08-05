import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle Financeiro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C2BD9), // roxo
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F3FA),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
        ),
      ),
      home: const HomePage(),
    );
  }
}

enum TipoTransacao { entrada, saida }

class Categoria {
  final String nome;
  final IconData icone;
  final Color cor;
  const Categoria(this.nome, this.icone, this.cor);
}

const List<Categoria> categoriasEntrada = [
  Categoria('Salário', Icons.work_rounded, Color(0xFF6C2BD9)),
  Categoria('Freelance', Icons.laptop_mac_rounded, Color(0xFF9C6ADE)),
  Categoria('Outros', Icons.attach_money_rounded, Color(0xFFB794F4)),
];

const List<Categoria> categoriasSaida = [
  Categoria('Alimentação', Icons.restaurant_rounded, Color(0xFFE53E3E)),
  Categoria(
    'Transporte',
    Icons.directions_car_filled_rounded,
    Color(0xFFDD6B20),
  ),
  Categoria('Lazer', Icons.sports_esports_rounded, Color(0xFFD69E2E)),
  Categoria('Estudos', Icons.school_rounded, Color(0xFF3182CE)),
  Categoria('Casa', Icons.home_rounded, Color(0xFF38A169)),
  Categoria('Outros', Icons.category_rounded, Color(0xFF718096)),
];

class Transacao {
  final String id;
  final String titulo;
  final double valor;
  final TipoTransacao tipo;
  final Categoria categoria;
  final DateTime data;

  Transacao({
    required this.id,
    required this.titulo,
    required this.valor,
    required this.tipo,
    required this.categoria,
    required this.data,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transacao> _transacoes = [
    Transacao(
      id: '1',
      titulo: 'Salário de Julho',
      valor: 1800,
      tipo: TipoTransacao.entrada,
      categoria: categoriasEntrada[0],
      data: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transacao(
      id: '2',
      titulo: 'Supermercado',
      valor: 245.90,
      tipo: TipoTransacao.saida,
      categoria: categoriasSaida[0],
      data: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transacao(
      id: '3',
      titulo: 'Uber',
      valor: 32.50,
      tipo: TipoTransacao.saida,
      categoria: categoriasSaida[1],
      data: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transacao(
      id: '4',
      titulo: 'Curso Senac',
      valor: 120,
      tipo: TipoTransacao.saida,
      categoria: categoriasSaida[3],
      data: DateTime.now(),
    ),
  ];

  double get _totalEntradas => _transacoes
      .where((t) => t.tipo == TipoTransacao.entrada)
      .fold(0, (soma, t) => soma + t.valor);

  double get _totalSaidas => _transacoes
      .where((t) => t.tipo == TipoTransacao.saida)
      .fold(0, (soma, t) => soma + t.valor);

  double get _saldo => _totalEntradas - _totalSaidas;

  final _formatoMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  void _abrirFormulario({TipoTransacao? tipoInicial}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => NovaTransacaoSheet(
        tipoInicial: tipoInicial ?? TipoTransacao.saida,
        onSalvar: (novaTransacao) {
          setState(() => _transacoes.insert(0, novaTransacao));
        },
      ),
    );
  }

  void _removerTransacao(String id) {
    setState(() => _transacoes.removeWhere((t) => t.id == id));
  }

  @override
  Widget build(BuildContext context) {
    final transacoesOrdenadas = [..._transacoes]
      ..sort((a, b) => b.data.compareTo(a.data));

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá! 👋',
                          style: TextStyle(fontSize: 15, color: Colors.black54),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Seu resumo financeiro',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: const Color(
                        0xFF6C2BD9,
                      ).withOpacity(0.15),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Color(0xFF6C2BD9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: _buildSaldoCard()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Transações',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_transacoes.length} itens',
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),
            if (transacoesOrdenadas.isEmpty)
              const SliverToBoxAdapter(child: _EstadoVazio())
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final t = transacoesOrdenadas[index];
                  return _TransacaoTile(
                    transacao: t,
                    formatoMoeda: _formatoMoeda,
                    onRemover: () => _removerTransacao(t.id),
                  );
                }, childCount: transacoesOrdenadas.length),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _abrirFormulario(),
        backgroundColor: const Color(0xFF6C2BD9),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Nova transação'),
      ),
    );
  }

  Widget _buildSaldoCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6C2BD9), Color(0xFF9C4DEB)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C2BD9).withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saldo atual',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Text(
              _formatoMoeda.format(_saldo),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _MiniResumo(
                    icone: Icons.arrow_downward_rounded,
                    corIcone: Colors.greenAccent.shade100,
                    label: 'Entradas',
                    valor: _formatoMoeda.format(_totalEntradas),
                  ),
                ),
                Container(width: 1, height: 34, color: Colors.white24),
                Expanded(
                  child: _MiniResumo(
                    icone: Icons.arrow_upward_rounded,
                    corIcone: Colors.redAccent.shade100,
                    label: 'Saídas',
                    valor: _formatoMoeda.format(_totalSaidas),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniResumo extends StatelessWidget {
  final IconData icone;
  final Color corIcone;
  final String label;
  final String valor;

  const _MiniResumo({
    required this.icone,
    required this.corIcone,
    required this.label,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icone, size: 16, color: corIcone),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                valor,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TransacaoTile extends StatelessWidget {
  final Transacao transacao;
  final NumberFormat formatoMoeda;
  final VoidCallback onRemover;

  const _TransacaoTile({
    required this.transacao,
    required this.formatoMoeda,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    final isEntrada = transacao.tipo == TipoTransacao.entrada;
    return Dismissible(
      key: ValueKey(transacao.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete_rounded, color: Colors.white),
      ),
      onDismissed: (_) => onRemover(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: transacao.categoria.cor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                transacao.categoria.icone,
                color: transacao.categoria.cor,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transacao.titulo,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${transacao.categoria.nome} • ${DateFormat('dd/MM').format(transacao.data)}',
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${isEntrada ? '+' : '-'} ${formatoMoeda.format(transacao.valor)}',
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
                color: isEntrada
                    ? const Color(0xFF2F855A)
                    : const Color(0xFFC53030),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EstadoVazio extends StatelessWidget {
  const _EstadoVazio();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 56,
            color: Colors.black.withOpacity(0.15),
          ),
          const SizedBox(height: 12),
          const Text(
            'Nenhuma transação ainda',
            style: TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

class NovaTransacaoSheet extends StatefulWidget {
  final TipoTransacao tipoInicial;
  final void Function(Transacao) onSalvar;

  const NovaTransacaoSheet({
    super.key,
    required this.tipoInicial,
    required this.onSalvar,
  });

  @override
  State<NovaTransacaoSheet> createState() => _NovaTransacaoSheetState();
}

class _NovaTransacaoSheetState extends State<NovaTransacaoSheet> {
  late TipoTransacao _tipo;
  final _tituloController = TextEditingController();
  final _valorController = TextEditingController();
  late Categoria _categoriaSelecionada;

  @override
  void initState() {
    super.initState();
    _tipo = widget.tipoInicial;
    _categoriaSelecionada = _tipo == TipoTransacao.entrada
        ? categoriasEntrada[0]
        : categoriasSaida[0];
  }

  List<Categoria> get _categoriasDisponiveis =>
      _tipo == TipoTransacao.entrada ? categoriasEntrada : categoriasSaida;

  void _salvar() {
    final titulo = _tituloController.text.trim();
    final valor = double.tryParse(_valorController.text.replaceAll(',', '.'));

    if (titulo.isEmpty || valor == null || valor <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha um título e um valor válido.')),
      );
      return;
    }

    widget.onSalvar(
      Transacao(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        titulo: titulo,
        valor: valor,
        tipo: _tipo,
        categoria: _categoriaSelecionada,
        data: DateTime.now(),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Nova transação',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),

            // Seletor de tipo
            Row(
              children: [
                Expanded(
                  child: _BotaoTipo(
                    label: 'Entrada',
                    icone: Icons.arrow_downward_rounded,
                    selecionado: _tipo == TipoTransacao.entrada,
                    cor: const Color(0xFF2F855A),
                    onTap: () => setState(() {
                      _tipo = TipoTransacao.entrada;
                      _categoriaSelecionada = categoriasEntrada[0];
                    }),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _BotaoTipo(
                    label: 'Saída',
                    icone: Icons.arrow_upward_rounded,
                    selecionado: _tipo == TipoTransacao.saida,
                    cor: const Color(0xFFC53030),
                    onTap: () => setState(() {
                      _tipo = TipoTransacao.saida;
                      _categoriaSelecionada = categoriasSaida[0];
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
                hintText: 'Ex: Mercado, Salário...',
                filled: true,
                fillColor: const Color(0xFFF5F3FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _valorController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Valor',
                prefixText: 'R\$ ',
                filled: true,
                fillColor: const Color(0xFFF5F3FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 18),

            const Text(
              'Categoria',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _categoriasDisponiveis.map((cat) {
                final selecionada = cat.nome == _categoriaSelecionada.nome;
                return GestureDetector(
                  onTap: () => setState(() => _categoriaSelecionada = cat),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: selecionada
                          ? cat.cor.withOpacity(0.15)
                          : const Color(0xFFF5F3FA),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: selecionada ? cat.cor : Colors.transparent,
                        width: 1.4,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(cat.icone, size: 16, color: cat.cor),
                        const SizedBox(width: 6),
                        Text(
                          cat.nome,
                          style: TextStyle(
                            fontSize: 13,
                            color: selecionada ? cat.cor : Colors.black87,
                            fontWeight: selecionada
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 26),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C2BD9),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Salvar', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BotaoTipo extends StatelessWidget {
  final String label;
  final IconData icone;
  final bool selecionado;
  final Color cor;
  final VoidCallback onTap;

  const _BotaoTipo({
    required this.label,
    required this.icone,
    required this.selecionado,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selecionado ? cor.withOpacity(0.12) : const Color(0xFFF5F3FA),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selecionado ? cor : Colors.transparent,
            width: 1.4,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 18, color: selecionado ? cor : Colors.black45),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selecionado ? cor : Colors.black54,
                fontWeight: selecionado ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
