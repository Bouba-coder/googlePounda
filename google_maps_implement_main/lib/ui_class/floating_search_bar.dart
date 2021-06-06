import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
//import 'package:pounda/presentation/core/theme/index.dart';
import 'package:google_maps_implement/presentation/theme_style_impl.dart';
//import 'package:google_maps_implement/presentation/value_translaters.dart';

class FloatingSearchBarNativeWidget extends StatelessWidget {
  final double marginTop;

  const FloatingSearchBarNativeWidget({Key? key, this.marginTop = 0}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      automaticallyImplyBackButton: false,
      borderRadius: BorderRadius.circular(20.2),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      backdropColor: Theme.of(context).colorScheme.primary,
      shadowColor: Theme.of(context).colorScheme.primary,
      margins: EdgeInsets.only(left: 15, right: 15, top: marginTop),
      hint: 'search',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      openWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      leadingActions: [
        FloatingSearchBarAction.hamburgerToBack(),
      ],
      actions: [FloatingSearchBarAction.searchToClear()],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            // color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(
                    height: 112,
                    color: Theme.of(context).colorScheme.primary);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}