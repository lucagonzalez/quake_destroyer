import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geojson/geojson.dart';
import 'package:latlong2/latlong.dart';
import 'package:quake_destroyer/app_routes.dart';
import 'package:quake_destroyer/home_widget.dart';
import 'package:quake_destroyer/main.dart';

class EarthquakeDataWidget extends StatefulWidget {
  const EarthquakeDataWidget({Key? key}) : super(key: key);

  @override
  State<EarthquakeDataWidget> createState() => _EarthquakeDataWidgetState();
}

class _EarthquakeDataWidgetState extends State<EarthquakeDataWidget> {
  final points = <Earthquake>[];

  @override
  void initState() {
    parseAndDrawAssetsOnMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "Data viewer"),
      body: SizedBox(
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(51.509364, -0.128928),
                zoom: 2.5,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(
                  markers: points
                      .map((e) => Marker(
                            point: e.point,
                            width: 80,
                            height: 80,
                            builder: (BuildContext context) {
                              return IconButton(
                                icon: const Icon(
                                  Icons.location_on_outlined,
                                ),
                                color: getPointColor(e),
                                onPressed: () {
                                  context.beamToReplacementPage(AppRoutes.earthquakeDetails, data: e);
                                },
                              );
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> parseAndDrawAssetsOnMap() async {
    final geo = GeoJson();
    final data = await rootBundle.loadString('assets/data/seismos.geojson');
    final geoJsonCollection = await featuresFromGeoJson(data);

    geo.processedPoints.listen((GeoJsonPoint point) {
      final collectionElement = geoJsonCollection.collection.firstWhere((element) =>
          (element.geometry as GeoJsonPoint).geoPoint.longitude == point.geoPoint.longitude &&
          (element.geometry as GeoJsonPoint).geoPoint.latitude == point.geoPoint.latitude);

      final properties = collectionElement.properties;

      setState(() {
        points.add(Earthquake(
            point: LatLng(point.geoPoint.latitude, point.geoPoint.longitude),
            title: properties?["title"].toString() ?? "",
            magnitude: properties?["mag"].toString() ?? "",
            tsunami: properties?["tsunami"].toString() ?? "",
            url: properties?["url"].toString() ?? "",
            time: properties?["time"].toString() ?? ""));
      });
    });

    geo.endSignal.listen((_) => geo.dispose());

    await geo.parse(data);
  }

  Color getPointColor(Earthquake e) {
    var mag = e.magnitude.toDouble();
    if (mag >= 3 && mag < 4) {
      return AppColors.yellow300;
    } else if (mag >= 4 && mag < 7) {
      return AppColors.orange300;
    } else if (mag >= 7) {
      return AppColors.red300;
    } else {
      return AppColors.green300;
    }
  }
}

class Earthquake {
  final LatLng point;
  final String title; //properties[title]
  final String magnitude; //properties[mag]
  final String tsunami; //properties[tsunami]
  final String time; //properties[time]
  final String url; //properties[url]

  Earthquake(
      {required this.point,
      required this.url,
      required this.title,
      required this.magnitude,
      required this.tsunami,
      required this.time});
}
