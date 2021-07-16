import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:sipre/models/userBusiness.dart';
import 'package:sipre/services/services.dart';

import 'package:sipre/views/updateProfile.dart';

import 'package:sipre/views/addReport.dart';
import 'package:toast/toast.dart';

void main() => runApp(HomeBusiness());
bool isEmpty = false;
int lengthReports = 0;

// ignore: must_be_immutable
class HomeBusiness extends StatefulWidget {
  List reports = [];
  UserBusiness userBusiness;

  HomeBusiness({this.reports, this.userBusiness});
  @override
  _HomeBusinessState createState() => _HomeBusinessState();
}

class _HomeBusinessState extends State<HomeBusiness> {
  final Services s = new Services();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    s.getAllReports();

    ShowReports();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          centerTitle: true,
          title: Text('Aportes realizados'),
        ),
        body: SafeArea(
          child: ShowReports(
              reports_business: widget.reports, scaffoldKey: _scaffoldKey),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddReport(
                            cant_reports: lengthReports,
                            cuit: widget.userBusiness.cuit.toString(),
                            razon_social: widget.userBusiness.razon_social,
                          )));
            },
            child: Icon(Icons.add)),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text(widget.userBusiness.razon_social),
                accountEmail:
                    Text('CUIT/CUIL:' + widget.userBusiness.cuit.toString())),
            ListTile(
              title: Text('Editar Perfil'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProfile(
                              userBusiness: widget.userBusiness,
                            )));
              },
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
                title: Text('Cerrar Sesion'),
                leading: Icon(Icons.arrow_back),
                onTap: () => Navigator.pop(context)),
          ],
        )),
      ),
    );
  }
}

// ignore: must_be_immutable
class ShowReports extends StatefulWidget {
  // ignore: non_constant_identifier_names
  List reports_business = [];

  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  // ignore: non_constant_identifier_names
  ShowReports({this.reports_business, this.scaffoldKey});
  @override
  _ShowReportsState createState() => _ShowReportsState();
}

class _ShowReportsState extends State<ShowReports> {
  Services serv = new Services();

  @override
  void initState() {
    super.initState();

    //print(widget.reports_business.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: serv.getAllReports(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<dynamic> reports = snapshot.data[0]['report'];
              if (reports.isEmpty) {
                return Center(
                    child: Text(
                  'Sin reportes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ));
              }
              return ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    String mes = reports[index]['periodo']['month'];

                    String cantVendida =
                        getCantVendida(reports[index]['listaRegistro']);
                    String cantProducida =
                        getCantProducida(reports[index]['listaRegistro']);

                    String fecha = reports[index]['date_upload'].toString();
                    fecha = fecha.substring(0, 10);
                    String _id = reports[index]['_id'].toString();

                    return Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        height: MediaQuery.of(context).size.height * 0.23,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Card(
                          color: Colors.blue[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                      'Periodo: ' +
                                          serv.getMonth(mes) +
                                          ' ' +
                                          reports[index]['periodo']['year'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(width: 25),
                                  PopupMenuButton(
                                      initialValue: 2,
                                      itemBuilder: (context) {
                                        return List.generate(2, (index) {
                                          return PopupMenuItem(
                                            enabled: true,
                                            child: (index == 0)
                                                ? GestureDetector(
                                                    onTap: () {
                                                      String _id =
                                                          reports[0]['_id'];

                                                      List<dynamic> res =
                                                          reports[0]
                                                              ['listaRegistro'];
                                                      updateReport(res, _id);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.edit,
                                                            color: Colors.grey),
                                                        SizedBox(width: 5),
                                                        Text('Editar Reporte'),
                                                      ],
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () async {
                                                      serv.deleteReport(_id);

                                                      setState(() {
                                                        lengthReports--;
                                                        //HomeBusiness();
                                                        ShowReports();
                                                      });
                                                      Toast.show(
                                                          'Reporte eliminado',
                                                          context);
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.delete,
                                                            color: Colors.red),
                                                        SizedBox(width: 5),
                                                        Text(
                                                            'Eliminar Reporte'),
                                                      ],
                                                    ),
                                                  ),
                                          );
                                        });
                                      }),
                                ],
                              ),
                              SizedBox(height: 15),
                              Text('Fecha de carga ' + fecha,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white)),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        List listaProd =
                                            reports[index]['listaRegistro'];

                                        showDetailsSold(cantVendida,
                                            cantProducida, listaProd);
                                      },
                                      child: Text('Ver Detalle de Ventas',
                                          style:
                                              TextStyle(color: Colors.white))),
                                  FlatButton(
                                      onPressed: () {
                                        showTotalSolds(
                                            cantVendida, cantProducida);
                                      },
                                      child: Text('Ver Totales',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ],
                              ),
                            ],
                          ),
                        ));
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  String getCantVendida(List lista) {
    int cantVendida = 0;
    for (int i = 0; i <= lista.length - 1; i++) {
      cantVendida = cantVendida + lista[i]['cantidad_vend'];
    }
    return cantVendida.toString();
  }

  String getCantProducida(List lista) {
    int cantProducida = 0;
    for (int i = 0; i <= lista.length - 1; i++) {
      cantProducida = cantProducida + lista[i]['cantidad_prod'];
    }
    return cantProducida.toString();
  }

  void showTotalSolds(String cantVendida, String cantProducida) async {
    Map<String, double> dataMap = {
      'Cantidad vendida': double.parse(cantVendida),
      'Cantidad producida': double.parse(cantProducida),
    };
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.7,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text('Cifras Totales',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      PieChart(
                          chartLegendSpacing: 25.0,
                          chartRadius: 160.0,
                          dataMap: dataMap),
                    ],
                  ),
                ),
              ),
            ));
  }

  void showDetailsSold(
      String cantVendida, String cantProducida, List listaprod) async {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.7,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text('Detalle de Venta',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      DataTable(
                          columnSpacing: 0.3,
                          columns: [
                            DataColumn(
                                label: Text('Producto',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0))),
                            DataColumn(
                                label: Text('Cant.V',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0))),
                            DataColumn(
                                label: Text('Cant.P',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0))),
                          ],
                          rows: listaprod
                              .map((element) => DataRow(cells: [
                                    DataCell(Text(element['denominacion'])),
                                    DataCell(Text(
                                        element['cantidad_prod'].toString())),
                                    DataCell(Text(
                                        element['cantidad_vend'].toString()))
                                  ]))
                              .toList()),
                    ],
                  ),
                ),
              ),
            ));
  }

  updateReport(List<dynamic> listaRegistro, String _id) {
    Services s = new Services();
    List<Map<String, dynamic>> listreports = [];

    TextEditingController denomination = new TextEditingController();
    // ignore: non_constant_identifier_names
    TextEditingController code_ean = new TextEditingController();
    // ignore: non_constant_identifier_names
    TextEditingController precio_unidad = new TextEditingController();
    // ignore: non_constant_identifier_names
    TextEditingController unidad_medida = new TextEditingController();
    // ignore: non_constant_identifier_names
    TextEditingController cant_producida = new TextEditingController();
    // ignore: non_constant_identifier_names
    TextEditingController cant_vendida = new TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[300].withOpacity(0.9),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Nuevo Producto', style: TextStyle(color: Colors.black)),
                SizedBox(width: 10),
                FaIcon(FontAwesomeIcons.box),
              ],
            ),
            Divider(
              color: Colors.grey,
              endIndent: 10.0,
              thickness: 0.7,
              indent: 6.0,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
                child: Column(
              children: <Widget>[
                Row(children: [
                  Text('Cod. EAN',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 48),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: TextField(
                      controller: code_ean,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Text('Denom.', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 60),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: TextField(
                      controller: denomination,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Text('Precio U.',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 50),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: TextField(
                      controller: precio_unidad,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('\$'),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Text('Unidad med.',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 28),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: TextField(
                      controller: unidad_medida,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Text('Cantidad Prod.',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 13),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: TextField(
                      controller: cant_producida,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 5),
                Row(children: [
                  Text('Cantidad Vend.',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 13),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: TextField(
                      controller: cant_vendida,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 15),
                MaterialButton(
                    onPressed: () {
                      Map<String, dynamic> report = {
                        'denominacion': denomination.text,
                        'codigo_ean': code_ean.text,
                        'precio_unidad': int.parse(precio_unidad.text),
                        'unidad_medida': unidad_medida.text,
                        'cantidad_prod': int.parse(cant_producida.text),
                        'cantidad_vend': int.parse(cant_vendida.text),
                      };

                      listreports.add(report);
                      s.updateReport(_id, listreports);
                      showMessage(context);
                      setState(() {
                        HomeBusiness();
                      });
                    },
                    color: Colors.blue[300],
                    child: Text('Actualizar Reporte',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

showMessage(context) async {
  return Toast.show("Reporte actualizado", context,
      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
}
