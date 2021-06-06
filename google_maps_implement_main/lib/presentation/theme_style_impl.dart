// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_implement/presentation/value_translaters.dart';
// //import 'package:freezed_annotation/freezed_annotation.dart';
// //import 'package:injectable/injectable.dart';
// //import 'package:pounda/presentation/core/theme/theme_style/i_theme_style.dart';
// //import 'package:pounda/presentation/core/theme/colors/constants.dart';
// //import 'package:pounda/presentation/core/theme/others/constants.dart';
//
//
// class ThemeStyleImpl implements IThemeStyle {
//   Color get animatedIconButtonSplashColor => cBlackAnthracite;
//
//   bool isDarkTheme(BuildContext context) =>
//       Theme.of(context).primaryColor == cBlackAnthracite
//           ? true
//           : false;
//
//   Color shadowDarkColor(BuildContext context) =>
//       isDarkTheme(context) ? cBlack : cWhite;
//
//   Color shadowLightColor(BuildContext context) =>
//       isDarkTheme(context) ? cWhite : cBlack;
//
//   @override
//   Theme dark({required Widget child}) {
//     return Theme(
//         data: ThemeData(
//           accentColor: cBlueAccent,
//           indicatorColor: cWhite,
//           primaryColor: cBlackAnthracite,
//           primaryColorDark: cBlackAnthraciteDark,
//           primaryColorLight: cBlackAnthraciteLight,
//           backgroundColor: cBlackAnthraciteDark,
//           tabBarTheme: const TabBarTheme(labelStyle: TextStyle(fontFamily: ffSecondary, fontWeight: FontWeight.bold), unselectedLabelStyle: TextStyle(fontFamily: ffSecondary)),
//           // inputDecorationTheme: InputDecorationTheme(focusedBorder: OutlineInputBorder(
//           //   borderRadius: BorderRadius.circular(18),
//           //   borderSide: const BorderSide(color: cGreen, width: 2),
//           // )),
//           primaryIconTheme: const IconThemeData(color: cWhite),
//           // accentIconTheme: const IconThemeData(color: cBlack),
//           colorScheme:
//           ThemeData().colorScheme.copyWith(brightness: Brightness.dark),
//           textTheme: ThemeData.dark()
//               .textTheme
//               .apply(
//             // fontFamily: primaryFontFamily,
//           )
//               .copyWith(
//             // button: TextStyle(color: cWhite),
//             // headline6: TextStyle(color: cWhite),
//             // headline1: TextStyle(fontSize: 25),
//             // headline2: TextStyle(fontSize: 22),
//             // headline3: TextStyle(fontSize: 18),
//             // bodyText2: TextStyle(color: cWhite, fontFamily: secondaryFontFamily),
//           ),
//           primaryTextTheme: ThemeData.dark()
//               .textTheme
//               .apply(
//             fontFamily: ffSecondary,
//           )
//               .copyWith(
//             headline1: const TextStyle(fontSize: 25, color: cWhite),
//             headline2: const TextStyle(fontSize: 22, color: cWhite),
//             headline3: const TextStyle(fontSize: 18, color: cWhite),
//             headline4: const TextStyle(fontSize: 16, color: cWhite),
//             headline5: const TextStyle(fontSize: 14, color: cWhite),
//             headline6: const TextStyle(fontSize: 12, color: cWhite),
//             bodyText1: const TextStyle(fontSize: 10, color: cWhite),
//             bodyText2: const TextStyle(fontSize: 8, color: cWhite),
//           ),
//           accentTextTheme: ThemeData.dark().textTheme.copyWith(
//             headline1: const TextStyle(
//                 fontSize: 25, color: cWhite, fontFamily: ffSecondary),
//             headline2: const TextStyle(
//                 fontSize: 22, color: cWhite, fontFamily: ffSecondary),
//             headline3: const TextStyle(
//                 fontSize: 18, color: cWhite, fontFamily: ffSecondary),
//             headline4: const TextStyle(
//                 fontSize: 16, color: cWhite, fontFamily: ffSecondary),
//             headline5: const TextStyle(
//                 fontSize: 14, color: cWhite, fontFamily: ffSecondary),
//             headline6: const TextStyle(
//                 fontSize: 12, color: cWhite, fontFamily: ffSecondary),
//             bodyText1: const TextStyle(
//                 fontSize: 10, color: cWhite, fontFamily: ffSecondary),
//             bodyText2: const TextStyle(
//                 fontSize: 8, color: cWhite, fontFamily: ffSecondary),
//           ),
//           appBarTheme: AppBarTheme(
//             backgroundColor: cBlackAnthraciteDark,
//           ),
//           // inputDecorationTheme: InputDecorationTheme(focusedBorder: OutlineInputBorder(borderSide:  BorderSide(color: cWhite))),
//           outlinedButtonTheme: OutlinedButtonThemeData(
//               style: ButtonStyle(side:
//               MaterialStateProperty.resolveWith<BorderSide>((states) {
//                 if (states.contains(MaterialState.focused)) return BorderSide();
//                 if (states.contains(MaterialState.hovered)) return BorderSide();
//                 if (states.contains(MaterialState.pressed)) return BorderSide();
//                 return BorderSide(width: 1, color: cGrey);
//               }), overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
//                 if (states.contains(MaterialState.focused))
//                   return cBlackAnthraciteLight.withOpacity(0.25);
//                 if (states.contains(MaterialState.hovered))
//                   return cBlackAnthraciteLight.withOpacity(0.5);
//                 if (states.contains(MaterialState.pressed))
//                   return cBlackAnthraciteLight.withOpacity(1);
//                 return Colors.transparent;
//               }), shape:
//               MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
//                 if (states.contains(MaterialState.focused))
//                   return RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(sRadius));
//                 if (states.contains(MaterialState.hovered))
//                   return RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(sRadius));
//                 if (states.contains(MaterialState.pressed))
//                   return RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(sRadius));
//                 return RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(sRadius));
//               }))
//             //     OutlinedButton.styleFrom(
//             //   shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(rdSmall)),
//             //   side: const BorderSide(width: 1, color: cWhite),
//             // ),
//           ),
//           elevatedButtonTheme: ElevatedButtonThemeData(
//               style: ButtonStyle(elevation:
//               MaterialStateProperty.resolveWith<double>((states) {
//                 if (states.contains(MaterialState.focused)) return 8;
//                 if (states.contains(MaterialState.hovered)) return 8;
//                 if (states.contains(MaterialState.pressed)) return 8;
//                 return 8;
//               }), shape:
//               MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
//                 if (states.contains(MaterialState.focused))
//                   return RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(lRadius));
//                 if (states.contains(MaterialState.hovered))
//                   return RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(lRadius));
//                 if (states.contains(MaterialState.pressed))
//                   return RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(lRadius));
//                 return RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(lRadius));
//               }), backgroundColor:
//               MaterialStateProperty.resolveWith<Color>((states) {
//                 if (states.contains(MaterialState.focused))
//                   return cBlackAnthracite.withOpacity(0.5);
//                 if (states.contains(MaterialState.hovered))
//                   return cBlackAnthracite.withOpacity(0.5);
//                 if (states.contains(MaterialState.pressed)) return cBlackAnthracite;
//                 return cWhite.withOpacity(1);
//               }))),
//           textButtonTheme: TextButtonThemeData(
//             style: ButtonStyle(
//               shape:
//               MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
//                 if (states.contains(MaterialState.focused))
//                   return RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(sRadius));
//                 if (states.contains(MaterialState.hovered))
//                   return RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(sRadius));
//                 if (states.contains(MaterialState.pressed))
//                   return RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(sRadius));
//                 return RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(sRadius));
//               }),
//               overlayColor: MaterialStateProperty.resolveWith<Color>(
//                     (states) {
//                   if (states.contains(MaterialState.focused))
//                     return cBlackAnthraciteLight.withOpacity(0.5);
//                   if (states.contains(MaterialState.hovered))
//                     return cBlackAnthraciteLight.withOpacity(0.5);
//                   if (states.contains(MaterialState.pressed))
//                     return cBlackAnthraciteLight;
//                   return Colors.transparent;
//                 },
//               ),
//             ),
//           ),
//
//           // elevatedButtonTheme: ,
//           scaffoldBackgroundColor: cBlackAnthraciteDark,
//           fontFamily: ffPrimary,
//         ).copyWith(
//           floatingActionButtonTheme: const FloatingActionButtonThemeData(
//               backgroundColor: cWhite, splashColor: cBlackAnthracite),
//           inputDecorationTheme: InputDecorationTheme(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(18),
//             ),
//           ),
//         ),
//         child: AnnotatedRegion<SystemUiOverlayStyle>(
//           // Use [SystemUiOverlayStyle.light] for white status bar
//           // or [SystemUiOverlayStyle.dark] for black status bar
//           value: SystemUiOverlayStyle.light,
//           child: child,
//         ));
//   }
//
//   MaterialStateProperty<Color> elevatedButtonWhite() =>
//       MaterialStateProperty.resolveWith<Color>((states) {
//         if (states.contains(MaterialState.focused)) {
//           return cBlueAccent;
//         }
//         if (states.contains(MaterialState.hovered)) {
//           return cBlueAccent;
//         }
//         if (states.contains(MaterialState.pressed)) {
//           return cBlueAccent;
//         }
//         return cWhite;
//       });
//
//   @override
//   Theme light({required Widget child}) {
//     // TODO: implement light
//     throw UnimplementedError();
//   }
// }
//
// extension ColorSchemeX on ColorScheme {
//   Color get primaryColor =>
//       brightness != Brightness.light ? cBlackAnthracite : cWhite;
//
//   Color get secondaryColor => brightness != Brightness.light ? cWhite : cBlack;
//
//   Color get primaryColorDarker =>
//       brightness != Brightness.light ? cBlackAnthraciteDarker : cWhite;
//
//   Color get shadowDarkColorDeepness1 =>
//       brightness != Brightness.light ? cBlack : cWhite;
//
//   Color get shadowLightColorDeepness1 =>
//       brightness != Brightness.light ? cBlack : cWhite;
//
//   Color get shadowDarkColorDeepness2 =>
//       brightness != Brightness.light ? cBlackAnthraciteDarker : cWhite;
//
//   Color get shadowLightColorDeepness2 =>
//       brightness != Brightness.light ? cBlackAnthraciteDarker : cWhite;
//
//   Color get shadowDarkColorDeepness3 =>
//       brightness != Brightness.light ? cBlackAnthraciteDark : cWhite;
//
//   Color get shadowLightColorDeepness3 =>
//       brightness != Brightness.light ? cBlackAnthraciteDark : cWhite;
//
//   Color get shadowDarkColorDeepness4 =>
//       brightness != Brightness.light ? cBlackAnthracite : cWhite;
//
//   Color get shadowLightColorDeepness4 =>
//       brightness != Brightness.light ? cBlackAnthracite : cWhite;
//
//   Color get shadowDarkColorDeepness5 =>
//       brightness != Brightness.light ? cBlackAnthraciteLight : cWhite;
//
//   Color get shadowLightColorDeepness5 =>
//       brightness != Brightness.light ? cBlackAnthraciteLight : cWhite;
//
// }