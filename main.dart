import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Tarefas ACQA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A00F4),
          primary: const Color(0xFF6A00F4),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF3F3F3),
      ),
      home: const LoginScreen(),
    );
  }
}

// --- MODELOS ---
class Usuario {
  String nome;
  String ra;
  String email;
  String senha;
  Usuario(this.nome, this.ra, this.email, this.senha);
}

class Tarefa {
  String titulo;
  bool concluida;
  Tarefa(this.titulo, {this.concluida = false});
}

// Variáveis globais para simular o banco de dados (com usuário padrão)
Usuario? usuarioLogado = Usuario('Aluno Teste', '123456', 'admin', '123');
List<Tarefa> bancoDeTarefas = [];

// --- TELA DE LOGIN ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();

  void _entrar() {
    if (_formKey.currentState!.validate()) {
      if (usuarioLogado != null && usuarioLogado!.email == _email.text && usuarioLogado!.senha == _senha.text) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CalendarScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuário não encontrado ou senha incorreta.'), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A00F4),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Icon(Icons.task_alt, size: 60, color: Color(0xFF6A00F4)),
                    const SizedBox(height: 16),
                    const Text('Bem Vindo!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                      validator: (v) => v!.isEmpty ? 'Informe o email' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _senha,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Senha', border: OutlineInputBorder()),
                      validator: (v) => v!.isEmpty ? 'Informe a senha' : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6A00F4), foregroundColor: Colors.white),
                        onPressed: _entrar,
                        child: const Text('Entrar'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const CadastroScreen()));
                      },
                      child: const Text('Não é cadastrado? Cadastre-se', style: TextStyle(color: Color(0xFF6A00F4))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- TELA DE CADASTRO ---
class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _ra = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      usuarioLogado = Usuario(_nome.text, _ra.text, _email.text, _senha.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cadastro realizado com sucesso!'), backgroundColor: Colors.green));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A00F4),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text('Criar Conta', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    TextFormField(controller: _nome, decoration: const InputDecoration(labelText: 'Nome', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                    const SizedBox(height: 16),
                    TextFormField(controller: _ra, decoration: const InputDecoration(labelText: 'RA', border: OutlineInputBorder()), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                    const SizedBox(height: 16),
                    TextFormField(controller: _email, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                    const SizedBox(height: 16),
                    TextFormField(controller: _senha, obscureText: true, decoration: const InputDecoration(labelText: 'Senha', border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? 'Obrigatório' : null),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6A00F4), foregroundColor: Colors.white),
                        onPressed: _cadastrar,
                        child: const Text('Cadastrar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- TELA DE CALENDÁRIO ---
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _dataSelecionada = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A00F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bem Vindo,\n${usuarioLogado?.nome ?? 'Aluno'}!',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text('MEU RA: ${usuarioLogado?.ra ?? '000000'}', style: const TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: CalendarDatePicker(
                  initialDate: _dataSelecionada,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  onDateChanged: (date) {
                    setState(() => _dataSelecionada = date);
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF6A00F4)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => TaskListScreen(data: _dataSelecionada)));
                  },
                  child: const Text('Selecionar o dia', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- TELA DE LISTA DE TAREFAS ---
class TaskListScreen extends StatefulWidget {
  final DateTime data;
  const TaskListScreen({super.key, required this.data});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  void _ordenarTarefas() {
    bancoDeTarefas.sort((a, b) {
      if (a.concluida != b.concluida) {
        return a.concluida ? 1 : -1;
      }
      return a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase());
    });
  }

  void _adicionarTarefa(String titulo) {
    setState(() {
      bancoDeTarefas.add(Tarefa(titulo));
      _ordenarTarefas();
    });
  }

  void _mostrarDialogoAdicao() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Adicionar Tarefa'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Digite a tarefa...', border: OutlineInputBorder()),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6A00F4)),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                _adicionarTarefa(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Adiciona tarefa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A00F4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Dia ${DateFormat('dd/MM/yyyy').format(widget.data)}', style: const TextStyle(color: Colors.white)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text('Bem Vindo,\n${usuarioLogado?.nome ?? 'Aluno'}!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: bancoDeTarefas.isEmpty
                  ? const Center(child: Text('Nenhuma tarefa adicionada.', style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                itemCount: bancoDeTarefas.length,
                itemBuilder: (context, index) {
                  final tarefa = bancoDeTarefas[index];
                  return ListTile(
                    leading: Icon(
                      tarefa.concluida ? Icons.check_circle : Icons.access_time,
                      color: tarefa.concluida ? Colors.green : Colors.blue,
                    ),
                    title: Text(
                      tarefa.titulo,
                      style: TextStyle(
                        decoration: tarefa.concluida ? TextDecoration.lineThrough : null,
                        color: tarefa.concluida ? Colors.grey : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          bancoDeTarefas.removeAt(index);
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        tarefa.concluida = !tarefa.concluida;
                        _ordenarTarefas();
                      });
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF6A00F4),
              onPressed: _mostrarDialogoAdicao,
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}