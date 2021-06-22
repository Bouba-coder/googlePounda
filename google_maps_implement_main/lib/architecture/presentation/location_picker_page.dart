import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_implement/architecture/presentation/platform/desktop.dart';
import 'package:google_maps_implement/architecture/presentation/platform/mobile.dart';
import 'package:google_maps_implement/architecture/presentation/platform/web.dart';

class LocationPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPlatformUI(),
    );
  }

  Widget _buildPlatformUI() {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      return Web();
    } else if (Platform.isAndroid || Platform.isIOS) {
      return Mobile();
    } else if (Platform.isFuchsia || Platform.isLinux || Platform.isWindows) {
      return Desktop();
    } else {
      return Center(
        child: Text('Not available, please contact support.'),
      );
    }
  }
}
