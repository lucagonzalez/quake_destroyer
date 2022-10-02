import 'package:beamer/beamer.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:quake_destroyer/home_widget.dart';
import 'package:timelines/timelines.dart';

import 'main.dart';

class MagnitudeResultWidget extends StatefulWidget {
  const MagnitudeResultWidget({Key? key}) : super(key: key);

  @override
  State<MagnitudeResultWidget> createState() => _MagnitudeResultWidgetState();
}

class _MagnitudeResultWidgetState extends State<MagnitudeResultWidget> {
  String userMagnitude = "";
  late List<EarthquakeData> earthquakes;

  @override
  void initState() {
    earthquakes = [
      EarthquakeData(1, "Equivalent of an explosion on a construction site", ""),
      EarthquakeData(2, "Equivalent of a 15Kg Butane gas cylinder explosion", ""),
      EarthquakeData(3, "Equivalent of an industrial plant explosion", ""),
      EarthquakeData(4, "Equivalent of a tiny atomic bomb", ""),
      EarthquakeData(
        5,
        "Afghanistan 2022",
        "An earthquake measuring Mw 4.9, followed by a 5.3 Mw mainshock struck Badghis Province, Afghanistan, on January 17, 2022. The earthquake led to a large number of casualties for the tremor's magnitude, with 30 dead and 49 injured. The earthquake destroyed hundreds of homes in northwestern Afghanistan.",
      ),
      EarthquakeData(
        6,
        "Hormozgan 2022",
        "The 2022 Hormozgan earthquakes were a pair of doublet earthquakes that struck southern Iran on 1 July, 2022. The earthquakes, which occurred around two hours apart, killed seven people and injured dozens more.",
      ),
      EarthquakeData(
        7,
        "Luzon, 2022",
        "On July 27, 2022, at 8:43:24 a.m. (PHT), an earthquake struck the island of Luzon in the Philippines. The earthquake had a magnitude of 7.0 Mw, with an epicenter in Abra province. Eleven people were reported dead and 615 were injured. At least 35,798 homes, schools and other buildings were damaged or destroyed, resulting in ₱1.88 billion (US\$34 million) worth of damage.",
      ),
      EarthquakeData(
        8,
        "Chignik, 2021",
        "An earthquake occurred off the coast of the Alaska Peninsula on July 28, 2021, at 10:15 p.m. local time. The large megathrust earthquake had a moment magnitude (Mw) of 8.2 according to the United States Geological Survey (USGS). A tsunami warning was issued by the National Oceanic and Atmospheric Administration (NOAA) but later cancelled. The mainshock was followed by a number of aftershocks, including three that were of magnitude 5.9, 6.1 and 6.9 respectively.",
      ),
      EarthquakeData(
        9,
        "Alaska, 1964",
        "The 1964 Alaskan earthquake, also known as the Great Alaskan earthquake and Good Friday earthquake, occurred at 5:36 PM AKST on Good Friday, March 27. Across south-central Alaska, ground fissures, collapsing structures, and tsunamis resulting from the earthquake caused about 131 deaths.",
      ),
      EarthquakeData(
        10,
        "1815 eruption of Mount Tambora",
        "Mount Tambora is a volcano on the island of Sumbawa in present-day Indonesia, then part of the Dutch East Indies, and its 1815 eruption was the most powerful volcanic eruption in recorded human history. This Volcanic Explosivity Index (VEI) 7 eruption ejected 160–213 cubic kilometres (38–51 cu mi) of material into the atmosphere,and was the most recent confirmed VEI-7 eruption.",
      ),
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      userMagnitude = "${context.currentBeamLocation.data}".substring(0, 3);
    });
    earthquakes.add(EarthquakeData(
        userMagnitude.characters.first.toInt(), "User Generated", "Created on this session by the user"));
    earthquakes.sort((a, b) => a.magnitude.compareTo(b.magnitude));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Timeline.tileBuilder(
          builder: TimelineTileBuilder.fromStyle(
        contentsAlign: ContentsAlign.alternating,
        contentsBuilder: (context, index) => Card(
          color: getColor(earthquakes[index]),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    earthquakes[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.gray1000),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    earthquakes[index].subtitle,
                    style: TextStyle(color: AppColors.gray1000),
                  ),
                ),
              ],
            ),
          ),
        ),
        itemCount: 10,
      )),
    );
  }

  Color getColor(EarthquakeData e) {
    var mag = e.magnitude.toDouble();
    if (mag >= 3 && mag < 4) {
      return AppColors.yellow200;
    } else if (mag >= 4 && mag < 7) {
      return AppColors.orange200;
    } else if (mag >= 7) {
      return AppColors.red200;
    } else {
      return AppColors.green200;
    }
  }
}

class EarthquakeCards {
  final String text;
  final String? image;

  EarthquakeCards(this.text, this.image);
}

class EarthquakeData {
  final int magnitude;
  final String text;
  final String subtitle;

  EarthquakeData(this.magnitude, this.text, this.subtitle);
}
