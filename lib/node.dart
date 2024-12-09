import 'dart:math';

class NodeC {
  final String id; // Clave única
  String? attribute; // Nombre del atributo
  Map<String, NodeC> children = {}; // Hijos del nodo
  String?
      label; // Etiqueta para nodos hoja (por ejemplo, "aceptado", "rechazado")

  NodeC({this.attribute, this.label}) : id = _generateUniqueId();

  bool get isLeaf => label != null;

  // Generador de identificadores únicos
  static String _generateUniqueId() {
    return Random().nextInt(1000000).toString();
  }
}
    // Configuración del algoritmo BuchheimWalker
/*     var builder = graphview.BuchheimWalkerAlgorithm(
      graphview.BuchheimWalkerConfiguration()
        ..siblingSeparation = 25
        ..levelSeparation = 50
        ..subtreeSeparation = 30
        ..orientation =
            graphview.BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM,
      graphview.TreeEdgeRenderer(graphview.BuchheimWalkerConfiguration()),
    );
 */