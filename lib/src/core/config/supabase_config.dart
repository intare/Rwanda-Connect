import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase configuration.
///
/// Get these values from your Supabase Dashboard:
/// Settings -> API -> Project URL and anon/public key
abstract final class SupabaseConfig {
  // TODO: Replace with your Supabase project URL
  // Found at: Dashboard -> Settings -> API -> Project URL
  static const String url = 'https://ktjsdqzspruvcegnixkt.supabase.co';

  // TODO: Replace with your Supabase anon key
  // Found at: Dashboard -> Settings -> API -> anon/public key
  static const String anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt0anNkcXpzcHJ1dmNlZ25peGt0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg2OTYzMDIsImV4cCI6MjA4NDI3MjMwMn0.fytFq6UaSfvC7-QaFBPCZy91Up6gjfbEQtwiK-Nv0B0';
}

/// Initialize Supabase.
/// Call this in main() before runApp().
Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
  );
}

/// Provider for the Supabase client.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Provider for the Supabase auth client.
final supabaseAuthProvider = Provider<GoTrueClient>((ref) {
  return Supabase.instance.client.auth;
});

/// Provider for listening to auth state changes.
final authStateChangesProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

/// Provider for the current session.
final currentSessionProvider = Provider<Session?>((ref) {
  return Supabase.instance.client.auth.currentSession;
});

/// Provider for the current user.
final supabaseUserProvider = Provider<User?>((ref) {
  return Supabase.instance.client.auth.currentUser;
});
