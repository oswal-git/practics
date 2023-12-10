import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practics/utils/utils.dart';

class CircularImages extends StatelessWidget {
  const CircularImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Imágenes circulares')),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://picsum.photos/seed/picsum/200/300',
                  fit: BoxFit.cover,
                ),
              ),
              20.ph,
              Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.memory(
                  const Base64Decoder().convert(
                    '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',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              20.ph,
              Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://static.toiimg.com/photo/87603925.cms',
                  fit: BoxFit.cover,
                ),
              ),
              20.ph,
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  'https://picsum.photos/seed/picsum/100/100',
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              ),
              20.ph,
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/seed/904/600',
                ),
              ),
              20.ph,
              Card(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                elevation: 5,
                child: Image.network(
                  'https://storage.googleapis.com/pod_public/1300/173932.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              20.ph,
              PhysicalModel(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  elevation: 5.0,
                  // shadowColor: const Color.fromARGB(255, 20, 11, 58),
                  shape: BoxShape.circle,
                  child: Image.network(
                    'https://hips.hearstapps.com/hmg-prod/images/jujutsu-kaisen-1667648857.jpg?crop=1xw:1xh;center,top&resize=980:*',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
