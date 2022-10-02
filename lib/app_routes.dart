import 'package:beamer/beamer.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:quake_destroyer/magnitude_result_widget.dart';
import 'package:quake_destroyer/magnitude_test_widget.dart';

import 'earthquake_data_widget.dart';
import 'earthquake_details_widget.dart';
import 'home_widget.dart';

class AppRouterDelegate {
  static BeamerDelegate delegate = BeamerDelegate(
    notFoundPage: const BeamPage(
        child: Scaffold(
            body: Center(
      child: Text("Not found"),
    ))),
    initialPath: "/",
    locationBuilder: RoutesLocationBuilder(
      routes: <PageConfig>[
        AppRoutes.home,
        AppRoutes.magnitudeTest,
        AppRoutes.magnitudeResult,
        AppRoutes.earthquakeData,
        AppRoutes.earthquakeDetails,
      ].associate((element) => MapEntry(element.path, element.page)),
    ),
  );
}

class AppRoutes {
  static final home = PageConfig(
    '/',
    (context, state, data) => const BeamPage(
      title: "Home",
      key: ValueKey("home"),
      child: HomeWidget(),
    ),
  );
  static final magnitudeTest = PageConfig(
    '/magnitude_test',
    (context, state, data) => const BeamPage(
      title: "Magnitude Test",
      key: ValueKey("magnitude_test"),
      child: MagnitudeTestWidget(),
    ),
  );
  static final magnitudeResult = PageConfig(
    '/magnitude_result',
    (context, state, data) => const BeamPage(
      title: "Magnitude Result",
      key: ValueKey("magnitude_result"),
      child: MagnitudeResultWidget(),
    ),
  );
  static final earthquakeData = PageConfig(
    '/earthquake_data',
    (context, state, data) => const BeamPage(
      title: "Earthquake Data",
      key: ValueKey("earthquake_data"),
      child: EarthquakeDataWidget(),
    ),
  );
  static final earthquakeDetails = PageConfig(
    '/earthquake_details',
    (context, state, data) => const BeamPage(
      title: "Earthquake Details",
      key: ValueKey("earthquake_details"),
      child: EarthquakeDetailsWidget(),
    ),
  );
}

class PageConfig {
  final String path;
  final BeamPage Function(BuildContext, BeamState, Object?) page;

  PageConfig(this.path, this.page);
}

extension BeamToConfig on BuildContext {
  void beamToPage(PageConfig page, {Object? data}) => beamToNamed(page.path, data: data);

  void beamToReplacementPage(PageConfig page, {Object? data}) => beamToReplacementNamed(page.path, data: data);
}
