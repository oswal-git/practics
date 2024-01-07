import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practics/models/image_article_model.dart';
import 'package:practics/widgets/egl_image_widget.dart';

class GetImagesScreen extends StatefulWidget {
  const GetImagesScreen({Key? key}) : super(key: key);

  @override
  State<GetImagesScreen> createState() => _GetImagesScreenState();
}

class _GetImagesScreenState extends State<GetImagesScreen> {
  final GetImagesController getImagesController =
      Get.put(GetImagesController());

  final _newImageArticle = Rx<ImageArticle>(ImageArticle.clear());
  ImageArticle get newImageArticle => _newImageArticle.value;
  set newImageArticle(ImageArticle value) => _newImageArticle.value = value;

  final _oldImageArticle = Rx<ImageArticle>(ImageArticle.clear());
  ImageArticle get oldImageArticle => _oldImageArticle.value;
  set oldImageArticle(ImageArticle value) => _oldImageArticle.value = value;

  @override
  void initState() {
    super.initState();
    getImagesController.iconUserDefaultProfile =
        'assets/images/icons_user_profile_circle.png';

    _oldImageArticle.value.modify(
      src: getImagesController.iconUserDefaultProfile,
      nameFile: 'icons_user_profile_circle',
      isDefault: true,
    );
    _newImageArticle.value = _oldImageArticle.value.copyWith();

    if (_newImageArticle.value.isDefault) {
      getImagesController.imagePropertie.value =
          Image.asset(getImagesController.iconUserDefaultProfile);
    }

    getImagesController.oldImageArticle = _oldImageArticle.value.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Imágenes circulares')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80.0,
            ),
            EglImageWidget(
              controller: getImagesController,
              image: _newImageArticle.value,
              defaultImage: getImagesController.appDefaultImage,
              onPressedDefault: () {
                // Lógica para recuperar la imagen por defecto
                getImagesController.newImageArticle.modify(
                  src: getImagesController.iconUserDefaultProfile,
                  nameFile: 'icons_user_profile_circle',
                  isDefault: true,
                );
                getImagesController.imageChanged = false;
                getImagesController.imagePicked = null;
                getImagesController.imagePropertie.value =
                    Image.asset(getImagesController.newImageArticle.src);
              },
              onPressedRestore: () {
                // Lógica para restaurar la imagen inicial
                getImagesController.imageChanged = false;
                getImagesController.newImageArticle =
                    getImagesController.oldImageArticle.copyWith();
                getImagesController.imagePicked = null;
                getImagesController.oldImageArticle.isDefault
                    ? getImagesController.imagePropertie.value =
                        Image.asset(getImagesController.newImageArticle.src)
                    : Image.network(getImagesController.newImageArticle.src);
              },
            ),
          ],
        ));
  }
}
