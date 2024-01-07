import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practics/models/image_article_model.dart';
import 'package:practics/utils/utils.dart';
import 'package:practics/widgets/egl_circle_icon_button.dart';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EglImageWidget extends StatefulWidget {
  const EglImageWidget({
    super.key,
    this.controller,
    required this.image,
    required this.defaultImage,
    this.onPressedDefault,
    this.onPressedRestore,
  });

  final dynamic controller;
  final ImageArticle image;
  final String defaultImage;
  final VoidCallback? onPressedDefault;
  final VoidCallback? onPressedRestore;

  @override
  State<EglImageWidget> createState() => _EglImageWidgetState();
}

class _EglImageWidgetState extends State<EglImageWidget> {
  final GetImagesController getImagesController =
      Get.put(GetImagesController());

  @override
  void initState() {
    super.initState();

    widget.controller.newImageArticle =
        widget.controller.oldImageArticle.copyWith();

    if (widget.controller.newImageArticle.isDefault) {
      widget.controller.imagePropertie.value =
          Image.asset(widget.controller.iconUserDefaultProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> optionsGetImage = [
      {
        'option': 'camera',
        'texto': 'Camara',
        'icon': Icons.camera_alt_outlined
      },
      {'option': 'gallery', 'texto': 'Galería', 'icon': Icons.browse_gallery}
    ];

    return Obx(
      () => Align(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Cover
            GestureDetector(
              onTap: () async {
                EglHelper.showMultChoiceDialog(
                  optionsGetImage,
                  'tQuestions',
                  context: context,
                  onChanged: (value) async {
                    Get.back();
                    await widget.controller.pickImage(value);
                  },
                );
              },
              child: widget.image.src != ''
                  ? FittedBox(
                      child: Container(
                        width: MediaQuery.of(context).size.width * .88,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              15.0), // ajusta el radio según sea necesario
                          border: Border.all(
                            color: const Color(0xFFAAAAAA), // color del borde
                            width: 2.0, // ancho del borde
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: widget.controller.imagePropertie.value,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            15.0), // ajusta el radio según sea necesario
                        border: Border.all(
                          color: Colors.transparent, // color del borde
                          width: 2.0, // ancho del borde
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        // Image.network(articleEditController.newArticle.coverImageArticle.src)
                        child: widget.defaultImage == ''
                            ? null
                            : Image.network(
                                widget.defaultImage,
                                width: MediaQuery.of(context).size.width * .88,
                                // height: 300,
                              ),
                      ),
                    ),
            ),
            // Button restore default cover
            if (widget.controller.imageChanged &&
                !widget.controller.oldImageArticle.isDefault)
              Positioned(
                top: -22.0, // Ajusta según sea necesario
                right: 10.0, // Ajusta según sea necesario
                child: EglCircleIconButton(
                  // key: UniqueKey(),
                  backgroundColor: const Color(0xFFAAAAAA),
                  icon: Icons.disabled_by_default_outlined, // X
                  onPressed: widget.onPressedDefault,
                ),
              ),
            // Button restore initial cover
            if (widget.controller.imageChanged)
              Positioned(
                top: -22.0, // Ajusta según sea necesario
                right: (widget.controller.imageChanged &&
                        !widget.controller.oldImageArticle.isDefault)
                    ? 70.0
                    : 10.0, // Ajusta según sea necesario
                child: EglCircleIconButton(
                  // key: UniqueKey(),
                  backgroundColor: const Color(0xFFAAAAAA),
                  icon: Icons.restore, // Relojito hacia atrás
                  onPressed: widget.onPressedRestore,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class GetImagesController extends GetxController {
  //
  final Rx<Image> imagePropertie =
      Rx<Image>(Image.asset('assets/images/icons_user_profile_circle.png'));

  final _newImageArticle = Rx<ImageArticle>(ImageArticle.clear());
  ImageArticle get newImageArticle => _newImageArticle.value;
  set newImageArticle(ImageArticle value) => _newImageArticle.value = value;

  final _oldImageArticle = Rx<ImageArticle>(ImageArticle.clear());
  ImageArticle get oldImageArticle => _oldImageArticle.value;
  set oldImageArticle(ImageArticle value) => _oldImageArticle.value = value;

  final _iconUserDefaultProfile =
      'assets/images/icons_user_profile_circle.png'.obs;
  String get iconUserDefaultProfile => _iconUserDefaultProfile.value;
  set iconUserDefaultProfile(String value) =>
      _iconUserDefaultProfile.value = value;

  final _imageChanged = false.obs;
  bool get imageChanged => _imageChanged.value;
  set imageChanged(bool value) => _imageChanged.value = value;

  final _imagePicked = Rx<XFile?>(XFile(''));
  XFile? get imagePicked => _imagePicked.value;
  set imagePicked(XFile? value) => _imagePicked.value = value;

  final _appDefaultImage = ''.obs;
  String get appDefaultImage => _appDefaultImage.value;

  // Crop code
  final cropImagePath = ''.obs;
  final cropImageSize = ''.obs;

  // Image code
  final selectedImagePath = ''.obs;
  final selectedImageSize = ''.obs;

  // Compress code
  final compressedImagePath = ''.obs;
  final compressedImageSize = ''.obs;

  final _imageCover = Rx<XFile?>(XFile(''));
  XFile? get imageCover => _imageCover.value;
  set imageCover(XFile? value) => _imageCover.value = value;

  @override
  Future<void> onInit() async {
    // Simulating obtaining the user name from some local storage
    super.onInit();
    // _iconUserDefaultProfile.value =
    //     'assets/images/icons_user_profile_circle.png';

    // _oldImageArticle.value.modify(
    //   src: _iconUserDefaultProfile.value,
    //   nameFile: 'icons_user_profile_circle',
    //   isDefault: true,
    // );
    // _newImageArticle.value = _oldImageArticle.value.copyWith();
  }

  //   Widget get imageWidget => imageWidget.value;
  Future<void> getImageWidget(XFile? imagePick) async {
    _imagePicked.value = imagePick;
    // const double widthOval = 200.0;
    // const double heightOval = 200.0;

    if (imagePick == null) {
      // ignore: curly_braces_in_flow_control_structures
      if (_newImageArticle.value.src == '') {
        imagePropertie.value =
            Image.asset('assets/images/icons_user_profile_circle.png');
      } else {
        imagePropertie.value = Image.network(_newImageArticle.value.src);
      }
    } else if (imagePick.path.substring(0, 4) == 'http') {
      imagePropertie.value = Image.network(imagePick.path);
    } else {
      imagePropertie.value = Image.file(File(imagePick.path));
    }
  }

  Future<void> pickImage(String option) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
        source: option == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      //   selectedImagePath = File(pickedFile.path);
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          "${(File(selectedImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // Crop
      final cropImageFile = await ImageCropper().cropImage(
          sourcePath: selectedImagePath.value,
          maxWidth: 512,
          maxHeight: 512,
          compressFormat: ImageCompressFormat.png);
      cropImagePath.value = cropImageFile!.path;
      cropImageSize.value =
          "${(File(cropImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // Compress
      final dir = Directory.systemTemp;
      final nameFile = 'tempimage${EglHelper.generateChain()}.png';
      final targetPath = '${dir.absolute.path}/$nameFile';

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        cropImagePath.value,
        targetPath,
        quality: 90,
        format: CompressFormat.png,
      );
      compressedImagePath.value = compressedFile!.path;
      compressedImageSize.value =
          "${(File(compressedImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

      // final String imageBase64 = base64Encode(imageFile.readAsBytesSync());
      _imageChanged.value = true;
      _newImageArticle.value.modify(
        src: compressedImagePath.value,
        nameFile: nameFile,
        filePath: '',
        fileImage: compressedFile,
        isSelectedFile: true,
        isDefault: false,
        isChange: true,
      );
      await getImageWidget(compressedFile);
    }
    //   Helper.eglLogger('i', 'isLogin: ${profileController.imageCover!.path}');
    //   Helper.eglLogger('i', 'isLogin: ${profileController.imageCover!.path != ''}');
    // checkIsFormValid();
  }
//
}
