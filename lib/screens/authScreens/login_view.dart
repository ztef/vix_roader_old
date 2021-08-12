import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_roader/bloc/auth_bloc.dart';
import 'package:vix_roader/events/auth_events.dart';
import 'package:vix_roader/states/auth_states.dart';
import 'package:vix_roader/utils/validators.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var currentFocus;

  String userEmail = '';
  String userPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LOGIN'),
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.all(20),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoginFailed) {
                setState(() {
                  _isLoading = false;
                });
                _showSnackBar(context, state.error);
              }
            },
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Image.asset('assets/logo.png'),
                  _emailTextField(),
                  _passwordTextField(),
                  _submitButton(),
                  _registerLink(),
                ],
              ),
            ),
          ),
        )));
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(icon: Icon(Icons.email), hintText: 'Email'),
      validator: (v) {
        if (v!.isValidEmail) {
          return null;
        } else {
          return 'Please enter a valid email';
        }
      },
      onChanged: (value) {
        setState(() {
          userEmail = value;
        });
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          icon: Icon(Icons.password_rounded), hintText: 'Password'),
      validator: (v) {
        if (v!.isValidPassword) {
          return null;
        } else {
          return 'Password must contain an uppercase, lowercase, numeric digit and special character';
        }
      },
      onChanged: (value) {
        setState(() {
          userPassword = value;
        });
      },
    );
  }

  /*
  Widget _nameTextField() {
    return TextFormField(
      decoration: InputDecoration(icon: Icon(Icons.person), hintText: 'Name'),
      validator: (v) {
        if (v!.isValidName) {
          return null;
        } else {
          return 'Please enter a valid name';
        }
      },
    );
  }

  Widget _phoneTextField() {
    return TextFormField(
      decoration: InputDecoration(icon: Icon(Icons.phone), hintText: 'Phone'),
      validator: (v) {
        if (v!.isValidPhone) {
          return null;
        } else {
          return 'Phone Number must be up to 11 digits';
        }
      },
    );
  }

*/

  Widget _registerLink() {
    return TextButton(
      child: Text("¿ No te has registrado aún ?",
          style: TextStyle(fontWeight: FontWeight.w300)),
      onPressed: () {
        context.read<AuthBloc>().add(GoToRegister());
      },
    );
  }

  Widget _submitButton() {
    return Builder(builder: (context) {
      return _isLoading
          ? CircularProgressIndicator()
          : ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                unfocus();
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });

                  context.read<AuthBloc>().add(AttemptToLogin(
                      {'user': userEmail, 'password': userPassword}));
                }
              },
            );
    });
  }

  void unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
