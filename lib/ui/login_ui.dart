import 'package:flutter/material.dart';
import 'package:gerenteloja/widgets/input_field.dart';
import 'package:gerenteloja/model/login_model.dart';
import 'package:gerenteloja/ui/home_ui.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state){
      switch(state){
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=>HomeUi())
          );
          break;
        case LoginState.FAIL:
          showDialog(context: context, builder: (context)=>AlertDialog(
            title: Text("Erro"),
            content: Text("Você não possui os privilégios necessários"),
          ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      body: ScopedModelDescendant<LoginModel>(
        builder: (context, child, model) {
        return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      Icons.store_mall_directory,
                      color: Colors.pinkAccent,
                      size: 160,
                    ),
                    SizedBox(height: 12,),
                    InputField(
                      icon: Icons.person_outline,
                      colorIcon: Colors.lightBlue,
                      hint: "Usuário",
                      hintColor: Colors.grey.shade400,
                      styleColor: Colors.blueGrey,
                      borderSideColor: Colors.pinkAccent,
                      obscure: false,
                      controller: _emailController,
                    ),
                    SizedBox(height: 10,),
                    InputField(
                      icon: Icons.lock_outline,
                      colorIcon: Colors.lightBlue,
                      hint: "Senha",
                      hintColor: Colors.grey.shade400,
                      styleColor: Colors.blueGrey,
                      borderSideColor: Colors.pinkAccent,
                      obscure: true,
                      controller: _passController,
                    ),
                    SizedBox(height: 32,),
                    SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          child: Text("Entrar"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {}
                              model.signIn(
                                email: _emailController.text,
                                pass: _passController.text,
                                onSuccess: () => _onSuccess(),
                                onFail: () => _onFail(),
                              );
                            }),
                        ),
                    );
                  ],
                ),
              )
          );
        }),
      );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.pink.shade400,
    textStyle: TextStyle(color: Colors.white),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao criar entrar!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}
