import 'package:flutter/material.dart';
import 'package:gerenteloja/widgets/input_field.dart';
import 'package:gerenteloja/model/login_model.dart';
import 'package:gerenteloja/ui/home_ui.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {

  final _loginBloc = LoginBloc();

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
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
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
                    stream: _loginBloc.outEmail,
                    onChanged: _loginBloc.changeEmail,
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
                    stream: _loginBloc.outPassword,
                    onChanged: _loginBloc.changePassword,
                  ),
                  SizedBox(height: 32,),
                  StreamBuilder<bool>(
                      stream: _loginBloc.outSubmitValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: raisedButtonStyle,
                            child: Text("Entrar"),
                            onPressed: snapshot.hasData ? _loginBloc.submit : null,
                          ),
                        );
                      }
                  )
                ],
              ),
            )
        ),
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
}
