// import 'package:flutter/material.dart';
// //import 'file:///C:/Users/bouba/OneDrive/Bureau/flutterProject/google_maps_implement/lib/rabe/place_service.dart';
// import 'package:google_maps_implement/uiClass/addressSearch.dart';
// import 'package:uuid/uuid.dart';
//
// import 'place_service.dart';
//
// class GoogleApi extends StatefulWidget {
//   @override
//   _GoogleApiState createState() => _GoogleApiState();
// }
//
// class _GoogleApiState extends State<GoogleApi> {
//   final _destinationController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBar(),
//       body: Container(),
//     );
//   }
//
//   //appbar widget function + search bar
//   PreferredSizeWidget _appBar() {
//     return AppBar(
//       title: Text("Enter your address"),
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () {},
//       ),
//       bottom: PreferredSize(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//           child: Column(
//             children: [
//               //champs
//               AddressInput(
//                 iconData: Icons.gps_fixed,
//                 hinText: "depa",
//                 enabled: false,
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//               Row(
//                 children: [
//                   AddressInput(
//                     controller: _destinationController,
//                     iconData: Icons.place_sharp,
//                     hinText: "arriver",
//                     onTap: () async {
//                       final sessionToken = Uuid().v4();
//                       final Suggestion result = (await showSearch(
//                           context: context,
//                           delegate: AddressSearch(sessionToken)
//                       ))!;
//                       if(result.description != null) {
//                         setState(() {
//                           _destinationController.text = result.description;
//                           print("test");
//                           print(result);
//                           print(AddressSearch(sessionToken));
//                         });
//                       }
//                     },
//                   ),
//                   InkWell(
//                     child: Icon(
//                       Icons.add,
//                       color: Colors.black,
//                       size: 18,
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//         preferredSize: Size.fromHeight(100.0),
//       ),
//     );
//   }
// }
//
// //address search
// class AddressInput extends StatelessWidget {
// //variables...
//   final IconData? iconData;
//   final TextEditingController? controller;
//   final String? hinText;
//   final Function()? onTap;
//   final bool? enabled;
//
// //constructor
//   const AddressInput(
//       {Key? key,
//       this.iconData,
//       this.controller,
//       this.hinText,
//       this.onTap,
//       this.enabled})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         //icon
//         Icon(
//           this.iconData,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Container(
//             height: 40.0,
//             width: MediaQuery.of(context).size.width / 1.4,
//             alignment: Alignment.center,
//             padding: EdgeInsets.only(left: 10.0),
//             child: TextField(
//               controller: controller,
//               onTap: onTap!,
//               enabled: enabled,
//               decoration: InputDecoration(
//                 hintText: hinText,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
