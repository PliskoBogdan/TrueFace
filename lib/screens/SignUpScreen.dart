import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Auth.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/sign_up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  void toggleObscure() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock),
                              Text(
                                'Login info',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Divider(),
                          TextFormField(
                            controller: _email,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                          TextFormField(
                            controller: _password,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: IconButton(
                                  icon: _obscurePassword
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: toggleObscure,
                                ),
                              ),
                            ),
                            obscureText: _obscurePassword,
                          ),
                          TextFormField(
                            controller: _confirmPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter confirm password';
                              } else if (value != _password.text) {
                                return 'Paswords not match';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: IconButton(
                                  icon: _obscurePassword
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: toggleObscure,
                                ),
                              ),
                            ),
                            obscureText: _obscurePassword,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RaisedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    try {
                                      await Provider.of<Auth>(context,
                                              listen: false)
                                          .signup(_email.text, _password.text);
                                      Navigator.of(context)
                                          .pushReplacementNamed('/');
                                    } catch (e) {
                                      _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text(e),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text('Register'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
