import 'package:flutter/material.dart';

class ListMaps extends StatelessWidget {
  const ListMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lista = [
      {'name': 'Oswal', 'apellido': 'Contreras', 'ocupacion': 'parado'},
      {'name': 'Oswal1', 'apellido': 'Contreras1', 'ocupacion': 'parado1'},
      {'name': 'Oswal2', 'apellido': 'Contreras2', 'ocupacion': 'parado2'},
      {'name': 'Oswal3', 'apellido': 'Contreras3', 'ocupacion': 'parado3'},
      {'name': 'Oswal4', 'apellido': 'Contreras4', 'ocupacion': 'parado4'},
      {'name': 'Oswal5', 'apellido': 'Contreras5', 'ocupacion': 'parado5'},
    ];

    List<dynamic> getLista2() {
      return List<dynamic>.from(lista.map((item) {
        return {'name': item['name'] ?? '', 'apellido': item['apellido'] ?? '', 'ocupacion': '${item['ocupacion'] ?? ''}-2'};
      }));
    }

    final lista2 = getLista2();

    return Scaffold(
      appBar: AppBar(
        title: const Text('List and Maps'),
      ),
      body: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(lista[index]['name']!),
                  subtitle: Text(lista[index]['ocupacion']!),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lista2.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(lista2[index]['name']!),
                  subtitle: Text(lista2[index]['ocupacion']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
