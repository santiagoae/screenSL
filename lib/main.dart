
import 'package:flutter/material.dart';
import 'package:slscreen/pages/captura_informacion.dart';
import 'package:slscreen/pages/listado_empresas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ListadoEmpresa.ROUTE,
      routes: {
        ListadoEmpresa.ROUTE :(_) => ListadoEmpresa(),
        CapturaInfo.ROUTE :(_) => CapturaInfo()
      },
    );
    
  }
}