import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/bloc/weather/weather_bloc.dart';
import 'package:weatherapp/screen/home/widgets.dart/custom_stack.dart';
import 'package:weatherapp/screen/home/widgets.dart/cutom_appbar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 202, 236),
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size(100, 100),
        child: Custom_appbar(),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kTextTabBarHeight, 40, 20),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherSuccess) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child:  CustomStack( state: state),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

