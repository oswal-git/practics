// Copyright 2022 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Original is md3 demo by Flutter Team as part of
// the experimental part of Flutter Samples under BSD-clause 3 license
// copyrigth 2021 see: https://github.com/flutter/samples/tree/main/experimental/material_3_demo

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:practics/views/centered_typography_screen/centered_page_body.dart';
import 'package:practics/views/centered_typography_screen/text_style_example.dart';

class CenteredTypographyScreen extends StatelessWidget {
  final ScrollController myScrollController = ScrollController();

  CenteredTypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final List<Widget> widgetList = [
      const SizedBox(height: 7),
      TextStyleExample(
        name: 'Display Large',
        style: textTheme.displayLarge!.copyWith(color: Colors.white),
      ),
      TextStyleExample(
        name: 'Display Medium',
        style: textTheme.displayMedium!.copyWith(color: Colors.white),
      ),
      TextStyleExample(
        name: 'Display Small',
        style: textTheme.displaySmall!.copyWith(color: Colors.white),
      ),
      TextStyleExample(
        name: 'Headline Large',
        style: textTheme.headlineLarge!.copyWith(color: Colors.white),
      ),
      TextStyleExample(
        name: 'Headline Medium',
        style: textTheme.headlineMedium!.copyWith(color: Colors.white),
      ),
      TextStyleExample(
        name: 'Headline Small',
        style: textTheme.headlineSmall!.copyWith(color: Colors.white),
      ),
      TextStyleExample(
          name: 'Title Large',
          style: textTheme.titleLarge!.copyWith(color: Colors.white)),
      TextStyleExample(
          name: 'Title Medium',
          style: textTheme.titleMedium!.copyWith(color: Colors.white)),
      TextStyleExample(
          name: 'Title Small',
          style: textTheme.titleSmall!.copyWith(color: Colors.white)),
      TextStyleExample(
          name: 'Label Large',
          style: textTheme.labelLarge!.copyWith(color: Colors.white)),
      TextStyleExample(
          name: 'Label Medium',
          style: textTheme.labelMedium!.copyWith(color: Colors.white)),
      TextStyleExample(
          name: 'Label Small',
          style: textTheme.labelSmall!.copyWith(color: Colors.white)),
      TextStyleExample(
          name: 'Body Large',
          style: textTheme.bodyLarge!.copyWith(color: Colors.white)),
      TextStyleExample(
          name: 'Body Medium',
          style: textTheme.bodyMedium!.copyWith(color: Colors.white)),
      TextStyleExample(
          name: 'Body Small',
          style: textTheme.bodySmall!.copyWith(color: Colors.white)),
    ];

    return CenteredPageBody(
      controller: myScrollController,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width / 2,
      ),
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),
      child: AnimationLimiter(
        child: ListView.builder(
          controller: myScrollController,
          itemCount: widgetList.length,
          padding: const EdgeInsets.only(top: 10),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 100.0,
                child: FadeInAnimation(
                  child: widgetList[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
