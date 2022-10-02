import 'package:flutter/material.dart';
import 'package:quake_destroyer/app_routes.dart';

import 'main.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: AppColors.yellow200,
      body: Stack(
        children: [
          Align(
              alignment: const Alignment(0, 0.82),
              child: Transform.scale(
                scale: 2,
                child: Image.asset(
                  "assets/images/ruins.png",
                  fit: BoxFit.fitWidth,
                ),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.scale(scale: 0.8, child: Image.asset("assets/images/bricks.png")),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.alphabetThirdGroupShadow.withOpacity(0.7),
                  ),
                  onPressed: () => context.beamToReplacementPage(AppRoutes.earthquakeData),
                  child: const Text(
                    "View earthquake data",
                    style: TextStyle(color: AppColors.white, fontSize: 22),
                  )),
              const SizedBox(
                height: 22,
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.alphabetThirdGroupShadow.withOpacity(0.7),
                  ),
                  onPressed: () => context.beamToPage(AppRoutes.magnitudeTest),
                  child: const Text(
                    "Measure my earthquake",
                    style: TextStyle(color: AppColors.white, fontSize: 22),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

AppBar buildAppBar({String title = "Quake Destroyer"}) {
  return AppBar(
    backgroundColor: AppColors.alphabetThirdGroupShadow,
    title: Text(
      title,
      style: TextStyle(color: AppColors.brown200),
    ),
  );
}
