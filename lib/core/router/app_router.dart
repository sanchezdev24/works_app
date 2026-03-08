import 'package:go_router/go_router.dart';
import 'package:works_app/features/dashboard/presentation/pages/dashboard_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
}
