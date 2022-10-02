import 'dart:math';

import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:quake_destroyer/app_routes.dart';
import 'package:quake_destroyer/home_widget.dart';
import 'package:quake_destroyer/main.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnitudeTestWidget extends StatefulWidget {
  const MagnitudeTestWidget({super.key});

  @override
  State<MagnitudeTestWidget> createState() => _MagnitudeTestWidgetState();
}

class _MagnitudeTestWidgetState extends State<MagnitudeTestWidget> {
  bool testing = false;

  double currentMagnitude = 00.00;
  double accelerometerMagnitude = 00.00;
  double gyroscopeMagnitude = 00.00;
  double maxMagnitude = 00.00;

  @override
  void initState() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (testing) {
        setState(() {
          accelerometerMagnitude = getMagnitude(x: event.x, y: event.y, z: event.z);
          if (accelerometerMagnitude > gyroscopeMagnitude) currentMagnitude = accelerometerMagnitude;
          if (currentMagnitude > maxMagnitude) currentMagnitude = maxMagnitude;
        });
      }
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (testing) {
        setState(() {
          gyroscopeMagnitude = getMagnitude(x: event.x, y: event.y, z: event.z);
          if (gyroscopeMagnitude > accelerometerMagnitude) currentMagnitude = gyroscopeMagnitude;
          if (currentMagnitude > maxMagnitude) maxMagnitude = currentMagnitude;
        });
      }
    });
    super.initState();
  }

  double getMagnitude({required double x, required double y, required double z}) {
    var currentMaxVal = ([x.abs(), y.abs(), z.abs()].reduce((value, element) => value > element ? value : element));

    return log(currentMaxVal * (currentMaxVal * 0.3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: getShowingWidget(),
          )),
    );
  }

  @override
  void dispose() {
    setState(() {
      testing = false;
    });
    super.dispose();
  }

  Widget getShowingWidget() {
    return testing
        ? Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              "$maxMagnitude".characters.getRange(0, 4).toString(),
              style: const TextStyle(fontSize: 65),
            ),
            TextButton(
                onPressed: () {
                  maxMagnitude;
                  context.beamToReplacementPage(AppRoutes.magnitudeResult, data: maxMagnitude);
                },
                child: const Text("End earthquake"))
          ])
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/seismographic.png",
                fit: BoxFit.fitWidth,
              ),
              AnimatedButton(
                  duration: 70,
                  height: 100,
                  width: 200,
                  enabled: true,
                  shadowDegree: ShadowDegree.dark,
                  color: AppColors.red600,
                  onPressed: () {
                    setState(() {
                      testing = true;
                    });
                  },
                  child: const Text(
                    "Start Measuring",
                    style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 22),
                  )),
            ],
          );
  }
}
