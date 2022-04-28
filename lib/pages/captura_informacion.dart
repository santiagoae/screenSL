import 'package:dropdownfield/dropdownfield.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slscreen/db/operaciones.dart';
import 'package:slscreen/models/empresas.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CapturaInfo extends StatefulWidget {
  static const String ROUTE = "/capturaInfo";

  @override
  State<CapturaInfo> createState() => _CapturaInfoState();
}

class _CapturaInfoState extends State<CapturaInfo> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final tipoController = TextEditingController();

  final valorController = TextEditingController();

  final prendaSeleccionada = TextEditingController();

  final videoController = TextEditingController();

  final contentController = TextEditingController();

  int? mostrar;

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

  String seleccionaPrenda = "Seleciona el tipo de prenda";

  List<String> tiposPrenda = [
    "Camiseta",
    "Camisa",
    "Buso",
  ];

  @override
  Widget _buildForm(Empresas empresa) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        autovalidateMode: AutovalidateMode.disabled,
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
              controller: valorController,
              validator: (value) {
                if (value != null) {
                  return null;
                } else {
                  return "tiene que colocar data";
                }
              },
              decoration: InputDecoration(
                  labelText: "Ingresa el valor de este producto",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            DropDownField(
              controller: prendaSeleccionada,
              hintText: seleccionaPrenda,
              enabled: true,
              itemsVisibleInDropdown: 3,
              items: tiposPrenda,
              onValueChanged: (value) {
                setState(() {
                  seleccionaPrenda = value;
                });
              },
            ),

            _mostrarWidget(mostrar),

            ToggleSwitch(
              minWidth: 200,
              minHeight: 80,
              cornerRadius: 10,
              fontSize: 30,
              iconSize: 25,
              activeBgColors: [
                [Colors.green],
                [Colors.white]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.black26,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              labels: ["Agregar", ""],
              icons: [null, FontAwesomeIcons.xmark],
              onToggle: (index) {
                mostrar = index;
              },
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
                      empresa.valor = valorController.value as int;
                      empresa.categoria = prendaSeleccionada.text;
                      empresa.video = videoController.text;
                      empresa.content = contentController.text;
                      Operations.update(empresa);
                    } else {
                      //insertar
                      Operations.insert(Empresas(
                        title: titleController.text,
                        tipo: tipoController.text,
                        valor: valorController.value as int,
                        categoria: prendaSeleccionada.text,
                        video: videoController.text,
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

  @override
  Widget _mostrarWidget(int? valorDelToggle) {
    Widget? mostrarWidget;
    if ( valorDelToggle == 1) {
      mostrarWidget = Container(
        child: TextFormField(
          controller: videoController,
          validator: (value) {
            if (value != null) {
              return null;
            } else {
              return "tiene que colocar data";
            }
          },
          decoration: InputDecoration(
              labelText: "Ingresa el link del video",
              border: OutlineInputBorder()),
        ),
      );
    }
    return mostrarWidget!;
  }
}
