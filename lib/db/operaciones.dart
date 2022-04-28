import 'package:slscreen/models/empresas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Operations {

  static Future<Database> _openDB() async {
    return openDatabase(
      join( await getDatabasesPath(), 'organizaciones.db'),

      onCreate: (db, version){
        return db.execute(          
          "CREATE TABLE organizaciones (id INTEGER PRIMARY KEY, title TEXT, content TEXT )"          
        );
        
      }, version: 1
    );
  }

  static Future<int> insert(Empresas empresa)async{
    Database database = await _openDB();
    
    return database.insert("organizaciones", empresa.toMap());
  }

  static Future<int> delete(Empresas empresa)async{
    Database database = await _openDB();
    
    return database.delete("organizaciones", where: "id = ?", whereArgs: [empresa.id] );
  }

  static Future<int> update(Empresas empresa)async{
    Database database = await _openDB();
    
    return database.update("organizaciones",empresa.toMap(), where: "id = ?", whereArgs: [empresa.id] );
  }

  static Future<List<Empresas>>  empresas() async{
    Database database = await _openDB();
    final List<Map<String, dynamic>> empresasMap = await database.query("organizaciones");

    for (var recorrerObjeto in empresasMap) {
      print("__________"+recorrerObjeto["title"] );
    }

    return List.generate(empresasMap.length, (i) => Empresas(id: empresasMap[i]['id'], title: empresasMap[i]['title'], tipo: empresasMap[i]['tipo'], content: empresasMap[i]['content']));
  }
  
}