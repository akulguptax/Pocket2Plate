import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipesapp/home_page.dart';
import 'package:recipesapp/login_page.dart';
import 'auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, // set it to false

        appBar: AppBar(
          title: Text("Pocket2Plate"),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(          // <= NEW
                key: _formKey,
                child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),    // <= NEW
                      Image.asset("assets/images/logo.png", height: 100, width: 100),
                      Text(
                        '\n Register Information',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20.0),   // <= NEW
                      TextFormField(
                          onSaved: (value) => _email = value,    // <= NEW
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: "Email Address")),
                      TextFormField(
                          onSaved: (value) => _password = value, // <= NEW
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Password")),

                      SizedBox(height: 20.0),
                      RaisedButton(child: Text("Create Account"), onPressed: () async {
                        final form = _formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          try {
                            FirebaseUser result =
                            await Provider.of<AuthService>(context).createUser(
                                email: _email, password: _password);
                            print(result);
                            Navigator.pop(context);
                          } on AuthException catch (error) {
                            return _buildErrorDialog(context, error.message);
                          } on Exception catch (error) {
                            return _buildErrorDialog(context, error.toString());
                          }

                        }

                      },
                      )]))));

  }
  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}