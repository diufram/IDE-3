import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:ide3/node.dart';

Graph buildGraph(NodeC decisionTree) {
  final graph = Graph();

  // Crea el nodo raíz
  var rootNode =
      Node.Id('Root: ${decisionTree.attribute ?? decisionTree.label}');
  graph.addNode(rootNode);

  // Construye los nodos y conexiones recursivamente
  _addChildrenToGraph(decisionTree, rootNode, graph);

  return graph;
}

void _addChildrenToGraph(NodeC decisionTree, Node currentNode, Graph graph) {
  // Si el nodo tiene hijos, agrega los nodos hijos y sus conexiones
  decisionTree.children.forEach((key, child) {
    var childNode =
        Node.Id(child.isLeaf ? 'Class: ${child.label}' : '${child.attribute}');
    graph.addNode(childNode);
    graph.addEdge(currentNode, childNode, paint: Paint()..color = Colors.blue);

    // Llamada recursiva para construir subárboles
    if (!child.isLeaf) {
      _addChildrenToGraph(child, childNode, graph);
    }
  });
}
