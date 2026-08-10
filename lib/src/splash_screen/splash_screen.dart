import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/core/base/base_widget/base_stateful_widget.dart';
import 'package:flutter_riverpod_template/core/util/app_color.dart';
import 'package:flutter_riverpod_template/src/home/home_screen.dart';
import 'package:flutter_riverpod_template/src/splash_screen/view_model/splash_view_model.dart';
import 'package:flutter_riverpod_template/src/widget/grid_painter.dart';

class SplashScreen extends BaseStatefulWidget<SplashViewModel, SplashState> {
  const SplashScreen(super.vm, {super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BasePageState<SplashScreen> with SingleTickerProviderStateMixin {
  static const _duration = Duration(milliseconds: 2400);

  late final AnimationController _controller = AnimationController(vsync: this, duration: _duration)..forward();

  Animation<T> _interval<T>(Tween<T> t, double s, double e, [Curve c = Curves.easeOut,]) {
    return t.animate(CurvedAnimation(parent: _controller, curve: Interval(s, e, curve: c),));
  }

  late final bgFade = _interval(Tween(begin: 0.0, end: 1.0), 0, .3);
  late final bgScale = _interval(Tween(begin: 1.25, end: 1.0), 0, .3, Curves.easeOutCubic);
  late final logoScale = _interval(Tween(begin: 0.0, end: 1.0), .2, .6, Curves.elasticOut);
  late final logoFade = _interval(Tween(begin: 0.0, end: 1.0), .2, .45);
  late final textFade = _interval(Tween(begin: 0.0, end: 1.0), .5, .8);
  late final textSlide = _interval(Tween(begin: const Offset(0, .5), end: Offset.zero), .5, .8, Curves.easeOutCubic);

  @override
  Color? get backgroundColor => AppColor.green900;

  @override
  Widget buildView(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) => Stack(
        children: [
          _background,
          Column(
            children: [
              const Spacer(flex: 3),
              FadeTransition(
                opacity: logoFade,
                child: ScaleTransition(
                  scale: logoScale,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColor.green300,
                          AppColor.kPrimaryColor,
                          AppColor.green300,
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.green100,
                          blurRadius: 32,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text('🛍️', style: TextStyle(fontSize: 42)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              FadeTransition(
                opacity: textFade,
                child: SlideTransition(
                  position: textSlide,
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Colors.white, AppColor.green100],
                          ).createShader(bounds);
                        },
                        child: const Text(
                          'ShopVerse',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Shop Smarter. Live Better.',
                        style: TextStyle(
                          color: AppColor.green100,
                          fontSize: 14,
                          letterSpacing: .8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 42,
                  vertical: 60,
                ),
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    HomeScreen.routeName,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.green100,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: .5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _background {
    final size = MediaQuery.sizeOf(context);
    return Opacity(
      opacity: bgFade.value,
      child: Transform.scale(
        scale: bgScale.value,
        child: Stack(
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.2),
                  radius: 1.2,
                  colors: [
                    AppColor.kPrimaryColor,
                    AppColor.green800,
                    AppColor.green900,
                  ],
                  stops: [0, .5, 1],
                ),
              ),
            ),
            CustomPaint(size: size, painter: GridPainter()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
