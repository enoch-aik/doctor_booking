import 'package:doctor_booking_flutter/lib.dart';
import 'package:lottie/lottie.dart';

/// Modified version of https://github.com/spporan/FlutterOverlayLoader/blob/master/lib/flutter_overlay_loader.dart

class Loader {
  static void show(BuildContext context) => showLoadingDialog(context);

  static void hide(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pop();

  static Widget get progressIndicator => Lottie.asset(
        'loading',
        height: 160.h,
        frameRate: FrameRate.max,
        repeat: true,
        errorBuilder: (context, e, _) => const CircularProgressIndicator(),
      );
}

/*
class Loader extends StatelessWidget {
  static OverlayEntry? _currentLoader;

  const Loader._(this._progressIndicator, this._themeData);

  final Widget? _progressIndicator;
  final ThemeData? _themeData;
  static OverlayState? _overlayState;

  static bool get isLoading => _currentLoader != null;

  static void show(
    BuildContext context, {
    Widget? progressIndicator,
    ThemeData? themeData,
    Color? overlayColor,
  }) {
    _overlayState = Overlay.of(context);
    if (_currentLoader == null) {
      _currentLoader = OverlayEntry(
        builder: (context) => Stack(
          children: <Widget>[
            SafeArea(
              child: Container(
                color: overlayColor ?? const Color(0x99ffffff),
              ),
            ),
            Center(
              child: Loader._(
                progressIndicator,
                themeData,
              ),
            ),
          ],
        ),
      );
      try {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final loader = _currentLoader;
          if (loader == null) return;
          _overlayState?.insertAll([loader]);
        });
      } catch (e, s) {
        if (kDebugMode) {
          print(e);
          print(s);
        }
      }
    }
  }

  static void hide() {
    final loader = _currentLoader;
    if (loader != null) {
      try {
        loader.remove();
      } catch (e) {
        if (kDebugMode) print(e.toString());
      } finally {
        _currentLoader = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Center(
        child: Theme(
          data: _themeData ??
              Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      secondary: Colors.blue,
                    ),
              ),
          child: _progressIndicator ?? const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
*/
