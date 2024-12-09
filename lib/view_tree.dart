import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart' as graphview;
import 'package:ide3/node.dart';
import 'package:ide3/widgets/button_custom.dart';

class DecisionTreeGraphPage extends StatefulWidget {
  final NodeC tree;

  const DecisionTreeGraphPage({super.key, required this.tree});

  @override
  _DecisionTreeGraphPageState createState() => _DecisionTreeGraphPageState();
}

class _DecisionTreeGraphPageState extends State<DecisionTreeGraphPage> {
  NodeC? _currentNode; // Nodo actualmente seleccionado

  @override
  void initState() {
    super.initState();
    _currentNode = widget.tree; // Inicialmente el nodo raíz
  }

  @override
  Widget build(BuildContext context) {
    var graph = buildGraph(widget.tree);

    var builder = graphview.BuchheimWalkerAlgorithm(
      graphview.BuchheimWalkerConfiguration()
        ..siblingSeparation = 25
        ..levelSeparation = 50
        ..subtreeSeparation = 30
        ..orientation =
            graphview.BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM,
      graphview.TreeEdgeRenderer(graphview.BuchheimWalkerConfiguration()),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Árbol de Decisión")),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: const EdgeInsets.all(50),
                  minScale: 0.01,
                  maxScale: 5.0,
                  child: graphview.GraphView(
                    graph: graph,
                    algorithm: builder,
                    builder: (graphview.Node node) {
                      return _buildNode(
                        node.key?.value.toString() ?? 'Node',
                        _currentNode,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          ButtonCustom(
            onPressed: () => _startQuestionFlow(context, widget.tree),
            text: "Iniciar Preguntas",
            color: Colors.green,
            colorText: Colors.black,
            fontSize: 20,
          ),
        ],
      ),
    );
  }

  /// Construye el grafo basado en el árbol de decisión
  graphview.Graph buildGraph(NodeC decisionTree) {
    final graph = graphview.Graph();

    // Crear nodo raíz con atributo concatenado
    var rootNode = graphview.Node.Id(
        '${decisionTree.attribute ?? "Root"} (${decisionTree.label ?? ""})');
    graph.addNode(rootNode);

    // Construir nodos y conexiones recursivamente
    _addChildrenToGraph(decisionTree, rootNode, graph);

    return graph;
  }

  /// Agrega nodos hijos al grafo recursivamente
  void _addChildrenToGraph(
      NodeC tree, graphview.Node currentNode, graphview.Graph graph) {
    tree.children.forEach((key, child) {
      // Concatenar atributo y otros datos
      var concatenatedText =
          '$key: ${child.attribute ?? ""} (${child.label ?? ""})';
      var childNode = graphview.Node.Id(concatenatedText);
      graph.addNode(childNode);

      // Agregar conexión entre el nodo actual y el hijo
      graph.addEdge(currentNode, childNode,
          paint: Paint()
            ..color = Colors.blue
            ..strokeWidth = 2);

      // Llamada recursiva si el nodo no es hoja
      if (!child.isLeaf) {
        _addChildrenToGraph(child, childNode, graph);
      }
    });
  }

  /// Construye un widget para representar un nodo
  Widget _buildNode(String text, NodeC? currentNode) {
    bool isSelected =
        currentNode != null && text.contains(currentNode.attribute ?? '');
    return Container(
      width: 120,
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.orange // Nodo seleccionado
            : text.contains("rechazado")
                ? Colors.red
                : text.contains("aceptado")
                    ? Colors.green
                    : const Color.fromARGB(255, 77, 116, 148),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        text.split("()")[0],
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  /// Método para iniciar el flujo de preguntas
  void _startQuestionFlow(BuildContext context, NodeC currentNode) {
    setState(() {
      _currentNode = currentNode; // Resaltar el nodo actual
    });

    if (currentNode.isLeaf) {
      // Si es hoja, mostrar el resultado
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Resultado"),
            content: Text("Decisión: ${currentNode.label}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _currentNode = null; // Resetear el nodo actual
                  });
                },
                child: const Text("Cerrar"),
              ),
            ],
          );
        },
      );
    } else {
      // Mostrar las preguntas
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(currentNode.attribute ?? "Pregunta"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: currentNode.children.keys.map((key) {
                return ListTile(
                  title: Text(key),
                  onTap: () {
                    Navigator.pop(context);
                    _startQuestionFlow(context, currentNode.children[key]!);
                  },
                );
              }).toList(),
            ),
          );
        },
      );
    }
  }
}
