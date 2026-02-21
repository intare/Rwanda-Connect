import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/auth_state.dart';
import '../../presentation/features/auth/providers/auth_provider.dart';
import '../../presentation/features/auth/screens/login_screen.dart';
import '../../presentation/features/auth/screens/register_screen.dart';
import '../../presentation/features/auth/screens/onboarding_screen.dart';
import '../../presentation/features/auth/screens/forgot_password_screen.dart';
import '../../presentation/features/auth/screens/reset_password_screen.dart';
import '../../presentation/features/auth/screens/verify_email_screen.dart';
import '../../presentation/features/home/screens/home_screen.dart';
import '../../presentation/features/home/screens/news_detail_screen.dart';
import '../../presentation/features/home/screens/news_search_screen.dart';
import '../../domain/entities/news.dart';
import '../../presentation/features/opportunities/screens/opportunities_screen.dart';
import '../../presentation/features/opportunities/screens/opportunity_detail_screen.dart';
import '../../presentation/features/events/screens/events_screen.dart';
import '../../presentation/features/events/screens/event_detail_screen.dart';
import '../../presentation/features/community/screens/community_screen.dart';
import '../../presentation/features/profile/screens/profile_screen.dart';
import '../../presentation/features/bookmarks/screens/bookmarks_screen.dart';
import '../../presentation/features/events/screens/my_rsvps_screen.dart';
import '../../presentation/features/properties/screens/properties_screen.dart';
import '../../presentation/features/properties/screens/property_detail_screen.dart';
import '../../presentation/features/properties/screens/my_bids_screen.dart';
import '../../presentation/features/playbook/screens/playbook_screen.dart';
import '../../presentation/features/playbook/screens/playbook_content_screen.dart';
import '../../presentation/features/playbook/screens/liked_content_screen.dart';
import '../../presentation/features/mentorship/screens/mentors_screen.dart';
import '../../presentation/features/mentorship/screens/mentor_detail_screen.dart';
import '../../presentation/features/mentorship/screens/my_mentorships_screen.dart';
import '../../presentation/features/dashboard/screens/services_dashboard_screen.dart';
import '../../presentation/features/directory/screens/directory_screen.dart';
import '../../presentation/features/directory/screens/business_detail_screen.dart';
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
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';

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

  // Search
  static const String newsSearch = '/search/news';

  // Bookmarks
  static const String bookmarks = '/bookmarks';

  // My RSVPs
  static const String myRsvps = '/my-rsvps';

  // Properties
  static const String properties = '/properties';
  static const String propertyDetail = '/properties/:id';
  static const String myBids = '/properties/bids';

  // Playbook
  static const String playbook = '/playbook';
  static const String playbookContent = '/playbook/:id';
  static const String likedContent = '/playbook/liked';

  // Mentorship
  static const String mentors = '/mentorship';
  static const String mentorDetail = '/mentorship/mentor/:id';
  static const String myMentorships = '/mentorship/my';

  // Dashboard
  static const String dashboard = '/dashboard';

  // Business Directory
  static const String directory = '/directory';
  static const String businessDetail = '/directory/:id';

  /// Routes that don't require authentication.
  static const List<String> publicRoutes = [
    splash,
    login,
    register,
    forgotPassword,
    resetPassword,
  ];

  /// Routes accessible to authenticated but unverified users.
  static const List<String> unverifiedAllowedRoutes = [
    verifyEmail,
  ];

  /// Check if a route requires authentication.
  static bool requiresAuth(String location) {
    return !publicRoutes.any((route) {
      if (route == splash) {
        return location == splash;
      }
      return location.startsWith(route);
    });
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
      final user = authState.user;
      final isEmailVerified = user?.emailVerified ?? false;

      // Show splash while checking auth status
      if (isInitial || isLoading) {
        if (location != AppRoutes.splash) {
          return AppRoutes.splash;
        }
        return null;
      }

      // If on splash and auth check is done, redirect appropriately
      if (location == AppRoutes.splash) {
        if (!isAuthenticated) {
          return AppRoutes.login;
        }
        // TODO: Re-enable email verification once SendGrid is working
        // if (!isEmailVerified) {
        //   return AppRoutes.verifyEmail;
        // }
        return AppRoutes.home;
      }

      // If not authenticated and trying to access protected route
      if (!isAuthenticated && AppRoutes.requiresAuth(location)) {
        return AppRoutes.login;
      }

      // If authenticated and trying to access auth routes (login/register)
      if (isAuthenticated &&
          (location == AppRoutes.login || location == AppRoutes.register)) {
        // TODO: Re-enable email verification once SendGrid is working
        // if (!isEmailVerified) {
        //   return AppRoutes.verifyEmail;
        // }
        return AppRoutes.home;
      }

      // If authenticated but email not verified
      // TODO: Re-enable email verification once SendGrid is working
      // if (isAuthenticated && !isEmailVerified) {
      //   // Allow access to verify-email and onboarding routes
      //   final isAllowedRoute = AppRoutes.unverifiedAllowedRoutes
      //       .any((route) => location.startsWith(route));
      //   if (!isAllowedRoute) {
      //     return AppRoutes.verifyEmail;
      //   }
      // }

      // If on verify-email but already verified, redirect to appropriate screen
      if (isAuthenticated &&
          isEmailVerified &&
          location == AppRoutes.verifyEmail) {
        if (user?.onboardingCompleted ?? false) {
          return AppRoutes.home;
        }
        return AppRoutes.onboarding;
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
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'resetPassword',
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];
          return ResetPasswordScreen(token: token);
        },
      ),
      GoRoute(
        path: AppRoutes.verifyEmail,
        name: 'verifyEmail',
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];
          return VerifyEmailScreen(token: token);
        },
      ),

      // Main app shell with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.opportunities,
            name: 'opportunities',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const OpportunitiesScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.events,
            name: 'events',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const EventsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.community,
            name: 'community',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const CommunityScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const ProfileScreen(),
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

      // Search routes
      GoRoute(
        path: AppRoutes.newsSearch,
        name: 'newsSearch',
        builder: (context, state) => const NewsSearchScreen(),
      ),

      // Bookmarks route
      GoRoute(
        path: AppRoutes.bookmarks,
        name: 'bookmarks',
        builder: (context, state) => const BookmarksScreen(),
      ),

      // My RSVPs route
      GoRoute(
        path: AppRoutes.myRsvps,
        name: 'myRsvps',
        builder: (context, state) => const MyRsvpsScreen(),
      ),

      // Properties routes
      GoRoute(
        path: AppRoutes.properties,
        name: 'properties',
        builder: (context, state) => const PropertiesScreen(),
      ),
      GoRoute(
        path: AppRoutes.propertyDetail,
        name: 'propertyDetail',
        builder: (context, state) => PropertyDetailScreen(
          propertyId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.myBids,
        name: 'myBids',
        builder: (context, state) => const MyBidsScreen(),
      ),

      // Playbook routes
      GoRoute(
        path: AppRoutes.playbook,
        name: 'playbook',
        builder: (context, state) => const PlaybookScreen(),
      ),
      GoRoute(
        path: AppRoutes.playbookContent,
        name: 'playbookContent',
        builder: (context, state) => PlaybookContentScreen(
          contentId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.likedContent,
        name: 'likedContent',
        builder: (context, state) => const LikedContentScreen(),
      ),

      // Mentorship routes
      GoRoute(
        path: AppRoutes.mentors,
        name: 'mentors',
        builder: (context, state) => const MentorsScreen(),
      ),
      GoRoute(
        path: AppRoutes.mentorDetail,
        name: 'mentorDetail',
        builder: (context, state) => MentorDetailScreen(
          mentorId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.myMentorships,
        name: 'myMentorships',
        builder: (context, state) => const MyMentorshipsScreen(),
      ),

      // Dashboard route
      GoRoute(
        path: AppRoutes.dashboard,
        name: 'dashboard',
        builder: (context, state) => const ServicesDashboardScreen(),
      ),

      // Business Directory routes
      GoRoute(
        path: AppRoutes.directory,
        name: 'directory',
        builder: (context, state) => const DirectoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.businessDetail,
        name: 'businessDetail',
        builder: (context, state) => BusinessDetailScreen(
          businessId: state.pathParameters['id']!,
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
