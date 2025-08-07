import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseService {
  final SupabaseClient _supabase;
  final String tableName;

  BaseService(this._supabase, this.tableName);

  SupabaseClient get client => _supabase;
  SupabaseQueryBuilder get table => _supabase.from(tableName);

  Future<List<Map<String, dynamic>>> getAll() async {
    final response = await table.select();
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>?> getById(String id) async {
    final response = await table.select().eq('id', id).maybeSingle();
    return response;
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    final response = await table.insert(data).select().single();
    return response;
  }

  Future<Map<String, dynamic>> update(
      String id, Map<String, dynamic> data) async {
    final response = await table.update(data).eq('id', id).select().single();
    return response;
  }

  Future<void> delete(String id) async {
    await table.delete().eq('id', id);
  }
}
