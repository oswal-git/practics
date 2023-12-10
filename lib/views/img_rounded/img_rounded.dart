import 'package:flutter/material.dart';
import 'package:practics/config/config.dart';
import 'package:practics/utils/utils.dart';

class ImgRoundedView extends StatelessWidget {
  const ImgRoundedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
          width: 300,
          child: Text(
            'Imágenes con esquinas redondeadas',
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(15) // Adjust the radius as needed
                    ),
                child: Image.network(
                  EglImagesPath.imageTest1,
                  fit: BoxFit.cover,
                ),
              ),
              20.ph,
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(15), // Adjust the radius as needed
                child: Image.network(
                  EglImagesPath.imageTest2,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 120,
                ),
              ),
              20.ph,
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 5.0,
                child: Image.network(
                  EglImagesPath.imageTest3,
                  width: 150,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              20.ph,
              PhysicalModel(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  elevation: 5.0,
                  child: Image.network(
                    EglImagesPath.imageTest5,
                    width: 150,
                    height: 120,
                    fit: BoxFit.cover,
                  )),
              20.ph,
              20.ph,
            ],
          ),
        ),
      ),
    );
  }
}
