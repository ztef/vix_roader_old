import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vix_m/bloc/app_bloc.dart';
import 'package:vix_m/events/app_events.dart';
import 'package:vix_m/states/app_states.dart';
import 'package:vix_m/utils/validators.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var currentFocus;

  String userEmail = '';
  String userPassword = '';
  String userRepeatPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('REGISTRO'),
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.all(20),
          child: BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              if (state is RegisterFailed) {
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
                  _emailTextField(),
                  _passwordTextField(),
                  _passAgain(),
                  _submitButton(),
                  _loginLink(),
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

  Widget _passAgain() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          icon: Icon(Icons.password_rounded), hintText: 'Repite tu password'),
      validator: (v) {
        if (v!.isValidPassword && v == userPassword) {
          return null;
        } else {
          return 'Los passwords deben ser iguales';
        }
      },
      onChanged: (value) {
        setState(() {
          userRepeatPassword = value;
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

  Widget _loginLink() {
    return TextButton(
      child: Text("Ya estás registrado ? Ingresa Aquí.",
          style: TextStyle(fontWeight: FontWeight.w300)),
      onPressed: () {
        context.read<AppBloc>().add(GoToRegister());
      },
    );
  }

  Widget _submitButton() {
    return Builder(builder: (context) {
      return _isLoading
          ? CircularProgressIndicator()
          : ElevatedButton(
              child: Text('Registrar'),
              onPressed: () {
                unfocus();
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });

                  context.read<AppBloc>().add(AttemptToRegister(
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
