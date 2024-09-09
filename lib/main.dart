import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weatherapp/bloc/weather/weather_bloc.dart';
import 'package:weatherapp/screen/home/screen/homescreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(0, 166, 209, 233),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Position>(
        future: _determinePosition(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return  Center(child:LoadingAnimationWidget.staggeredDotsWave(color:Colors.blue , size: 50));
          } else if (snap.hasError) {
            // Handle error when location services are unavailable
            return Center(
              child: Text(
                'Error: ${snap.error}. Please enable location services and restart the app.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snap.hasData) {
            print('Position obtained: ${snap.data}');
            return BlocProvider(
              create: (context) =>
                  WeatherBloc()..add(FetchWeather(snap.data!)),
              child: const HomeScreen(),
            );
          } else {
            // Handle any unexpected case
            return const Center(
              child: Text('Unexpected error occurred.'),
            );
          }
        },
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}