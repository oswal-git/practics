// Copyright 2022 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Original PageBody by RydMike under MIT License
// see https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/widgets/universal/page_body.dart

import 'package:flutter/material.dart';
import 'package:practics/views/centered_typography_screen/text_style_example.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// A centered width constrained web style page body.
///
/// This type of layout is often used on web pages.
///
/// It provides the following features to the content of the page:
/// - Adds a scrollbar
/// - Adds the capability to un-focus a control like a TextFiled by clicking on
///   the background.
/// - Center the content and limit the content width when a given max width
///   constraint is exceeded.
///
///  This implementation has a flaw, you cannot mouse or touch/drag scroll from
///  expanding margin areas like you could in a Web view. Read more about
///  it here: https://rydmike.com/blog_layout_and_theming
///
/// This is a Flutter "Universal" Widget that only depends on the SDK and
/// can be dropped into any application.
class TypographyScreen extends StatelessWidget {
  /// Default constructor for the constrained PageBody.
  TypographyScreen({
    super.key,
  });

  /// Optional scroll controller for the constrained page body.
  ///
  /// If you use a scrolling view as child to the page body, that needs a
  /// scroll controller, we need to use the same controller here too.
  ///
  /// If null, a default controller is used.
  final ScrollController myScrollController = ScrollController();

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
      TextStyleExample(name: 'Title Large', style: textTheme.titleLarge!.copyWith(color: Colors.white)),
      TextStyleExample(name: 'Title Medium', style: textTheme.titleMedium!.copyWith(color: Colors.white)),
      TextStyleExample(name: 'Title Small', style: textTheme.titleSmall!.copyWith(color: Colors.white)),
      TextStyleExample(name: 'Label Large', style: textTheme.labelLarge!.copyWith(color: Colors.white)),
      TextStyleExample(name: 'Label Medium', style: textTheme.labelMedium!.copyWith(color: Colors.white)),
      TextStyleExample(name: 'Label Small', style: textTheme.labelSmall!.copyWith(color: Colors.white)),
      TextStyleExample(name: 'Body Large', style: textTheme.bodyLarge!.copyWith(color: Colors.white)),
      TextStyleExample(name: 'Body Medium', style: textTheme.bodyMedium!.copyWith(color: Colors.white)),
      TextStyleExample(name: 'Body Small', style: textTheme.bodySmall!.copyWith(color: Colors.white)),
    ];

    // We want the scroll bars to be at the edge of the screen, not next to the
    // width constrained content. If we use the built in scroll bars of the
    // in a scrolling child, it will be next to the child, not at the edge of
    // the screen where it belongs.
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
          width: 300,
          child: Text(
            'Ejemplos de tipografías',
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        toolbarHeight: 80,
      ),
      body: Scrollbar(
        controller: myScrollController,
        child: GestureDetector(
          // This allows us to un-focus a widget, typically a TextField with focus
          // by tapping somewhere outside it. It is no longer needed on desktop
          // builds, it is done automatically there, but not on tablet and phone
          // app. In this demo we want it on them too.
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                minWidth: MediaQuery.of(context).size.width / 2,
              ),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Padding(
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
