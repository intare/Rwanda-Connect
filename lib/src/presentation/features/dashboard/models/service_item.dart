import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Represents a service category in the dashboard.
enum ServiceCategory {
  discover('Discover', AppColors.categoryDiscover),
  opportunity('Opportunity', AppColors.categoryOpportunity),
  learn('Learn', AppColors.categoryLearn),
  personal('Personal', AppColors.categoryPersonal);

  const ServiceCategory(this.label, this.accentColor);

  final String label;
  final Color accentColor;
}

/// Represents a single service item in the dashboard.
class ServiceItem {
  const ServiceItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.route,
    required this.category,
    this.isPremium = false,
    this.description,
  });

  final String id;
  final String label;
  final IconData icon;
  final String route;
  final ServiceCategory category;
  final bool isPremium;
  final String? description;

  /// Get accent color for this service based on category.
  Color get accentColor => category.accentColor;
}

/// All available services in the app organized by category.
class DashboardServices {
  static const List<ServiceItem> discover = [
    ServiceItem(
      id: 'news',
      label: 'News',
      icon: Icons.newspaper,
      route: '/home',
      category: ServiceCategory.discover,
      description: 'Latest news and updates',
    ),
    ServiceItem(
      id: 'events',
      label: 'Events',
      icon: Icons.event,
      route: '/events',
      category: ServiceCategory.discover,
      description: 'Upcoming events and meetups',
    ),
    ServiceItem(
      id: 'community',
      label: 'Community',
      icon: Icons.forum,
      route: '/community',
      category: ServiceCategory.discover,
      description: 'Join discussions',
    ),
    ServiceItem(
      id: 'directory',
      label: 'Directory',
      icon: Icons.store,
      route: '/directory',
      category: ServiceCategory.discover,
      description: 'Business listings',
    ),
  ];

  static const List<ServiceItem> opportunity = [
    ServiceItem(
      id: 'opportunities',
      label: 'Opportunities',
      icon: Icons.work,
      route: '/opportunities',
      category: ServiceCategory.opportunity,
      description: 'Jobs, investments & more',
    ),
    ServiceItem(
      id: 'properties',
      label: 'Properties',
      icon: Icons.home_work,
      route: '/properties',
      category: ServiceCategory.opportunity,
      description: 'Real estate listings',
    ),
    ServiceItem(
      id: 'mentorship',
      label: 'Mentorship',
      icon: Icons.people,
      route: '/mentorship',
      category: ServiceCategory.opportunity,
      isPremium: true,
      description: 'Connect with mentors',
    ),
  ];

  static const List<ServiceItem> learn = [
    ServiceItem(
      id: 'playbook',
      label: 'Career Playbook',
      icon: Icons.menu_book,
      route: '/playbook',
      category: ServiceCategory.learn,
      description: 'Career guides and tips',
    ),
  ];

  static const List<ServiceItem> personal = [
    ServiceItem(
      id: 'bookmarks',
      label: 'Bookmarks',
      icon: Icons.bookmark,
      route: '/bookmarks',
      category: ServiceCategory.personal,
      isPremium: true,
      description: 'Your saved items',
    ),
    ServiceItem(
      id: 'profile',
      label: 'Profile',
      icon: Icons.person,
      route: '/profile',
      category: ServiceCategory.personal,
      description: 'Your profile and settings',
    ),
  ];

  /// Get all services grouped by category.
  static Map<ServiceCategory, List<ServiceItem>> get grouped => {
        ServiceCategory.discover: discover,
        ServiceCategory.opportunity: opportunity,
        ServiceCategory.learn: learn,
        ServiceCategory.personal: personal,
      };

  /// Get all services as a flat list.
  static List<ServiceItem> get all => [
        ...discover,
        ...opportunity,
        ...learn,
        ...personal,
      ];
}
