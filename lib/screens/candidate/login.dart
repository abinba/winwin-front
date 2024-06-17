import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:winwin/services/authentication_service.dart';
import 'package:winwin/services/restclient.dart';

class CandidateLoginPage extends StatefulWidget {
  @override
  _CandidateLoginPageState createState() => _CandidateLoginPageState();
}

class _CandidateLoginPageState extends State<CandidateLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final restClient = Provider.of<RestClient>(context, listen: false);
    final authService = AuthService(restClient);

    return Scaffold(
      appBar: AppBar(
        title: Text('Candidate Login'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_errorMessage != null)
              Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });

                      final success = await authService.login(
                        context,
                        _emailController.text,
                        _passwordController.text,
                      );

                      setState(() {
                        _isLoading = false;
                      });

                      if (success) {
                        context.go('/candidate/home');
                      } else {
                        setState(() {
                          _errorMessage = 'Failed to login';
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                    ),
                    child: Text('Login'),
                  ),
            TextButton(
              onPressed: () {
                context.go('/candidate/signup');
              },
              child: Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(color: Colors.lightGreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
