import 'package:flutter/material.dart';
import 'package:loginsql/data/database_helper.dart';
import 'package:loginsql/models/user.dart';
import 'package:loginsql/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext? _ctx;
  bool? _isLoading;
  final formKey = new GlobalKey<FormState>();
  final ScaffoldKey = new GlobalKey<ScaffoldState>();
  String? _username, _password;
  LoginPagePresenter? _presenter;
  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }
  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter!.doLogin(_username!, _password!);
      });
    }
  }

  void _showSnackBar(String text) {
    ScaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Login"),
      color: Colors.green,
    );
    var loginForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Sqlflite app login",
          textScaleFactor: 2.0,
        ),
        Center(
          child: new Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(10),
                  child: new TextFormField(
                    onSaved: (val) => _username = val!,
                    decoration: new InputDecoration(labelText: "Username"),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10),
                  child: new TextFormField(
                    onSaved: (val) => _password = val!,
                    decoration: new InputDecoration(labelText: "Password"),
                  ),
                ),
              ],
            ),
          ),
        ),
        loginBtn
      ],
    );
    return new Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      key: ScaffoldKey,
      body: Container(
        child: Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    _showSnackBar(user.toString());
    setState(() {
      _isLoading = false;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/home");
  }
}
