part of 'utils.dart';

class ThemeUtils {
  ThemeUtils._();

  static bool  get dark => (MediaQuery.of(navigatorKey.currentContext!).platformBrightness == Brightness.dark);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      hintColor: AppColors.darkGrey.withOpacity(0.5),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.1),
      unselectedWidgetColor: Colors.grey.shade400,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.secondary,
        selectionColor: AppColors.secondary.withOpacity(0.1),
        selectionHandleColor: AppColors.secondary,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: generateMaterialColor(AppColors.primary))
          .copyWith(secondary: AppColors.secondary),
    );
  }
}
