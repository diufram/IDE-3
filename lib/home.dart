import 'package:flutter/material.dart';
import 'package:ide3/arbol.dart';
import 'package:ide3/ide3.dart';
import 'package:ide3/node.dart';
import 'package:ide3/view_tree.dart';
import 'package:ide3/widgets/button_custom.dart';
import 'package:ide3/widgets/text_custom.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Generar el árbol de decisión
    ID3 id3 = ID3();
    List<Map<String, String>> data = [
      {
        "MOROSO": "si",
        "ANTIGUEDAD": ">5",
        "INGRESOS": "600-1200",
        "TRABAJO": "tiene",
        "CREDITO": "rechazado"
      },
      {
        "MOROSO": "no",
        "ANTIGUEDAD": "<1",
        "INGRESOS": "600-1200",
        "TRABAJO": "tiene",
        "CREDITO": "aceptado"
      },
      {
        "MOROSO": "si",
        "ANTIGUEDAD": "1-5",
        "INGRESOS": ">1200",
        "TRABAJO": "tiene",
        "CREDITO": "rechazado"
      },
      {
        "MOROSO": "no",
        "ANTIGUEDAD": ">5",
        "INGRESOS": ">1200",
        "TRABAJO": "no-tiene",
        "CREDITO": "aceptado"
      },
      {
        "MOROSO": "no",
        "ANTIGUEDAD": "<1",
        "INGRESOS": ">1200",
        "TRABAJO": "tiene",
        "CREDITO": "aceptado"
      },
      {
        "MOROSO": "si",
        "ANTIGUEDAD": "1-5",
        "INGRESOS": "600-1200",
        "TRABAJO": "tiene",
        "CREDITO": "rechazado"
      },
      {
        "MOROSO": "no",
        "ANTIGUEDAD": "1-5",
        "INGRESOS": ">1200",
        "TRABAJO": "tiene",
        "CREDITO": "aceptado"
      },
      {
        "MOROSO": "no",
        "ANTIGUEDAD": "<1",
        "INGRESOS": "<600",
        "TRABAJO": "tiene",
        "CREDITO": "rechazado"
      },
      {
        "MOROSO": "no",
        "ANTIGUEDAD": ">5",
        "INGRESOS": "600-1200",
        "TRABAJO": "no-tiene",
        "CREDITO": "rechazado"
      },
      {
        "MOROSO": "si",
        "ANTIGUEDAD": "1-5",
        "INGRESOS": "<600",
        "TRABAJO": "no-tiene",
        "CREDITO": "rechazado"
      }
    ];
    List<String> attributes = [
      "ANTIGUEDAD",
      "MOROSO",
      "INGRESOS",
      "TRABAJO",
    ];

    NodeC tree = id3.construirArbol(data, attributes);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/tree.jpg"), // Ruta de tu imagen
                fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextCustom(text: "Bienvenido", fontSize: 75),
                const TextCustom(text: "Arbol de", fontSize: 60),
                const TextCustom(text: "Desision ID3", fontSize: 60),
                ButtonCustom(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Arbol(
                                tree: tree,
                              )),
                      (route) => false, // Condición para conservar rutas
                    );
                  },
                  text: "INICIAR",
                  color: Colors.greenAccent,
                  colorText: Colors.black,
                  fontSize: 20,
                ),
                ButtonCustom(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DecisionTreeGraphPage(
                          tree: tree,
                        ),
                      ),
                      (route) => false, // Condición para conservar rutas
                    );
                  },
                  text: "VER ARBOL",
                  color: Colors.greenAccent,
                  colorText: Colors.black,
                  fontSize: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
