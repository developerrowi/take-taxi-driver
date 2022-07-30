import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class MarkerCreate {
  Future<Object> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    var finalData = await fi.image.toByteData(format: ui.ImageByteFormat.png);

    if (finalData != null) {
      return finalData.buffer.asUint8List();
    } else {
      return Object();
    }
  }
}
