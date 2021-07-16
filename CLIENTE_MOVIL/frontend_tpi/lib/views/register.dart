import 'package:flutter/material.dart';
import 'package:sipre/services/services.dart';
import 'package:toast/toast.dart';

void main() => runApp(Register());

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<StepState> _listState;
  final Services s = new Services();
  bool isHide = true;
  String colorButton = '1bbb1f';
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 1 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  int _currentStep;
  TextEditingController cuit = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController city = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController social_reason = new TextEditingController();
  TextEditingController industry = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
    _listState = [
      StepState.indexed,
      StepState.editing,
      StepState.complete,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue[300],
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          backgroundColor: Colors.blue[300],
          centerTitle: true,
          title: Text('Nueva Empresa'),
        ),
        body: SafeArea(
          child: Center(
            child: Form(
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Stepper(
                      steps: <Step>[
                        Step(
                            state: _currentStep == 0
                                ? _listState[1]
                                : _currentStep > 0
                                    ? _listState[2]
                                    : _listState[3],
                            title: Text('Datos de Empresa',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0)),
                            content: Column(
                              children: <Widget>[
                                TextFormField(
                                  cursorColor: Colors.white,
                                  controller: cuit,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'CUIT',
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      )),
                                ),
                                TextFormField(
                                  cursorColor: Colors.white,
                                  controller: social_reason,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Razon Social',
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      )),
                                ),
                                TextFormField(
                                  cursorColor: Colors.white,
                                  controller: industry,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Industria',
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      )),
                                ),
                              ],
                            )),
                        Step(
                            state: _currentStep == 1
                                ? _listState[1]
                                : _currentStep > 1
                                    ? _listState[2]
                                    : _listState[0],
                            title: Text('Datos personales',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0)),
                            content: Column(
                              children: <Widget>[
                                TextFormField(
                                  cursorColor: Colors.white,
                                  controller: email,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      )),
                                ),
                                TextFormField(
                                  controller: password,
                                  obscureText: isHide ? true : false,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      suffixIcon: isHide
                                          ? IconButton(
                                              icon: Icon(Icons.lock_outline,
                                                  color: Colors.white),
                                              onPressed: () => isHide = !isHide)
                                          : IconButton(
                                              icon: Icon(Icons.lock_open,
                                                  color: Colors.white),
                                              onPressed: () =>
                                                  isHide = !isHide),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      )),
                                ),
                                TextFormField(
                                  cursorColor: Colors.white,
                                  controller: city,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Ciudad',
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      )),
                                ),
                                TextFormField(
                                  cursorColor: Colors.white,
                                  controller: phone,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      labelText: 'Telefono',
                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      )),
                                ),
                              ],
                            )),
                      ],
                      currentStep: this._currentStep,
                      onStepTapped: (step) => tapped(step),
                      onStepContinue: () => continued(),
                      onStepCancel: cancel,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                      color: Color(int.parse("0xff$colorButton")),
                      child: GestureDetector(
                        onTap: () async {
                          s.signUp(cuit.text, social_reason.text, industry.text,
                              email.text, password.text, phone.text, city.text);
                          Toast.show("Empresa registrada", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        },
                        child: Center(
                            child: Text(
                          'Registrar Empresa',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.06),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
