import 'package:slscreen/db/operaciones.dart';
import 'package:slscreen/pages/captura_informacion.dart';
import 'package:flutter/material.dart';
import '../models/empresas.dart';

class ListadoEmpresa extends StatelessWidget {
  static const String ROUTE = "/";

  @override
  Widget build(BuildContext context) {
    return _MyList();
  }
}

class _MyList extends StatefulWidget {
  @override
  State<_MyList> createState() => _MyListState();
}

class _MyListState extends State<_MyList> {
  List<Empresas> empresas = [];
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Empresas"),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: empresas.length,
        itemBuilder: (_, i) => _createItem(i),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, CapturaInfo.ROUTE,
                  arguments: Empresas.empty())
              .then((value) => setState(() {
                    _loadData();
                  }));
          
        },
      ),
    );
  }

  _loadData() async {
    List<Empresas> auxEmpresa = await Operations.empresas();

    setState(() {
      empresas = auxEmpresa;
    });
  }

  _createItem(int i) {
    return Dismissible(
      key: Key(i.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 10),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white)),
      ),
      onDismissed: (direction) {
        print(direction);
        Operations.delete(empresas[i]);
      },
      child: ListTile(
        title: Text(empresas[i].title!),
        trailing: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, CapturaInfo.ROUTE,
                      arguments: empresas[i])
                  .then((value) => setState(() {
                        _loadData();
                      }));
            },
            child: Icon(Icons.edit)),
      ),
    );
  }
}
