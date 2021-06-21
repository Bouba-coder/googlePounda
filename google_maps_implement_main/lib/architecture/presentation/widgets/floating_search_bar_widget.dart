


import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';


class FloatingSearchBarWidget extends StatelessWidget {
  //variables
  final double marginTop;
  final Function(String)? onQueryChanged;
  final List<Widget> children;
  final FloatingSearchBarController? floatingSearchBarController;
  final Color? backdropColor;


  //constructor
  const FloatingSearchBarWidget({
    Key? key,
    required this.children,
    this.floatingSearchBarController,
    this.backdropColor,
    this.marginTop = 0,
    this.onQueryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: floatingSearchBarController,
      automaticallyImplyBackButton: false,
      borderRadius: BorderRadius.circular(20.2),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      backdropColor: backdropColor ?? Colors.transparent,
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
      onQueryChanged: onQueryChanged,
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      leadingActions: [
        FloatingSearchBarAction.hamburgerToBack(),
      ],
      actions: [FloatingSearchBarAction.searchToClear()],
      builder: (context, transition) {
        return new ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            // color: Colors.white,
            elevation: 4.0,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
