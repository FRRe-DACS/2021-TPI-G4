import 'package:flutter/material.dart';
import 'package:sipre/services/services.dart';

void main() => runApp(MenuMinistery());

// ignore: must_be_immutable
class MenuMinistery extends StatelessWidget {
  Services s = new Services();
  List<dynamic> content = [];
  String anio;
  bool isEmpty = true;
  TextEditingController year = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Center(child: Text('Menu Ministerio')),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 35, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextField(
                                controller: year,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                decoration: InputDecoration(
                                  hintText: 'Buscar estadísticas...',
                                  suffixIcon: Material(
                                    elevation: 2,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: IconButton(
                                        icon: Icon(Icons.search),
                                        onPressed: () async {
                                          anio = year.text.substring(2, 4);
                                          content = await s.getStatistics(anio);
                                          if (content.isNotEmpty) {
                                            isEmpty = false;
                                          }
                                          if (content == null) {
                                            print('null');
                                          }
                                        }),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 13),
                                ))),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                isEmpty ? emptyTable() : loadTable(content),
              ]),
        )),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text('Usuario del Ministerio'),
                accountEmail: Text('CUIT/CUIL:' + '0000000000')),
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

Widget emptyTable() {
  return DataTable(columnSpacing: 25.0, columns: [
    DataColumn(
        label: Text('Industria',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0))),
    DataColumn(
        label: Text('Cant.vendidas',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0))),
    DataColumn(
        label: Text('Cant.producidas',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0))),
  ], rows: [
    DataRow(cells: [
      DataCell(Text('')),
      DataCell(Text('')),
      DataCell(Text('')),
    ])
  ]);
}

Widget loadTable(List content) {
  return DataTable(
      columnSpacing: 25.0,
      columns: [
        DataColumn(
            label: Text(
          'Industria',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
        )),
        DataColumn(
            label: Text('Cant.vendidas',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0))),
        DataColumn(
            label: Text('Cant.producidas',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0))),
      ],
      rows: content
          .map((element) => DataRow(cells: [
                DataCell(Text(element['nombre'])),
                DataCell(Text(element['cantV'].toString())),
                DataCell(Text(element['cantP'].toString()))
              ]))
          .toList());
}
