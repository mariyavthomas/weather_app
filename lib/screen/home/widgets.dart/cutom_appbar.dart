import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types
class Custom_appbar extends StatelessWidget {
  const Custom_appbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    );
  }
}

