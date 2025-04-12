import 'package:supabase_flutter/supabase_flutter.dart';

final SupabaseClient supabaseClient = Supabase.instance.client;

Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: 'https://niosoyktbupufcwtcrhc.supabase.co', // Replace with your Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5pb3NveWt0YnVwdWZjd3RjcmhjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE5MzAyNzcsImV4cCI6MjA1NzUwNjI3N30.55_g81NozaYMac1_Ek0gLj07VVXLMH_SXJkDzlO7iHo', // Replace with your Supabase anon/public key
  );
}