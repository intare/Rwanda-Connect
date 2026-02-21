import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../models/service_item.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/quick_stats_row.dart';
import '../widgets/service_category_section.dart';

/// Main dashboard screen showcasing all app services.
class ServicesDashboardScreen extends ConsumerWidget {
  const ServicesDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(dashboardStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Gradient header
          SliverToBoxAdapter(
            child: DashboardHeader(
              userName: stats.userName,
              onBack: () => context.pop(),
            ),
          ),

          // Quick stats row
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: QuickStatsRow(
                bookmarksCount: stats.bookmarksCount,
                rsvpsCount: stats.rsvpsCount,
                subscriptionStatus: stats.subscriptionStatus,
              ),
            ),
          ),

          // Discover section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.lg),
              child: ServiceCategorySection(
                category: ServiceCategory.discover,
                services: DashboardServices.discover,
                onServiceTap: (service) => _navigateToService(context, service),
              ),
            ),
          ),

          // Opportunity section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxl),
              child: ServiceCategorySection(
                category: ServiceCategory.opportunity,
                services: DashboardServices.opportunity,
                onServiceTap: (service) => _navigateToService(context, service),
              ),
            ),
          ),

          // Learn section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxl),
              child: ServiceCategorySection(
                category: ServiceCategory.learn,
                services: DashboardServices.learn,
                onServiceTap: (service) => _navigateToService(context, service),
              ),
            ),
          ),

          // Personal section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxl),
              child: ServiceCategorySection(
                category: ServiceCategory.personal,
                services: DashboardServices.personal,
                onServiceTap: (service) => _navigateToService(context, service),
              ),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.xxxl * 2),
          ),
        ],
      ),
    );
  }

  void _navigateToService(BuildContext context, ServiceItem service) {
    // Shell routes (bottom nav tabs) need go() to avoid duplicate GlobalKey issues
    const shellRoutes = {'/home', '/opportunities', '/events', '/community', '/profile'};
    if (shellRoutes.contains(service.route)) {
      context.go(service.route);
    } else {
      context.push(service.route);
    }
  }
}
