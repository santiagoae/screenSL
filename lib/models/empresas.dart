class Empresas {
   int? id;
   String? title = "" ;     
   String? tipo = "" ;   
   String? content = "" ;

  Empresas({
    this.id, 
    required this.title,    
    required this.tipo,    
    required this.content,
  });

  Empresas.empty();

  Map<String, dynamic> toMap() {
    return {
      "id": id, 
      "title": title,
      "tipo": tipo,      
      "content": content,
      
    };
  }
}