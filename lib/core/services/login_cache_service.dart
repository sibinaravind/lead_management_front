import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/officer/officers_lofin_model.dart';

const String OFFICER_CACHE_KEY = 'officer_cache';
const String OFFICER_TOKEN_KEY = 'officer_token';
const String OFFICER_ID = 'officer_id';

class OfficerCacheService {
  Officer? _officer;
  Officer? get officer => _officer;

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  Future<bool> saveOfficer(Officer officer) async {
    final prefs = await _prefs;
    _officer = officer;
    // print("===>  ${officer.id}");
    prefs.setString(OFFICER_ID, officer.id ?? '');
    return prefs.setString(OFFICER_CACHE_KEY, jsonEncode(officer.toJson()));
  }

  Future<Officer?> getOfficer() async {
    final prefs = await _prefs;
    final data = prefs.getString(OFFICER_CACHE_KEY);
    if (data == null) return null;
    _officer = Officer.fromJson(jsonDecode(data));
    return _officer;
  }

  Future<bool> saveToken(String token) async {
    final prefs = await _prefs;
    return prefs.setString(OFFICER_TOKEN_KEY, token);
  }

  Future<String?> getToken() async {
    final prefs = await _prefs;
    return prefs.getString(OFFICER_TOKEN_KEY);
  }

  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.remove(OFFICER_CACHE_KEY);
    await prefs.remove(OFFICER_TOKEN_KEY);
    _officer = null;
  }
}
