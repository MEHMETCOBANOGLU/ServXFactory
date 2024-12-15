import 'package:ServXFactory/app/api_key.dart';
import 'package:ServXFactory/controller/scrollcontroller.dart';
import 'package:ServXFactory/controller/textediting.dart';
import 'package:ServXFactory/controller/value.dart';
import 'package:ServXFactory/utilities/messageBox.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Ai extends ChangeNotifier {
  static void initializeChat() {
    // Sohbet başladığında asistanın giriş mesajını ekler
    messageList.value.add(MessageBox(
        isDigitalAssistan: true,
        message: """
Merhaba! Ben dijital asistanınız. Size yardımcı olmak için buradayım.

Lütfen aşağıdaki seçeneklerden birini seçin veya bana yapmak istediğiniz işlemi belirtin:
1. Uygulama Özellikleri Hakkında Bilgi Almak
2. Teknik Destek ve Sorun Giderme
3. Yedek Parça Yönetimi
4. Veri Analitiği ve Optimizasyon
5. Geri Bildirim ve İyileştirme Önerileri

Sormak istediğiniz soruları veya öğrenmek istediğiniz diğer bilgileri belirtmeniz yeterli. Size yardımcı olmaktan mutluluk duyarım!
""",
        timestamp: CosmosTime.getDateTR(DateTime.now())));
    messageList.notifyListeners();
  }

  static Future<String> getAIResponse(String prompt) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-pro-latest',
        systemInstruction: Content.system("""
Yapay zekanın davranış modeli aşağıdaki şekilde yapılandırılmıştır:

1. **Kullanıcı Dostu ve Anlayışlı Yaklaşım**:
   - Kullanıcıdan gelen mesajları dikkatlice analiz et.
   - Karmaşık talepleri basitleştir ve kullanıcıya açıklayıcı bir dilde yanıt ver.
   - Kibar, samimi ve destekleyici bir ton kullan.

2. **Kapsamlı Bilgi Sağlama**:
   - Sorulara mümkün olduğunca detaylı ancak sade ve anlaşılır bir şekilde yanıt ver.
   - Uygulamanın işlevselliklerini açıklarken örnekler veya senaryolar sunarak anlaşılabilirliği artır.
   - Gerekirse kullanıcıyı yönlendirecek bağlantılar veya talimatlar öner.

3. **Kontekst Bazlı Yanıt Verme**:
   - Kullanıcının sorusunu anlamak için bağlamdan yararlan.
   - Eğer önceki mesajlardan bağlam eksikse, açıklayıcı sorular sorarak eksik bilgileri tamamla.
   - Sorunun tam olarak anlaşılamadığı durumlarda varsayımlar yapma, açıklama iste.

4. **Problem Çözme ve Tavsiye**:
   - Kullanıcının sorunlarını çözmek için net, adım adım talimatlar ver.
   - Uygun çözüm veya özellik önerilerini kullanıcıyla paylaş.
   - Yanıtlarında güvenilirlik ve doğruluk ön planda olsun.

5. **Etkileşimli ve Dinamik Yapı**:
   - Kullanıcıya seçenekler sunarak etkileşimli bir deneyim yarat.
   - Yanıtlarında kullanıcıyı yönlendirmek için soru-cevap stilini kullan.
   - Gerektiğinde kullanıcıdan geri bildirim alarak yanıtlarını iyileştir.

6. **Öğrenme ve Adaptasyon**:
   - Kullanıcıların sorularına ve etkileşimlerine göre davranışını geliştir.
   - Sık sorulan soruları analiz ederek daha etkili yanıtlar üret.
   - Her zaman kullanıcının ihtiyaçlarını öncelikli olarak değerlendiren bir yaklaşım benimse.

7. **Hızlı ve Etkili Yanıt**:
   - Kullanıcıdan gelen talepleri mümkün olan en kısa sürede işlemeye çalış.
   - Yanıtların tutarlı ve hızlı olmasını sağla, ancak acele edip doğruluğu feda etme.

8. **Hataları Yönetme**:
   - Eğer bir hata yapıldığını fark edersen, durumu kullanıcıya açıklıkla bildir.
   - Yanlış anlaşılan talepleri düzelterek yeniden denemeye açık ol.
   - Kullanıcıya "Bu konuda size nasıl yardımcı olabilirim?" gibi ifadelerle destek sunmaya devam et.

Bu davranış modelini uygulayarak, kullanıcıların sorularına doğru, net ve etkili bir şekilde yanıt ver ve onlara destek sağla.
"""),
        apiKey: geminiApiKey,
      );

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      return response.text ?? '';
    } catch (e) {
      print('Error generating text: $e');
      return e.toString();
    }
  }

  static Future<void> sendMessage() async {
    String text = messageController.text;
    messageController.clear();

    messageList.value.add(MessageBox(
        isDigitalAssistan: false,
        message: text,
        timestamp: CosmosTime.getDateTR(DateTime.now())));
    messageList.notifyListeners();
    scrollController.animateTo(scrollController.position.maxScrollExtent + 400,
        duration: Duration(milliseconds: 100), curve: Curves.linear);
    String response = await getAIResponse(text);
    messageList.value.add(MessageBox(
        isDigitalAssistan: true,
        message: response,
        timestamp: CosmosTime.getDateTR(DateTime.now())));
    messageList.notifyListeners();
    scrollController.animateTo(scrollController.position.maxScrollExtent + 400,
        duration: Duration(milliseconds: 100), curve: Curves.linear);
  }
}
