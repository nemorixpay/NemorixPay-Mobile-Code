import 'package:go_router/go_router.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/splash/ui/pages/splash_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: RouteNames.splash,
      path: "/",
      builder: (context, state) => const SplashPage(),
    ),
  ],
);
