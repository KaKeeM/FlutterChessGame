import 'package:flutter/material.dart';
import '../helper/database_helper.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  bool _isLoginMode = true; // Alterna entre Login e Registro
  bool _isLoading = false;

  get isDarkMode => false;

  Future<void> _handleLoginOrRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (_isLoginMode) {
      // Login
      bool isValid = await _dbHelper.validateUser(email, password);
      if (isValid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(isDarkMode: isDarkMode),
          ),
        );
      } else {
        _showMessage('Erro no Login', 'Email ou senha incorretos.');
      }
    } else {
      // Registro
      bool isSuccess = await _dbHelper.registerUser(username, email, password);
      if (isSuccess) {
        _showMessage('Sucesso', 'Conta criada com sucesso! Faça login.');
        setState(() {
          _isLoginMode = true; // Alterna para modo Login
        });
      } else {
        _showMessage('Erro no Registro', 'Email ou nome de usuário já existem.');
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Login' : 'Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (!_isLoginMode)
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Nome de Usuário'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Digite um nome de usuário' : null,
                ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite um email válido' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) =>
                    value == null || value.length < 6 ? 'Senha deve ter pelo menos 6 caracteres' : null,
              ),
              SizedBox(height: 20),
              if (_isLoading)
                Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _handleLoginOrRegister,
                  child: Text(_isLoginMode ? 'Entrar' : 'Registrar'),
                ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoginMode = !_isLoginMode;
                  });
                },
                child: Text(_isLoginMode
                    ? 'Não tem uma conta? Registre-se'
                    : 'Já tem uma conta? Faça login'),
              ),
              SizedBox(height: 20),
              // Botão para voltar para a tela Home diretamente
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(isDarkMode: isDarkMode),
                    ),
                  );
                },
                child: Text('Voltar para Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
