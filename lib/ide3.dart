import 'package:ide3/node.dart';
import 'dart:math';

class ID3 {
  NodeC construirArbol(
      List<Map<String, String>> data, List<String> attributes) {
    if (_allSameClass(data)) {
      return NodeC()..label = data[0]["CREDITO"];
    }

    if (attributes.isEmpty) {
      return NodeC()..label = _majorityClass(data);
    }

    String bestAttribute = _elegirMejorAtributo(data, attributes);

    NodeC root = NodeC()..attribute = bestAttribute;

    Map<String, List<Map<String, String>>> partitions =
        _particionarData(data, bestAttribute);

    List<String> remainingAttributes = List.from(attributes);
    remainingAttributes.remove(bestAttribute);

    partitions.forEach((value, subset) {
      if (subset.isEmpty) {
        root.children[value] = NodeC()..label = _majorityClass(data);
      } else {
        root.children[value] = construirArbol(subset, remainingAttributes);
      }
    });

    return root;
  }

  bool _allSameClass(List<Map<String, String>> data) {
    String firstClass = data[0]["CREDITO"]!;
    return data.every((instance) => instance["CREDITO"] == firstClass);
  }

  String _majorityClass(List<Map<String, String>> data) {
    Map<String, int> classCounts = {};
    for (var instance in data) {
      String label = instance["CREDITO"]!;
      classCounts[label] = (classCounts[label] ?? 0) + 1;
    }
    return classCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  String _elegirMejorAtributo(
      List<Map<String, String>> data, List<String> attributes) {
    String? bestAttribute;
    double bestGain = double.negativeInfinity;

    for (String attribute in attributes) {
      double gain = _calcularGanancia(data, attribute);
      if (gain > bestGain) {
        bestGain = gain;
        bestAttribute = attribute;
      }
    }

    return bestAttribute!;
  }

  double _calcularGanancia(List<Map<String, String>> data, String attribute) {
    double totalEntropy = _calcularEntropia(data);
    Map<String, List<Map<String, String>>> partitions =
        _particionarData(data, attribute);

    double weightedEntropy = partitions.values.fold(
        0.0,
        (sum, subset) =>
            sum + (subset.length / data.length) * _calcularEntropia(subset));

    return totalEntropy - weightedEntropy;
  }

  double _calcularEntropia(List<Map<String, String>> data) {
    Map<String, int> classCounts = {};
    for (var instance in data) {
      String label = instance["CREDITO"]!;
      classCounts[label] = (classCounts[label] ?? 0) + 1;
    }

    double entropy = 0.0;
    for (int count in classCounts.values) {
      double probability = count / data.length;
      entropy -= probability * (probability > 0 ? (probability.log2()) : 0);
    }
    return entropy;
  }

  Map<String, List<Map<String, String>>> _particionarData(
      List<Map<String, String>> data, String attribute) {
    Map<String, List<Map<String, String>>> partitions = {};
    for (var instance in data) {
      String value = instance[attribute]!;
      partitions.putIfAbsent(value, () => []);
      partitions[value]!.add(instance);
    }
    return partitions;
  }
}

extension Logarithm on double {
  double log2() => log(this) / log(2);
}
