import 'package:flutter/material.dart';

class WeatherIcons extends StatelessWidget {
  const WeatherIcons({
    super.key,
    required this.code,
  });

  final int code;

  @override
  Widget build(BuildContext context) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/image/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/image/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/image/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/image/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/image/5.png');
      case == 800:
        return Image.asset('assets/image/s.png');
      case > 800 && <= 804:
        return Image.asset('assets/image/suncloud.png');
      default:
        return Image.asset('assets/image/suncloud.png');
    }
  }
}