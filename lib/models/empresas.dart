class Empresas {
   int? id;
   String? title = "" ;     
   String? tipo = "" ;
   int? valor;
   String? categoria = "" ;
   String? video ="";
   String? content = "" ;

  Empresas({
    this.id, 
    required this.title,    
    required this.tipo,
    this.valor,
    required this.categoria,
    required this.video,
    required this.content,
  });

  Empresas.empty();

  Map<String, dynamic> toMap() {
    return {
      "id": id, 
      "title": title,
      "tipo": tipo,
      "valor": valor,
      "categoria": categoria,
      "video": video, 
      "content": content,
      
    };
  }
}