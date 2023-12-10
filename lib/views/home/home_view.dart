import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practics/utils/utils.dart';
import 'package:practics/views/align_view/align_view.dart';
import 'package:practics/views/centered_typography_screen/centered_typography_screen.dart';
import 'package:practics/views/circular_images/circular_images.dart';
import 'package:practics/views/img_rounded/img_rounded.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            // ignore: prefer_const_constructors
            child: Text(
              'Align widget',
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
            onPressed: () {
              Get.to(
                () => const AlignView(),
              );
            },
          ),
          20.ph,
          ElevatedButton(
            // ignore: prefer_const_constructors
            child: Text(
              'Circular Images',
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
            onPressed: () {
              Get.to(
                () => const CircularImages(),
              );
            },
          ),
          20.ph,
          ElevatedButton(
            // ignore: prefer_const_constructors
            child: Text(
              'Rounded corners Images',
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
            onPressed: () {
              Get.to(
                () => const ImgRoundedView(),
              );
            },
          ),
          20.ph,
          ElevatedButton(
            // ignore: prefer_const_constructors
            child: Text(
              'Centered Typography Screen',
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
            onPressed: () {
              Get.to(
                () => CenteredTypographyScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
