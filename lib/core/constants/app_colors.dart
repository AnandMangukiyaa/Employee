part of 'constants.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xff1DA1F2);

  static const Color backgroundColor = Colors.white;

  static const Color darkGrey = Color(0xff828382);
  static const Color border = Color(0xffe5e5e5);

  static const Color secondary = Color(0xff5dbcf6);
  static const Color secondaryButton = Color(0xffEDF8FF);

}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: color,
    100: color,
    200: color,
    300: color,
    400: color,
    500: color,
    600: color,
    700: color,
    800: color,
    900: color,
  });
}
