import "package:flutter/material.dart";
import 'package:slscreen/db/operaciones.dart';
import 'package:slscreen/models/empresas.dart';

class CapturaInfo extends StatefulWidget {
  static const String ROUTE = "/capturaInfo";

  @override
  State<CapturaInfo> createState() => _CapturaInfoState();
}

class _CapturaInfoState extends State<CapturaInfo> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final tipoController = TextEditingController();

  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Empresas empresa = ModalRoute.of(context)!.settings.arguments as Empresas;
    _init(empresa);

    return Scaffold(
      appBar: AppBar(
        title: Text("Producto"),
      ),
      body: Container(
        child: _buildForm(empresa),
      ),
    );
  }

  _init(Empresas empresa) {
    titleController.text = empresa.title!;
    contentController.text = empresa.content!;
    tipoController.text = empresa.tipo!;
  }

  @override
  Widget _buildForm(Empresas empresa) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value != null) {
                  return null;
                } else {
                  return "tiene que colocar data";
                }
              },
              decoration: InputDecoration(
                  labelText: "Nombre de la Empresa",
                  border:
                      OutlineInputBorder() //borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: tipoController,
              validator: (value) {
                if (value != null) {
                  return null;
                } else {
                  return "tiene que colocar data";
                }
              },
              decoration: InputDecoration(
                  labelText: "Tipo de camisa", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: contentController,
              maxLines: 8,
              maxLength: 1000,
              validator: (value) {
                if (value != null) {
                  return null;
                } else {
                  return "tiene que colocar data";
                }
              },
              decoration: InputDecoration(
                  labelText: "Contenedor",
                  border:
                      OutlineInputBorder() //borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
            ),
            ElevatedButton(
                child: Text("Guardar"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (empresa.id != null) {
                      //actualizacion
                      empresa.title = titleController.text;
                      empresa.tipo = tipoController.text;
                      empresa.content = contentController.text;
                      Operations.update(empresa);
                    } else {
                      //insertar
                      Operations.insert(Empresas(
                        title: titleController.text,
                        tipo: tipoController.text,
                        content: contentController.text,
                      ));
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
