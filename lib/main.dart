import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:quake_destroyer/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      routerDelegate: AppRouterDelegate.delegate,
      title: 'Quake Destroyer',
    );
  }
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        primarySwatch: const MaterialColor(0xff4A6FFF, {
          50: Color.fromRGBO(74, 111, 255, .1),
          100: Color.fromRGBO(74, 111, 255, .2),
          200: Color.fromRGBO(74, 111, 255, .3),
          300: Color.fromRGBO(74, 111, 255, .4),
          400: Color.fromRGBO(74, 111, 255, .5),
          500: Color.fromRGBO(74, 111, 255, .6),
          600: Color.fromRGBO(74, 111, 255, .7),
          700: Color.fromRGBO(74, 111, 255, .8),
          800: Color.fromRGBO(74, 111, 255, .9),
          900: Color.fromRGBO(74, 111, 255, 1),
        }),
        backgroundColor: Colors.white,
        accentColor: Colors.lightGreen,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                minimumSize: PropertyStateDef(const Size(80, 40)),
                elevation: PropertyStateDef(0.0, hovered: 3.0, pressed: 0.0, disabled: 0.0),
                backgroundColor: PropertyStateDef(AppColors.primaryBlue, disabled: AppColors.gray400),
                // overlayColor: PropertyStateDef(AppColors.brandBlue600, pressed: AppColors.blue1000),
                shape: PropertyStateDef(const StadiumBorder()),
                foregroundColor: PropertyStateDef(AppColors.white, disabled: AppColors.gray800),
                textStyle: PropertyStateDef(
                  const TextStyle(fontSize: 16),
                  disabled: const TextStyle(fontSize: 16),
                ))),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                minimumSize: PropertyStateDef(const Size(80, 40)),
                foregroundColor: PropertyStateDef(AppColors.primaryBlue, disabled: AppColors.gray800),
                shape: PropertyStateDef(const StadiumBorder()),
                textStyle: PropertyStateDef(
                  const TextStyle(
                    fontSize: 16,
                  ),
                  disabled: const TextStyle(fontSize: 16),
                ))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                minimumSize: PropertyStateDef(const Size(80, 40)),
                backgroundColor: PropertyStateDef(AppColors.white),
                side: MaterialStateProperty.all(const BorderSide(color: AppColors.primaryBlue, width: 2)),
                shape: PropertyStateDef(const StadiumBorder()),
                foregroundColor: PropertyStateDef(AppColors.primaryBlue, disabled: AppColors.gray800),
                textStyle: PropertyStateDef(
                  const TextStyle(fontSize: 16),
                  disabled: const TextStyle(fontSize: 16),
                ))),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        }),
      );
}

class PropertyStateDef<T> implements MaterialStateProperty<T?> {
  final T defaultState;
  final T? hovered;
  final T? focused;
  final T? pressed;
  final T? dragged;
  final T? selected;
  final T? disabled;
  final T? error;

  PropertyStateDef(this.defaultState,
      {this.hovered, this.focused, this.pressed, this.dragged, this.selected, this.disabled, this.error});

  @override
  T? resolve(Set<MaterialState> states) {
    if (pressed != null && states.contains(MaterialState.pressed)) return pressed;
    if (focused != null && states.contains(MaterialState.focused)) return focused;
    if (dragged != null && states.contains(MaterialState.dragged)) return dragged;
    if (disabled != null && states.contains(MaterialState.disabled)) return disabled;
    if (error != null && states.contains(MaterialState.error)) return error;
    if (hovered != null && states.contains(MaterialState.hovered)) return hovered;
    if (selected != null && states.contains(MaterialState.selected)) return selected;
    return defaultState;
  }
}

class AppColors {
  AppColors._();

  static const Color primaryYellow = Color.fromRGBO(255, 199, 94, 1);

  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color gray1000 = Color.fromRGBO(69, 71, 82, 1);
  static const Color gray800 = Color(0xff676A7A);
  static const Color gray600 = Color.fromRGBO(154, 159, 184, 1);
  static const Color gray500 = Color.fromRGBO(221, 221, 221, 1);
  static const Color gray400 = Color.fromRGBO(240, 241, 245, 1);
  static const Color gray200 = Color.fromRGBO(244, 245, 249, 1);
  static const Color gray100 = Color.fromRGBO(250, 251, 255, 1);
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color grayIcon = Color.fromRGBO(157, 161, 186, 1);
  static const Color grayDisabledShadow = Color.fromRGBO(154, 159, 184, 0.4);
  static const Color grayDisabledPrimary = Color.fromRGBO(233, 234, 238, 1.0);

  static const Color alphabetFirstGroupPrimary = Color.fromRGBO(255, 118, 118, 1);
  static const Color alphabetFirstGroupShadow = Color.fromRGBO(224, 66, 66, 1);
  static const Color alphabetFirstGroupBackground = Color.fromRGBO(255, 242, 243, 1);
  static const Color alphabetSecondGroupPrimary = Color.fromRGBO(255, 199, 93, 1);
  static const Color alphabetSecondGroupShadow = Color.fromRGBO(240, 145, 86, 1);
  static const Color alphabetSecondGroupBackground = Color.fromRGBO(255, 250, 242, 1);
  static const Color alphabetThirdGroupPrimary = Color.fromRGBO(114, 224, 176, 1);
  static const Color alphabetThirdGroupShadow = Color.fromRGBO(0, 153, 115, 1);
  static const Color alphabetThirdGroupBackground = Color.fromRGBO(239, 250, 248, 1);
  static const Color alphabetFourthGroupPrimary = Color.fromRGBO(70, 196, 242, 1);
  static const Color alphabetFourthGroupShadow = Color.fromRGBO(5, 164, 210, 1);
  static const Color alphabetFourthGroupBackground = Color.fromRGBO(240, 250, 253, 1);

  static const List<Color> soundGroupColors = [
    Color(0xffFF7676),
    Color(0xffC576e2),
    Color(0xff46c4f2),
    Color(0xff61cf9f),
    Color(0xffff7fa3),
    Color(0xffFFA35F),
    Color(0xffc58361),
  ];

  static const List<Color> secondaryColors = [
    Color(0xFFFF6464),
    Color(0xFFFFC75E),
    Color(0xFFFF7FA3),
    Color(0xFFC576E2),
    Color(0xFF46C4F2),
    Color(0xFF61CF9F),
  ];

  static Color soundGroupColorForIndex(int index) => soundGroupColors[index % soundGroupColors.length];

  static const Color brandBlue100 = Color.fromRGBO(241, 244, 255, 1);
  static const Color yellow100 = Color.fromRGBO(255, 250, 242, 1);
  static const Color orange100 = Color.fromRGBO(255, 250, 240, 1);
  static const Color brown100 = Color.fromRGBO(251, 245, 243, 1);
  static const Color red100 = Color.fromRGBO(255, 243, 243, 1);
  static const Color pink100 = Color.fromRGBO(255, 245, 248, 1);
  static const Color purple100 = Color.fromRGBO(252, 246, 254, 1);
  static const Color blue100 = Color(0xffF1F4FF);
  static const Color turquoise100 = Color.fromRGBO(238, 251, 251, 1);
  static const Color green100 = Color.fromRGBO(239, 250, 248, 1);

  static const Color brandBlue200 = Color.fromRGBO(212, 221, 255, 1);
  static const Color yellow200 = Color.fromRGBO(255, 244, 225, 1);
  static const Color orange200 = Color.fromRGBO(255, 242, 217, 1);
  static const Color brown200 = Color.fromRGBO(241, 226, 217, 1);
  static const Color red200 = Color.fromRGBO(255, 218, 218, 1);
  static const Color pink200 = Color.fromRGBO(255, 224, 233, 1);
  static const Color purple200 = Color.fromRGBO(245, 226, 251, 1);
  static const Color blue200 = Color.fromRGBO(211, 241, 252, 1);
  static const Color turquoise200 = Color.fromRGBO(201, 241, 243, 1);
  static const Color green200 = Color.fromRGBO(217, 243, 232, 1);

  static const Color brandBlue300 = Color.fromRGBO(96, 134, 249, 1);
  static const Color yellow300 = Color.fromRGBO(255, 204, 115, 1);
  static const Color orange300 = Color.fromRGBO(255, 178, 115, 1);
  static const Color brown300 = Color.fromRGBO(209, 139, 102, 1);
  static const Color red300 = Color.fromRGBO(255, 140, 140, 1);
  static const Color pink300 = Color.fromRGBO(255, 156, 192, 1);
  static const Color purple300 = Color.fromRGBO(211, 135, 238, 1);
  static const Color blue300 = Color.fromRGBO(95, 207, 248, 1);
  static const Color turquoise300 = Color.fromRGBO(77, 210, 214, 1);
  static const Color green300 = Color.fromRGBO(114, 224, 176, 1);

  static const Color brandBlue400 = Color.fromRGBO(74, 111, 255, 1);
  static const Color yellow400 = Color.fromRGBO(255, 199, 94, 1);
  static const Color orange400 = Color.fromRGBO(255, 163, 95, 1);
  static const Color brown400 = Color.fromRGBO(197, 131, 97, 1);
  static const Color red400 = Color.fromRGBO(255, 118, 118, 1);
  static const Color pink400 = Color.fromRGBO(255, 127, 163, 1);
  static const Color purple400 = Color.fromRGBO(197, 118, 226, 1);
  static const Color blue400 = Color.fromRGBO(70, 196, 242, 1);
  static const Color turquoise400 = Color.fromRGBO(31, 199, 204, 1);
  static const Color green400 = Color.fromRGBO(97, 207, 159, 1);

  static const Color brandBlue500 = Color.fromRGBO(68, 102, 255, 1);
  static const Color yellow500 = Color.fromRGBO(255, 190, 79, 1);
  static const Color orange500 = Color.fromRGBO(255, 148, 79, 1);
  static const Color brown500 = Color.fromRGBO(187, 121, 88, 1);
  static const Color red500 = Color.fromRGBO(255, 100, 100, 1);
  static const Color pink500 = Color.fromRGBO(255, 106, 148, 1);
  static const Color purple500 = Color.fromRGBO(195, 105, 227, 1);
  static const Color blue500 = Color.fromRGBO(0, 183, 236, 1);
  static const Color turquoise500 = Color.fromRGBO(26, 189, 195, 1);
  static const Color green500 = Color.fromRGBO(59, 197, 151, 1);

  static const Color brandBlue600 = Color.fromRGBO(49, 73, 224, 1);
  static const Color yellow600 = Color.fromRGBO(240, 145, 86, 1);
  static const Color orange600 = Color.fromRGBO(218, 125, 71, 1);
  static const Color brown600 = Color.fromRGBO(174, 111, 79, 1);
  static const Color red600 = Color.fromRGBO(224, 66, 66, 1);
  static const Color pink600 = Color.fromRGBO(224, 84, 122, 1);
  static const Color purple600 = Color.fromRGBO(174, 84, 206, 1);
  static const Color blue600 = Color.fromRGBO(5, 164, 210, 1);
  static const Color turquoise600 = Color.fromRGBO(20, 162, 167, 1);
  static const Color green600 = Color.fromRGBO(0, 153, 115, 1);

  static const Color brandBlue700 = Color.fromRGBO(32, 46, 149, 1);
  static const Color yellow700 = Color.fromRGBO(205, 113, 61, 1);
  static const Color orange700 = Color.fromRGBO(176, 99, 54, 1);
  static const Color brown700 = Color.fromRGBO(129, 80, 55, 1);
  static const Color red700 = Color.fromRGBO(194, 50, 50, 1);
  static const Color pink700 = Color.fromRGBO(174, 63, 105, 1);
  static const Color purple700 = Color.fromRGBO(142, 64, 170, 1);
  static const Color blue700 = Color.fromRGBO(1, 110, 178, 1);
  static const Color turquoise700 = Color.fromRGBO(13, 114, 118, 1);
  static const Color green700 = Color.fromRGBO(0, 124, 114, 1);

  static const Color primaryBlue = brandBlue400;
  static const Color successGreen = Color.fromRGBO(75, 181, 67, 1);
  static const Color midGreen = Color.fromRGBO(157, 225, 196, 1);
  static const Color green1000 = Color.fromRGBO(37, 154, 116, 1);
}
