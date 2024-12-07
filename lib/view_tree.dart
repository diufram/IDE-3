import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart' as graphview;
import 'package:graphview/GraphView.dart';

class DecisionTreeGraphPage extends StatelessWidget {
  final graphview.Graph graph = graphview.Graph();
  final graphview.BuchheimWalkerConfiguration builder =
      graphview.BuchheimWalkerConfiguration();

  DecisionTreeGraphPage() {
    // Configuración del algoritmo BuchheimWalker
    builder
      ..siblingSeparation = 25
      ..levelSeparation = 50
      ..subtreeSeparation = 30
      ..orientation =
          graphview.BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    // Construcción del grafo
    final node1 = graphview.Node.Id(1);
    final node2 = graphview.Node.Id(2);
    final node3 = graphview.Node.Id(3);

    graph.addEdge(node1, node2);
    graph.addEdge(node1, node3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Árbol de Decisión")),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: InteractiveViewer(
            constrained: false,
            boundaryMargin: const EdgeInsets.all(50),
            minScale: 0.01,
            maxScale: 5.0,
            child: GraphView(
              graph: graph,
              algorithm: graphview.BuchheimWalkerAlgorithm(
                builder,
                graphview.TreeEdgeRenderer(builder),
              ),
              builder: (graphview.Node node) {
                return _buildNode(node.key?.value.toString() ?? 'Node');
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNode(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
