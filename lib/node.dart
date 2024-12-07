class NodeC {
  String? attribute; // Nombre del atributo
  Map<String, NodeC> children = {}; // Hijos del nodo
  String?
      label; // Etiqueta para nodos hoja (por ejemplo, "aceptado", "rechazado")

  bool get isLeaf => label != null;
}
