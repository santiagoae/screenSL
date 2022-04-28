class Empresas {
   int? id;
   String? title = "" ;     
   String? tipo = "" ;
   String? categoria = "";   
   String? content = "" ;

  Empresas({
    this.id, 
    required this.title,    
    required this.tipo,    
    required this.categoria,    
    required this.content,
  });

  Empresas.empty();

  Map<String, dynamic> toMap() {
    return {
      "id": id, 
      "title": title,
      "tipo": tipo,
      "categoria": categoria,      
      "content": content,
      
    };
  }
}