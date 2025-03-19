import 'package:flutter/material.dart';
import 'package:ptn_mobile_app/model/Song.dart';
import 'package:provider/provider.dart';
import '../viewmodel/song_viewmodel.dart';
import '../pages/PlaySong.dart';
import '../utils/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Örnek veri listesi
  final List<Song> trendingSongs = [
    Song(
      id: 1,
      title: 'The missing 99 percent of the universe',
      artist: 'Chris Martin',
      imagePath: 'assets/images/group_1092.png',
    ),
    
    Song(
      id: 2,
      title: 'How Daily Parton led me to an epiphany',
      artist: 'Alexandra Joy',
      imagePath: 'assets/images/album_Art.png',
    ),
    Song(
      id: 3,
      title: 'The missing 96 percent of the universe',
      artist: 'Tim McGraw',
      imagePath: 'assets/images/album_Art1.png',
    ),
    Song(
      id: 4,
      title: 'Ngobam with Danny Caknan',
      artist: 'Danny Caknan',
      imagePath: 'assets/images/album_Art2.png',
    ),
    Song(
      id: 5,
      title: 'The missing 99 percent of the universe',
      artist: 'Chris Martin',
      imagePath: 'assets/images/group_1092.png',
    ),
    Song(
      id: 6,
      title: 'How Daily Parton led me to an epiphany',
      artist: 'Alexandra Joy',
      imagePath: 'assets/images/album_Art.png',
    ),
    Song(
      id: 7,
      title: 'The missing 96 percent',
      artist: 'Tim McGraw',
      imagePath: 'assets/images/album_Art1.png',
    ),
    Song(
      id: 8,
      title: 'Ngobam with Danny Caknan',
      artist: 'Danny Caknan',
      imagePath: 'assets/images/album_Art2.png',
    ),
  ];

  final List<String> categories = ['All', 'Life', 'Comedy', 'Tech'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(iconData: Icons.home, label: 'Discover', isActive: true),
            _buildNavItem(
              iconWidget: Image.asset(
                'assets/images/Library.png',
                width: 24,
                height: 24,
              ),
              label: 'Library',
              isActive: false,
            ),
            _buildNavItem(iconData: Icons.person, label: 'Profile', isActive: false),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Ekran genişliğini al
            final width = MediaQuery.of(context).size.width;
            // Ekran yönünü al
            final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
            // Cihaz türünü belirle
            final isTablet = width > 600;

            // Grid için sütun sayısını belirle
            int crossAxisCount = 2; // Varsayılan telefon dikey görünüm
            double childAspectRatio = 0.8;

            if (isTablet && isLandscape) {
              crossAxisCount = 4; // Tablet yatay
              childAspectRatio = 0.85;
            } else if (isTablet) {
              crossAxisCount = 3; // Tablet dikey
              childAspectRatio = 0.82;
            } else if (isLandscape) {
              crossAxisCount = 3; // Telefon yatay
              childAspectRatio = 1.1; // Yatay mod için aspect ratio'yu arttırdık
            }

            return Column(
              children: [
                
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24.0 : 23.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    children: [
                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/group_1030.png',
                            width: 24,
                            height: 24,
                            color: AppColors.primaryTextColor,
                          ),
                          
                          const Text(
                            'Podkes',
                            style: TextStyle(
                              color: AppColors.primaryTextColor,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                          Image.asset(
                            'assets/images/Notification.png',
                            width: 24,
                            height: 24,
                            color: AppColors.primaryTextColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Search Bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const TextField(
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                              fontFamily: 'Inter-SemiBold',
                              
                            ),
                            prefixIcon: null,
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              child: ImageIcon(
                                AssetImage('assets/images/Search.png'),
                                color: Colors.white54,
                                size: 20,
                              ),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 24.0 : 23.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          // Categories
                          Center(
                            child: SizedBox(
                              height: 40,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 6),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.cardColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: AppColors.cardColor),
                                    ),
                                    child: Center(
                                      child: Text(
                                        categories[index],
                                        style: const TextStyle(
                                          color: Color(0xFFF9F9FA),
                                          fontSize: 15,
                                          fontFamily: 'Inter-SemiBold',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Trending Text
                          const Text(
                            'Trending',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Inter-Bold',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Grid kısmı artık ScrollView içinde olduğu için Expanded'dan çıkarıyoruz
                          GridView.builder(
                            shrinkWrap: true, // Önemli!
                            physics: const NeverScrollableScrollPhysics(), // Önemli!
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: childAspectRatio,
                              crossAxisSpacing: isTablet ? 24 : 16,
                              mainAxisSpacing: isTablet ? 24 : 16,
                            ),
                            itemCount: trendingSongs.length,
                            itemBuilder: (context, index) {
                              final song = trendingSongs[index];
                              return GestureDetector(
                                onTap: () {
                                  // ViewModel'e seçilen şarkıyı bildir
                                  context.read<SongViewModel>().selectSong(song);
                                  // PlaySong sayfasına yönlendir
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaySongPage(songId: song.id),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.backgroundColor,
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(8),
                                          ),
                                          child: Image.asset(
                                            song.imagePath,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(isLandscape ? 4 : 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            
                                            children: [
                                              Text(
                                                song.title,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: isLandscape ? 11 : 13,
                                                  fontFamily: 'Inter-Bold',
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                song.artist,
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: isLandscape ? 9 : 10,
                                                  fontFamily: 'Inter-Medium',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem({IconData? iconData, Widget? iconWidget, required String label, required bool isActive}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconWidget ?? Icon(iconData, color: isActive ? Colors.white : Colors.white54),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white54,
            fontSize: 12,
            fontFamily: 'Inter-Medium',
          ),
        ),
      ],
    );
  }
}
