import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:quake_destroyer/earthquake_data_widget.dart';
import 'package:quake_destroyer/home_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EarthquakeDetailsWidget extends StatefulWidget {
  const EarthquakeDetailsWidget({Key? key}) : super(key: key);

  @override
  State<EarthquakeDetailsWidget> createState() => _EarthquakeDetailsWidgetState();
}

class _EarthquakeDetailsWidgetState extends State<EarthquakeDetailsWidget> {
  late Earthquake e;

  @override
  void didChangeDependencies() {
    e = context.currentBeamLocation.data as Earthquake;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: WebView(
        initialUrl: e.url,
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
      ),
    );
  }
}
