


import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';


class FloatingSearchBarWidget extends StatelessWidget {

  final double marginTop;
  final Function(String)? onQueryChanged;
  final List<Widget> children;
  final FloatingSearchBarController? floatingSearchBarController;
  final Color? backdropColor, backgroundColor, iconColor, accentColor;

  const FloatingSearchBarWidget({
    Key? key,
    required this.children,
    this.floatingSearchBarController,
    this.backdropColor,
    this.backgroundColor,
    this.iconColor,
    this.accentColor,
    this.onQueryChanged,
    this.marginTop = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: floatingSearchBarController,
      automaticallyImplyBackButton: false,
      borderRadius: BorderRadius.circular(10),
      iconColor: iconColor,
      accentColor: accentColor,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      backdropColor: backdropColor ?? Colors.transparent,
      shadowColor: Theme.of(context).colorScheme.primary,
      margins: EdgeInsets.only(left: 15, right: 15, top: marginTop),
      hint: '',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      openWidth: MediaQuery.of(context).size.width,
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
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color:  Theme.of(context).primaryColor,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
