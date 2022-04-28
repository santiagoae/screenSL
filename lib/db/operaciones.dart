import 'package:slscreen/models/empresas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Operations {

  static Future<Database> _openDB() async {
    return openDatabase(
      join( await getDatabasesPath(), 'productosEmpresa.db'),

      onCreate: (db, version){
        return db.execute(          
          "CREATE TABLE organizaciones (id INTEGER PRIMARY KEY, title TEXT, tipo TEXT, valor INTEGER, categoria TEXT, video TEXT, content TEXT )"          
        );
        
      }, version: 1
    );
  }

  static Future<int> insert(Empresas empresa)async{
    Database database = await _openDB();
    
    return database.insert("productosEmpresa", empresa.toMap());
  }

  static Future<int> delete(Empresas empresa)async{
    Database database = await _openDB();
    
    return database.delete("productosEmpresa", where: "id = ?", whereArgs: [empresa.id] );
  }

  static Future<int> update(Empresas empresa)async{
    Database database = await _openDB();
    
    return database.update("productosEmpresa",empresa.toMap(), where: "id = ?", whereArgs: [empresa.id] );
  }

  static Future<List<Empresas>>  empresas() async{
    Database database = await _openDB();
    final List<Map<String, dynamic>> empresasMap = await database.query("productosEmpresa");

    for (var recorrerObjeto in empresasMap) {
      print("__________"+recorrerObjeto["title"] );
    }

    return List.generate(empresasMap.length, (i) => Empresas(id: empresasMap[i]['id'], title: empresasMap[i]['title'], tipo: empresasMap[i]['tipo'], valor: empresasMap[i]['valor'], categoria: empresasMap[i]['categoria'], video: empresasMap[i]['video'], content: empresasMap[i]['content']));
  }
  
}