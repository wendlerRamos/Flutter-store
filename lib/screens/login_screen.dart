import 'package:flutter/material.dart';
import 'package:loja_app/models/user_model.dart';
import 'package:loja_app/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>SignUpScreen())
                );
              },
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 15.0),
              ),
              textColor: Colors.white,
            ),
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            if(model.isLoading) return Center(child: CircularProgressIndicator());
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail inválido";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                      hintText: "Senha",
                    ),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty || text.length < 6) return "Senha inválida";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: (){
                        if(_emailController.text.isEmpty){
                          _scafoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Digite seu email para recuperar a senha !"),
                                backgroundColor: Colors.red[800],
                                duration: Duration(seconds: 2),
                              )
                          );
                          Future.delayed(Duration(seconds: 2)).then((_){
                            Navigator.of(context).pop();
                          });
                        }else{
                          model.recoverPass(_emailController.text);
                          _scafoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Enviamos a recuperação para o seu email!"),
                                backgroundColor: Colors.red[800],
                                duration: Duration(seconds: 2),
                              )
                          );
                          Future.delayed(Duration(seconds: 2)).then((_){
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        model.signIn(
                          email: _emailController.text,
                          pass: _passController.text,
                          onFail: _onFail,
                          onSuccess: _onSuccess,

                        );
                      }
                    },
                  )
                ],
              ),
            );
          },
        )
    );
  }
  void _onSuccess(){
      Navigator.of(context).pop();
  }

  void _onFail(){
    _scafoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Ops, usuário ou senha incorretos!"),
          backgroundColor: Colors.red[800],
          duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }
}

