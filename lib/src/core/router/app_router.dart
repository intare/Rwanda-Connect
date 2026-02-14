import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/auth_state.dart';
import '../../presentation/features/auth/providers/auth_provider.dart';
import '../../presentation/features/auth/screens/login_screen.dart';
import '../../presentation/features/auth/screens/register_screen.dart';
import '../../presentation/features/auth/screens/onboarding_screen.dart';
import '../../presentation/features/home/screens/home_screen.dart';
import '../../presentation/features/home/screens/news_detail_screen.dart';
import '../../domain/entities/news.dart';
import '../../presentation/features/opportunities/screens/opportunities_screen.dart';
import '../../presentation/features/opportunities/screens/opportunity_detail_screen.dart';
import '../../presentation/features/events/screens/events_screen.dart';
import '../../presentation/features/events/screens/event_detail_screen.dart';
import '../../presentation/features/community/screens/community_screen.dart';
import '../../presentation/features/profile/screens/profile_screen.dart';
import '../theme/theme.dart';
import 'app_shell.dart';
import 'splash_screen.dart';

/// Route paths
abstract final class AppRoutes {
  // Auth routes
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';

  // Main tab routes
  static const String home = '/home';
  static const String opportunities = '/opportunities';
  static const String events = '/events';
  static const String community = '/community';
  static const String profile = '/profile';

  // Detail routes
  static const String newsDetail = '/news/:id';
  static const String opportunityDetail = '/opportunities/:id';
  static const String eventDetail = '/events/:id';

  /// Routes that don't require authentication.
  static const List<String> publicRoutes = [
    splash,
    login,
    register,
  ];

  /// Check if a route requires authentication.
  static bool requiresAuth(String location) {
    return !publicRoutes.any((route) => location.startsWith(route));
  }
}

/// Navigation shell key for bottom navigation
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// GoRouter configuration provider
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(ref, authProvider),
    redirect: (context, state) {
      final location = state.uri.path;
      final isAuthenticated = authState.isAuthenticated;
      final isInitial = authState is AuthStateInitial;
      final isLoading = authState is AuthStateLoading;

      // Show splash while checking auth status
      if (isInitial || isLoading) {
        if (location != AppRoutes.splash) {
          return AppRoutes.splash;
        }
        return null;
      }

      // If on splash and auth check is done, redirect appropriately
      if (location == AppRoutes.splash) {
        return isAuthenticated ? AppRoutes.home : AppRoutes.login;
      }

      // If not authenticated and trying to access protected route
      if (!isAuthenticated && AppRoutes.requiresAuth(location)) {
        return AppRoutes.login;
      }

      // If authenticated and trying to access auth routes (login/register)
      if (isAuthenticated &&
          (location == AppRoutes.login || location == AppRoutes.register)) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      // Splash screen
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth routes (outside shell)
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Main app shell with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.opportunities,
            name: 'opportunities',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: OpportunitiesScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.events,
            name: 'events',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.community,
            name: 'community',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CommunityScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),

      // Detail routes (outside shell for proper back navigation)
      GoRoute(
        path: AppRoutes.newsDetail,
        name: 'newsDetail',
        builder: (context, state) {
          final news = state.extra as News;
          return NewsDetailScreen(news: news);
        },
      ),
      GoRoute(
        path: AppRoutes.opportunityDetail,
        name: 'opportunityDetail',
        builder: (context, state) => OpportunityDetailScreen(
          opportunityId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.eventDetail,
        name: 'eventDetail',
        builder: (context, state) => EventDetailScreen(
          eventId: state.pathParameters['id']!,
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.danger,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Page not found',
              style: AppTypography.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              state.uri.toString(),
              style: AppTypography.bodyMediumSecondary,
            ),
            const SizedBox(height: AppSpacing.xxl),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

/// Helper class to convert Riverpod state changes into Listenable for GoRouter.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(this._ref, this._provider) {
    _ref.listen(_provider, (_, __) {
      notifyListeners();
    });
  }

  final Ref _ref;
  final ProviderListenable _provider;
}
