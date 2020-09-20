import 'package:provider/provider.dart';
import '../providers/Auth.dart';

import 'package:flutter/material.dart';
import './SignUpScreen.dart';
import './TabsScreen.dart';
import '../models/http_exception.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';

  @override
  _emailScreenState createState() => _emailScreenState();
}

class _emailScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
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
        title: Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Form(
                    autovalidate: true,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter login';
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
                            } else if (value.length <= 5) {
                              return 'Password too short';
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(SignUpScreen.routeName);
                              },
                              child: Text('Register'),
                            ),
                            RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    await Provider.of<Auth>(context,
                                            listen: false)
                                        .login(_email.text, _password.text);
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
                              child: Text('Submit'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
