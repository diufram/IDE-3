import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ide3/node.dart';
import 'package:ide3/widgets/button_custom.dart';
import 'package:ide3/widgets/text_custom.dart';
import 'package:lottie/lottie.dart';

class Arbol extends StatefulWidget {
  final NodeC tree;

  const Arbol({super.key, required this.tree});

  @override
  State createState() => _ArbolState();
}

class _ArbolState extends State<Arbol> {
  NodeC? currentNode; // Nodo actual en el árbol
  String? selectedValue; // Valor seleccionado para el atributo actual

  @override
  void initState() {
    super.initState();
    currentNode = widget.tree; // Comenzamos en la raíz
  }

  @override
  Widget build(BuildContext context) {
    if (currentNode!.isLeaf) {
      return Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/tree.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              bottom: MediaQuery.sizeOf(context).height * 0.4,
              child: Lottie.asset(
                'assets/confeti.json', // Ruta de tu archivo JSON
                repeat: false,
                width: MediaQuery.sizeOf(context).height * 0.5,
                height: MediaQuery.sizeOf(context).height * 0.5,

                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCustom(
                      text: "Credito: ${currentNode!.label}".toUpperCase(),
                      fontSize: 30),
                  const SizedBox(height: 20),
                  ButtonCustom(
                    onPressed: () {
                      setState(() {
                        currentNode = widget.tree; // Reiniciamos el árbol
                      });
                    },
                    text: "Iniciar Nuevamente",
                    color: Colors.greenAccent,
                    colorText: Colors.black,
                    fontSize: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Mostrar las opciones para el atributo actual
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextCustom(
                  text: "${currentNode!.attribute}".toUpperCase(),
                  fontSize: 40),
              const SizedBox(height: 20),
              ...currentNode!.children.keys.map((value) {
                bool isSelected = value == selectedValue;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: isSelected ? Colors.purple : Colors.grey,
                        width: 2,
                      ),
                    ),
                    color: isSelected ? Colors.purple.shade50 : Colors.white,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 50.h,
                      child: Center(
                        child: TextCustom(
                          text: value.toUpperCase(),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              ButtonCustom(
                onPressed: () {
                  if (selectedValue != null &&
                      currentNode!.children.containsKey(selectedValue)) {
                    setState(() {
                      currentNode = currentNode!.children[selectedValue];
                      selectedValue =
                          null; // Reiniciar selección para el siguiente nivel
                    });
                  }
                },
                text: "Continuar",
                color: Colors.greenAccent,
                colorText: Colors.black,
                fontSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
