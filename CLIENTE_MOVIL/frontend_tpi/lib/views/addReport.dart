import 'package:flutter/material.dart';

import 'package:sipre/services/services.dart';

import 'package:sipre/views/home_business.dart';

import 'package:toast/toast.dart';

// ignore: must_be_immutable
class AddReport extends StatefulWidget {
  String cuit;
  // ignore: non_constant_identifier_names
  String razon_social;
  // ignore: non_constant_identifier_names
  int cant_reports;
  // ignore: non_constant_identifier_names
  AddReport({this.cuit, this.razon_social, this.cant_reports});
  @override
  _AddReportState createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  List<StepState> _listState;
  final Services s = new Services();
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

  TextEditingController controllerYear = new TextEditingController();
  TextEditingController controllerMonth = new TextEditingController();
  int _currentStep;

  Map<String, dynamic> producto = {
    "denominacion": "-", //dato string
    "codigo_ean": '-', //dato entero
    "precio_unidad": "-", //dato entero
    "unidad_medida": "-", //dato string
    "cantidad_prod": "-", //dato entero
    "cantidad_vend": "-" //dato entero
  };

  List<Map<String, dynamic>> listaRegistro = [];
  Map<String, String> periodo = {'year': '-', 'month': '-'};
  Map<String, dynamic> infoEmpresa = {'cuit': '-', 'razon_social': '-'};

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController denomination = new TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController code_ean = new TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController price_unity = new TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController unidad_medida = new TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController cantity_produced = new TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController cantity_solded = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String color = '37bbed';
  void loadInfo() {
    infoEmpresa['razon_social'] = widget.razon_social;
    infoEmpresa['cuit'] = widget.cuit;
  }

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
    _listState = [
      StepState.indexed,
      StepState.editing,
      StepState.complete,
    ];
    loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          backgroundColor: Color(int.parse("0xff$color")),
          centerTitle: true,
          title: Text('Agregar Reporte'),
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
                          title: Text(
                            'Periodo',
                          ),
                          content: Row(
                            children: <Widget>[
                              Text('Año: '),
                              Container(
                                  width: 50,
                                  child: TextField(
                                    controller: controllerYear,
                                    maxLength: 2,
                                  )),
                              SizedBox(width: 20),
                              Text('Mes (1-12): '),
                              Container(
                                  width: 50,
                                  child: TextField(
                                    maxLength: 2,
                                    keyboardType: TextInputType.number,
                                    controller: controllerMonth,
                                  )),
                            ],
                          ),
                        ),
                        Step(
                            state: _currentStep == 1
                                ? _listState[1]
                                : _currentStep > 1
                                    ? _listState[2]
                                    : _listState[0],
                            title: Text('Lista de Registro'),
                            content: listaRegistro.isEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          'Presione el icono para agregar a la lista'),
                                      SizedBox(width: 5),
                                      FloatingActionButton(
                                          backgroundColor: Color(
                                              int.parse("0xff$colorButton")),
                                          mini: true,
                                          onPressed: () {
                                            showWindow();
                                          },
                                          child: Icon(Icons.add))
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        DataTable(
                                            columns: [
                                              DataColumn(
                                                  label: Text('Denominacion')),
                                              DataColumn(
                                                  label: Text('Cod.EAN')),
                                            ],
                                            rows: listaRegistro
                                                .map((element) =>
                                                    DataRow(cells: [
                                                      DataCell(Text(element[
                                                          'denominacion'])),
                                                      DataCell(Row(
                                                        children: <Widget>[
                                                          Text(element[
                                                                  'codigo_ean']
                                                              .toString()),
                                                          SizedBox(width: 8),
                                                          IconButton(
                                                              icon: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red),
                                                              onPressed: () {
                                                                listaRegistro.removeWhere(
                                                                    (item) =>
                                                                        item[
                                                                            'denominacion'] ==
                                                                        element[
                                                                            'denominacion']);
                                                                setState(() {
                                                                  AddReport();
                                                                });
                                                                print(listaRegistro
                                                                    .length
                                                                    .toString());
                                                              }),
                                                        ],
                                                      )),
                                                    ]))
                                                .toList()),
                                        SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                'Presione el icono para agregar a la lista'),
                                            SizedBox(width: 5),
                                            FloatingActionButton(
                                                mini: true,
                                                onPressed: () {
                                                  showWindow();
                                                },
                                                child: Icon(Icons.add))
                                          ],
                                        )
                                      ]))
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
                          if (controllerMonth.text.isEmpty ||
                              controllerYear.text.isEmpty) {
                            showError('Algunos campos están vacíos');
                          } else {
                            if (int.parse(controllerMonth.text) > 12 ||
                                int.parse(controllerMonth.text) < 1) {
                              showError(
                                  'El mes debe ser un numero entre 1 y 12!');
                            } else {
                              if (listaRegistro.length == 0) {
                                showError(
                                    'Todavia no ha cargado elementos al reporte');
                              } else {
                                periodo['year'] = controllerYear.text;
                                periodo['month'] = controllerMonth.text;
                                infoEmpresa['cuit'] = widget.cuit;
                                infoEmpresa['razon_social'] =
                                    widget.razon_social;
                                s.addReport(
                                    infoEmpresa, periodo, listaRegistro);
                                widget.cant_reports++;

                                setState(() {
                                  //HomeBusiness();
                                  ShowReports();
                                });
                                Toast.show("Reporte agregado", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);
                              }
                            }
                          }
                        },
                        child: Center(
                            child: Text(
                          'AGREGAR REPORTE',
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

  showError(String message) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                  height: 200,
                  width: 250,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ha ocurrido un error!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0)),
                        SizedBox(height: 20),
                        Text(message),
                      ])),
            ));
  }

  showWindow() {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.65,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                      controller: denomination,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Denominacion',
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                      controller: code_ean,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Codigo EAN',
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                      controller: price_unity,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Precio x Unidad',
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                      controller: unidad_medida,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Unidad medida',
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Campo obligatorio';
                        }
                      },
                      controller: cantity_produced,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Cantidad producida',
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Campo obligatorio';
                        }
                      },
                      controller: cantity_solded,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Cantidad vendida',
                      )),
                ),
                SizedBox(height: 10),
                RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> map = new Map.from(producto);

                        map['denominacion'] = denomination.text;
                        map['codigo_ean'] = int.parse(code_ean.text);
                        map['precio_unidad'] = price_unity.text;
                        map['unidad_medida'] = unidad_medida.text;
                        map['cantidad_prod'] = int.parse(cantity_produced.text);
                        map['cantidad_vend'] = int.parse(cantity_solded.text);

                        listaRegistro.add(map);

                        setState(() {
                          AddReport();
                        });
                        Toast.show('Producto agregado', context);
                      } else {
                        Toast.show('Los datos son incorrectos', context);
                      }
                    },
                    child: Text('Agregar Producto')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
