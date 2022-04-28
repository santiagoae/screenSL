import 'package:slscreen/models/empresas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Operations {

  static Future<Database> _openDB() async {
    return openDatabase(
      join( await getDatabasesPath(), 'product.db'),     

      onCreate: (db, version){
        return db.execute(                   
          "CREATE TABLE product (id INTEGER PRIMARY KEY, title TEXT, tipo TEXT, categoria TEXT, content TEXT )"          
        );
        
      }, version: 1
    );
  }

  static Future<int> insert(Empresas empresa)async{
    Database database = await _openDB();
    
    return database.insert("product", empresa.toMap());
  }

  static Future<int> delete(Empresas empresa)async{
    Database database = await _openDB();
    
    return database.delete("product", where: "id = ?", whereArgs: [empresa.id] );
  }

  static Future<int> update(Empresas empresa)async{
    Database database = await _openDB();
    
    return database.update("product",empresa.toMap(), where: "id = ?", whereArgs: [empresa.id] );
  }

  static Future<List<Empresas>>  empresas() async{
    Database database = await _openDB();
    final List<Map<String, dynamic>> empresasMap = await database.query("product");

    for (var recorrerObjeto in empresasMap) {
      print("__________"+recorrerObjeto["title"] );
    }

    return List.generate(empresasMap.length, (i) => Empresas(id: empresasMap[i]['id'], title: empresasMap[i]['title'], tipo: empresasMap[i]['tipo'], categoria: empresasMap[i]['categoria'], content: empresasMap[i]['content']));
  }
  
}