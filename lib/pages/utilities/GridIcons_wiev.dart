import 'package:ServXFactory/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:ServXFactory/app/theme.dart';
import 'package:ServXFactory/generated/l10n.dart';
import 'package:ServXFactory/pages/homePage.dart';
import 'package:ServXFactory/pages/webPages/LatestUpdates_page.dart';
import 'package:ServXFactory/pages/webPages/aboutUs_page.dart';
import 'package:ServXFactory/pages/webPages/blogs_page.dart';
import 'package:ServXFactory/pages/webPages/contact_page.dart';
import 'package:ServXFactory/pages/webPages/introductionVideo_page.dart';
import 'package:ServXFactory/pages/webPages/map_page.dart';
import 'package:ServXFactory/pages/webPages/mediaCenter_page.dart';
import 'package:ServXFactory/pages/webPages/products_page.dart';
import 'package:ServXFactory/pages/webPages/references_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../digitalAssistan_page.dart';

class GridIcons extends StatelessWidget {
  const GridIcons(
    BuildContext context, {
    super.key,
    required PageController pageController,
    required this.homePage,
    required this.personnelType,
  }) : _pageController = pageController;

  final PageController _pageController;
  final bool homePage;
  final String personnelType;

  @override
  Widget build(BuildContext context) {
    print('personnelType: $personnelType');
    return Stack(alignment: Alignment.bottomCenter, children: [
      PageView(
        controller: _pageController,
        children: [
          // Sayfa 1
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 35,
            padding: const EdgeInsets.all(20),
            children: [
              if (homePage == true) ...[
                GridPageIcons(Icons.info, S.of(context).AboutUs,
                    const AboutUsPage(), homePage, context),
                GridPageIcons(Icons.slideshow, S.of(context).IntroductionVideo,
                    const IntroVideoPage(), homePage, context),
                GridPageIcons(Icons.shopping_bag, S.of(context).Products,
                    const ProductsPage(), homePage, context),
                GridPageIcons(Icons.support, S.of(context).ErrorSupportSystem,
                    null, homePage, context),
                GridPageIcons(Icons.new_releases, S.of(context).LatestUpdates,
                    const LatestUpdatesPages(), homePage, context),
                GridPageIcons(Icons.video_library, S.of(context).MediaCenter,
                    const MediaCenterPage(), homePage, context),
                GridPageIcons(Icons.article, S.of(context).Blogs,
                    const BlogsPage(), homePage, context),
                GridPageIcons(Icons.thumb_up, S.of(context).References,
                    const ReferencesPage(), homePage, context),
                GridPageIcons(Icons.contact_mail, S.of(context).Contact,
                    const ContactPage(), homePage, context),
              ] else
                ..._buildPersonnelGridIcons(personnelType, homePage, context),
            ],
          ),
          // Sayfa 2
          if (homePage == true)
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 35,
              padding: const EdgeInsets.all(20),
              children: [
                if (homePage == true)
                  GridPageIcons(Icons.map, S.of(context).KspMap,
                      const MapPage(), homePage, context),
              ],
            ),
        ],
      ),
      Positioned(
        bottom: homePage ? 90 : 10,
        child: SmoothPageIndicator(
          controller: _pageController,
          count: homePage ? 2 : 1, // Sayfa sayısı kadar nokta olacak
          effect: WormEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: homePage
                ? AppTheme.lightTheme.colorScheme.secondary
                : AppTheme.lightTheme.colorScheme.primary,
            dotColor: Colors.grey,
          ),
        ),
      ),
    ]);
  }
}

Column GridPageIcons(
    IconData icon, String text, Widget? route, homePage, context) {
  print('homePage11: $homePage');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color:
              homePage ? Colors.white : AppTheme.lightTheme.colorScheme.primary,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 15, offset: Offset(5, 5))
          ],
          borderRadius: BorderRadius.circular(18),
        ),
        child: IconButton(
          onPressed: () {
            if (route != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => route));
            }
          },
          icon: Icon(icon),
          iconSize: 40,
          color:
              homePage ? AppTheme.lightTheme.colorScheme.primary : Colors.white,
        ),
      ),
      const SizedBox(height: 5),
      SizedBox(
        width: 80, // Maximum width for text
        child: Text(
          text,
          style: TextStyle(
              color: homePage
                  ? Colors.white
                  : AppTheme.lightTheme.colorScheme.primary,
              fontStyle: FontStyle.italic,
              fontSize: 12,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center, // Center the text

          // maxLines: 3, // Show up to two lines
          softWrap: true,
        ),
      ),
    ],
  );
}

List<Widget> _buildPersonnelGridIcons(
    String personnelType, bool homePage, BuildContext context) {
  switch (personnelType) {
    case 'Admin':
      return [
        GridPageIcons(
            Icons.person, 'Profilim', const ProfilePage(), homePage, context),
        GridPageIcons(Icons.analytics, 'Raporlar', null, homePage, context),
        GridPageIcons(Icons.precision_manufacturing, 'Makinelerim', null,
            homePage, context),
        GridPageIcons(Icons.support_agent, 'ServXFactory Talepleri', null,
            homePage, context),
        GridPageIcons(Icons.message, 'Mesajlar', null, homePage, context),
        GridPageIcons(Icons.phone, 'İletişimler', null, homePage, context),
        GridPageIcons(Icons.monitor, 'Makine İzleme', null, homePage, context),
        GridPageIcons(
            Icons.bar_chart, 'Performans Verileri', null, homePage, context),
        GridPageIcons(
            Icons.inventory, 'Yedek Parça Yönetimi', null, homePage, context),
      ];
    case 'Personnel':
      return [
        GridPageIcons(
            Icons.person, 'Profilim', const ProfilePage(), homePage, context),
        GridPageIcons(Icons.task, 'Görevler', null, homePage, context),
        GridPageIcons(
            Icons.chat_bubble_outline, 'Mesajlaşma', null, homePage, context),
        GridPageIcons(
            Icons.school, 'Eğitim Modülleri', null, homePage, context),
        GridPageIcons(
            Icons.report_problem, 'Sorun Bildirimi', null, homePage, context),
        GridPageIcons(Icons.fact_check, 'Raporlama', null, homePage, context),
        GridPageIcons(Icons.perm_device_information, 'Kişisel Bilgiler', null,
            homePage, context),
        GridPageIcons(
            Icons.support_agent, 'Destek Talebi', null, homePage, context),
        GridPageIcons(
            Icons.library_books, 'Dökümanlar', null, homePage, context),
      ];
    case 'User':
      return [
        GridPageIcons(
            Icons.person, 'Profilim', const ProfilePage(), homePage, context),
        GridPageIcons(
            Icons.work_outline, 'Hizmetlerim', null, homePage, context),
        GridPageIcons(Icons.chat_bubble_outline, 'Destek Mesajları',
            const DigitalAssistan(), homePage, context),
        GridPageIcons(Icons.school, 'Eğitimler', null, homePage, context),
        GridPageIcons(
            Icons.shopping_cart, 'Siparişlerim', null, homePage, context),
        GridPageIcons(Icons.android, 'Dijital Assistan',
            const DigitalAssistan(), homePage, context),
        GridPageIcons(
            Icons.notifications, 'Bildirimler', null, homePage, context),
        GridPageIcons(
            Icons.payment, 'Ödeme Yöntemleri', null, homePage, context),
        GridPageIcons(Icons.help, 'SSS ve Yardım', null, homePage, context),
      ];
    default:
      return [
        GridPageIcons(
            Icons.person, 'Profilim', const ProfilePage(), homePage, context),
        GridPageIcons(
            Icons.work_outline, 'Hizmetlerim', null, homePage, context),
        GridPageIcons(Icons.chat_bubble_outline, 'Destek Mesajları',
            const DigitalAssistan(), homePage, context),
        GridPageIcons(Icons.school, 'Eğitimler', null, homePage, context),
        GridPageIcons(
            Icons.shopping_cart, 'Siparişlerim', null, homePage, context),
        GridPageIcons(Icons.android, 'Dijital Assistan',
            const DigitalAssistan(), homePage, context),
        GridPageIcons(
            Icons.notifications, 'Bildirimler', null, homePage, context),
        GridPageIcons(
            Icons.payment, 'Ödeme Yöntemleri', null, homePage, context),
        GridPageIcons(Icons.help, 'SSS ve Yardım', null, homePage, context),
      ];
  }
}
