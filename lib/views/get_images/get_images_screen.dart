import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practics/models/image_article_model.dart';
import 'package:practics/utils/utils.dart';
import 'package:practics/widgets/egl_image_widget.dart';

class GetImagesScreen extends StatefulWidget {
  const GetImagesScreen({Key? key}) : super(key: key);

  @override
  State<GetImagesScreen> createState() => _GetImagesScreenState();
}

class _GetImagesScreenState extends State<GetImagesScreen> {
  final GetImagesController getImagesController = Get.put(GetImagesController());

  final _appDefaultImage = 'assets/images/icons_user_profile_circle.png'.obs;
  // final _appDefaultNameImage = 'icons_user_profile_circle.png'.obs;

  final _newImageArticle = Rx<ImageArticle>(ImageArticle.clear());
  ImageArticle get newImageArticle => _newImageArticle.value;
  set newImageArticle(ImageArticle value) => _newImageArticle.value = value;

  final _oldImageArticle = Rx<ImageArticle>(ImageArticle.clear());
  ImageArticle get oldImageArticle => _oldImageArticle.value;
  set oldImageArticle(ImageArticle value) => _oldImageArticle.value = value;

  final imageData =
      'https://images.unsplash.com/photo-1609813744174-a0df83d477fe?q=80&w=200&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  @override
  void initState() {
    super.initState();

    // _oldImageArticle.value.modify(
    //   src: _appDefaultImage.value,
    //   nameFile: _appDefaultNameImage.value,
    //   isDefault: true,
    // );
    _oldImageArticle.value.modify(
      src: imageData,
      nameFile: EglHelper.getNameFilePath(imageData),
    );
    _newImageArticle.value = _oldImageArticle.value.copyWith();

    if (_newImageArticle.value.isDefault) {
      getImagesController.imagePropertie.value = Image.asset(getImagesController.iconUserDefaultProfile);
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
              image: _newImageArticle.value,
              defaultImage: _appDefaultImage.value,
              onPressedDefault: (ImageArticle image) {
                // Lógica para recuperar la imagen por defecto
                _newImageArticle.value = image.copyWith();
                EglHelper.eglLogger('i', 'onPressedDefault: ${_newImageArticle.value.toString()}');
              },
              onPressedRestore: (ImageArticle image) {
                // Lógica para restaurar la imagen inicial
                _newImageArticle.value = image.copyWith();
                EglHelper.eglLogger('i', 'onPressedRestore: ${_newImageArticle.value.toString()}');
              },
            ),
          ],
        ));
  }
}
