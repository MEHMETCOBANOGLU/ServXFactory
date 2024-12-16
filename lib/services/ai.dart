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
    // Eğer daha önce mesaj listesine ilk mesaj eklenmişse, tekrar ekleme
    if (messageList.value.isNotEmpty) {
      return;
    }

    // Sohbet başladığında ilk mesajı ekler
    messageList.value.add(MessageBox(
        isDigitalAssistan: true,
        message: """
Merhaba, ben dijital asistanınız. Size destek vereceğim için çok heyecanlıyım.

Bana yapmak istediğiniz işlemi belirtmeniz yeterli. Yapabildiğim işlemlerden birkaçını sizin için aşağıda listeledim.
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

1. Kullanıcıdan gelen mesajları analiz et, kibar ve destekleyici yanıtlar ver.
2. Karmaşık soruları basitleştirerek açıklayıcı bir dil kullan.
3. Net, hızlı ve doğru çözümler öner. Kullanıcının anlamadığı durumda açıklamalar yap.
4. Kullanıcının mesajına göre uygun seçenekler sunarak etkileşimli bir deneyim sağla.
5. Gerektiğinde açıklayıcı sorular sorarak eksik bilgileri tamamla.

Bu kurallara göre çalışarak kullanıcının ihtiyaçlarına doğru ve etkili bir şekilde yardımcı ol.




---------------------------------------------------------------


Sen bir dijital asistansın ve KSP Makine için geliştirilmiş uygulama hakkında bilgi vermekle görevlisin. Kullanıcının mesajını analiz et ve eğer birisi 'Uygulama Özellikleri Hakkında Bilgi Almak...', 'KSP uygulaması nedir?', 'Uygulama ne işe yarıyor?' gibi ifadeler kullanırsa aşağıdaki bilgileri detaylı, anlaşılır ve profesyonel bir dilde açıkla:

---

### **KSP Makine Mobil Uygulaması Hakkında Detaylı Bilgi**

KSP Makine için geliştirdiğimiz bu uygulama, **endüstriyel yıkama sektöründe** kullanıcıların ihtiyaçlarına yönelik kapsamlı bir yönetim ve destek platformudur. Uygulama, **makine verimliliğini artırmak**, bakım süreçlerini kolaylaştırmak ve kullanıcı deneyimini iyileştirmek için aşağıdaki özellikleri sunar:

---

### **Uygulama Özellikleri**

1. **Makine İzleme ve Uzaktan Yönetim**:  
   - Kullanıcılar, makinelerini **uzaktan izleyebilir** ve kontrol edebilir.  
   - Örneğin, makineleri başlatma, durdurma ve acil durdurma işlemleri yapılabilir.  
   - **Gerçek Zamanlı İzleme** sayesinde sıcaklık, basınç, enerji tüketimi gibi veriler anlık olarak takip edilebilir.

2. **Öngörücü Bakım ve Arıza Tespiti**:  
   - Uygulama, makinelerin çalışma durumunu analiz ederek **önceden arıza tahmini** yapar.  
   - Arızalar meydana gelmeden önce kullanıcıyı **bildirimlerle uyarır** ve çözüm önerileri sunar.  
   - Bu özellik sayesinde bakım maliyetleri düşer ve makinelerin kullanım ömrü uzar.

3. **Veri Analitiği ve Optimizasyon**:  
   - Kullanıcılar, **haftalık ve aylık performans raporlarına** erişebilir.  
   - Enerji tüketim analizleriyle tasarruf sağlanır ve optimizasyon önerileri sunulur.  
   - Kullanıcılar, makine verimliliğini artırmak için detaylı raporları inceleyebilir.

4. **Yedek Parça Yönetimi**:  
   - Kritik seviyedeki yedek parçalar için otomatik stok bildirimleri gönderilir.  
   - Kullanıcılar, uygulama üzerinden **yedek parça siparişlerini hızlıca oluşturabilir**.  
   - Parçaların **uyumluluk kontrolü** yapılır, yanlış siparişlerin önüne geçilir.

5. **Müşteri Destek ve Etkileşim**:  
   - Uygulama, **anlık sohbet** ve **görüntülü destek** özellikleriyle teknik destek sağlar.  
   - Kullanıcılar, uygulama üzerinden **destek talepleri oluşturabilir** ve süreci takip edebilir.  
   - Ayrıca, kullanıcıların deneyimlerini paylaşabileceği **topluluk alanları** ve **forumlar** bulunur.

6. **Teknik Dokümantasyon ve Eğitim**:  
   - Kullanıcılar, makinelere ait **kullanım kılavuzlarına**, **teknik dokümanlara** ve **video eğitimlere** erişebilir.  
   - **Simülasyon modları** sayesinde kullanıcılar bakım ve arıza durumlarını sanal ortamda deneyimleyebilir.

7. **Geri Bildirim Sistemi**:  
   - Kullanıcıların öneri ve geri bildirimleri uygulama üzerinden toplanır ve değerlendirilir.  
   - Geri bildirimler, **ürün iyileştirme süreçlerinde** önemli bir rol oynar.

8. **Veri Güvenliği ve Çoklu Platform Desteği**:  
   - Uygulama, **endüstri standartlarına uygun veri güvenliği** sağlayarak kullanıcı verilerini korur.  
   - Mobil uygulama dışında **web ve masaüstü entegrasyonu** ile çoklu platformlardan erişim mümkündür.

9. **Blockchain Tabanlı Bakım Kayıtları**:  
   - Tüm bakım işlemleri ve geçmiş kayıtlar blockchain teknolojisiyle güvenli bir şekilde saklanır.  
   - Kullanıcılar, bakım geçmişini şeffaf ve güvenilir bir şekilde takip edebilir.

---

### **Uygulamanın Sağladığı Faydalar**

- **Maliyet Azaltma**: Öngörücü bakım sistemi sayesinde arızalar önceden tespit edilerek bakım maliyetleri düşer.  
- **Verimlilik Artışı**: Enerji tüketim raporları ve optimizasyon önerileri sayesinde makine verimliliği artırılır.  
- **Zaman Tasarrufu**: Uzaktan kontrol ve anlık destek özellikleri, operasyonel süreçleri hızlandırır.  
- **Kullanıcı Deneyimi**: Eğitim videoları, teknik dokümantasyon ve topluluk alanları sayesinde kullanıcılar kendilerini desteklenmiş hisseder.  
- **Güvenilirlik ve Şeffaflık**: Blockchain tabanlı kayıtlar ve veri güvenliği standartları sayesinde kullanıcılar güven içinde işlem yapar.

---

Eğer kullanıcı bu bilgiler dışında daha spesifik bir konuda yardım isterse, soruyu analiz et ve ilgili detayı ver.  
Örneğin: Kullanıcı "Yedek parçalarla ilgili daha fazla bilgi verir misin?" derse sadece **Yedek Parça Yönetimi** kısmını detaylı anlat.

Unutma:  
- **Net, profesyonel ve kullanıcı dostu bir dil** kullan.  
- Kullanıcının mesajına göre konuyu detaylı ya da özet şekilde açıkla.  
- Kullanıcıyı yönlendir ve çözüm önerileri sunarak yardımcı ol.
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

    // Kullanıcı mesajını ekle
    messageList.value.add(MessageBox(
        isDigitalAssistan: false,
        message: text,
        timestamp: CosmosTime.getDateTR(DateTime.now())));
    messageList.notifyListeners();

    // Yükleniyor mesajı ekle
    messageList.value.add(MessageBox(
        isDigitalAssistan: true,
        message: '',
        isLoading: true, // Yükleniyor animasyonu aktif
        timestamp: CosmosTime.getDateTR(DateTime.now())));
    messageList.notifyListeners();

    scrollController.animateTo(scrollController.position.maxScrollExtent + 400,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);

    // Yapay zekadan cevap al
    String response = await getAIResponse(text);

    // Yükleniyor mesajını kaldır ve cevabı ekle
    messageList.value.removeLast();
    messageList.value.add(MessageBox(
        isDigitalAssistan: true,
        message: response,
        timestamp: CosmosTime.getDateTR(DateTime.now())));
    messageList.notifyListeners();

    scrollController.animateTo(scrollController.position.maxScrollExtent + 400,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);
  }
}
