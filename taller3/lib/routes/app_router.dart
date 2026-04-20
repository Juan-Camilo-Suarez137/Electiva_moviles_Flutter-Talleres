import 'package:go_router/go_router.dart';
import '../views/dashboard_view.dart';
import '../views/list_view.dart';
import '../views/detail_view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: '/list/:type',
      builder: (context, state) {
        final type = state.pathParameters['type']!;
        return ListViewPage(category: type);
      },
    ),
    GoRoute(
      path: '/detail/:type/:id',
      builder: (context, state) {
        final type = state.pathParameters['type']!;
        final id = state.pathParameters['id']!;
        return DetailView(category: type, id: id);
      },
    ),
  ],
);