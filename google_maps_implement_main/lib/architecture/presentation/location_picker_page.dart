import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_maps_implement/architecture/presentation/platform/android_ui.dart';
import 'package:google_maps_implement/architecture/presentation/platform/ios_ui.dart';

import 'platform/desktop_ui.dart';
import 'platform/web_ui.dart';

class LocationPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPlatformUI(),
    );
  }

  Widget _buildPlatformUI() {
    if (kIsWeb) {
      return WebUI();
    } else if (Platform.isAndroid ) {
      return AndroidUI();
    } else if(Platform.isIOS){
      return IosUI();
    } else if (Platform.isFuchsia ||
        Platform.isLinux ||
        Platform.isWindows ||
        Platform.isMacOS) {
      return DesktopUI();
    } else {
      return const Center(
        child: Text('Not available, please contact support.'),
      );
    }
  }
}

