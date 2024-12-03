// email_suggestion.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailSuggestion {
  // SharedPreferences'tan e-posta adreslerini yükle
  static Future<List<String>> loadEmails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('emails') ?? [];
  }

  // E-posta adresinin geçerli olup olmadığını kontrol et
  static bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // E-posta girildiğinde, listeyi filtrele
  static List<String> filterEmails(String query, List<String> previousEmails) {
    // İlk 3 öneriyi göster
    final filtered = previousEmails
        .where((email) =>
            email.toLowerCase().contains(query.toLowerCase()) &&
            isValidEmail(email)) // Geçerli e-posta adreslerini filtrele
        .take(3) // İlk 3 öğeyi göster
        .toList();

    print(
        "Filtrelenmiş e-postalar: $filtered"); // Debug: Filtrelenmiş veriyi kontrol et
    return filtered;
  }

  // Yeni e-posta adresini kaydet
  static Future<void> saveEmail(String email) async {
    if (isValidEmail(email)) {
      final prefs = await SharedPreferences.getInstance();
      List<String> previousEmails = prefs.getStringList('emails') ?? [];

      // Eğer e-posta listede zaten varsa, onu en başa alalım
      if (previousEmails.contains(email)) {
        previousEmails.remove(email); // Önce listeden sil
        previousEmails.insert(0, email); // En başa ekle
      } else {
        // E-posta listede yoksa, yeni e-posta ekleyelim
        previousEmails.insert(0, email); // En başa ekle
      }

      // Eğer liste 3'ten fazla ise, en eski öğeyi sil
      if (previousEmails.length > 3) {
        previousEmails.removeLast(); // Son öğeyi sil (en eski)
      }

      // Güncellenmiş listeyi SharedPreferences'a kaydet
      await prefs.setStringList('emails', previousEmails);

      // Debug: Kaydetme işlemi sonrası veriyi kontrol et
      print("E-posta kaydedildi: $email");
      print("Tüm e-postalar: ${prefs.getStringList('emails')}");
    }
  }
}
