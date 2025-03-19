import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptn_mobile_app/utils/colors.dart';
import '../viewmodel/song_viewmodel.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class PlaySongPage extends StatefulWidget {
  final int songId;

  const PlaySongPage({Key? key, required this.songId}) : super(key: key);

  @override
  State<PlaySongPage> createState() => _PlaySongPageState();
}

class _PlaySongPageState extends State<PlaySongPage> {
  late PlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _initializeController();
  }

  void _initializeController() async {
    try {
      await controller.preparePlayer(
        path: "assets/your_audio_file.mp3", // Ses dosyanızın yolu
      );
    } catch (e) {
      print("Error initializing controller: $e");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongViewModel>(
      builder: (context, viewModel, child) {
        final song = viewModel.selectedSong;
        if (song == null) return const SizedBox();

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            centerTitle: true,
            title: const Text(
              'Now Playing',
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: 20,
                fontFamily: 'Inter-Bold',
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryTextColor),
            ),
          ),
          body: OrientationBuilder(
            builder: (context, orientation) {
              bool isPortrait = orientation == Orientation.portrait;

              return SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: isPortrait
                        ? _buildPortraitMode(song)
                        : _buildLandscapeMode(song),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPortraitMode(song) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = width * 0.75; // 4:3 oranı

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: width,
                height: height,
                child: Image.asset(
                  song.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildSongInfo(song),
            const SizedBox(height: 32),
            _buildProgressBar(),
            const SizedBox(height: 32),
            _buildControls(),
          ],
        );
      },
    );
  }

  Widget _buildLandscapeMode(song) {
    return Stack(
      children: [
        // Arka planı tam ekran resim
        Positioned.fill(
          child: Image.asset(
            song.imagePath,
            fit: BoxFit.cover,
          ),
        ),

        // Üzerine konumlandırılmış progress bar ve kontroller
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Column(
            children: [
              _buildProgressBar(),
              const SizedBox(height: 20),
              _buildControls(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSongInfo(song) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          song.title,
          style: const TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: 20,
            fontFamily: 'Inter-Bold',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          song.artist,
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: 14,
            fontFamily: 'Inter-Medium',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        SizedBox(
          height: 32,
          child: Row(
            children: List.generate(40, (index) {
              double height = index % 3 == 0
                  ? 24
                  : index % 2 == 0
                      ? 16
                      : 20;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: index / 40 < 0.7
                          ? AppColors.progressBarColor
                          : AppColors.progressBarInactiveColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '24:32',
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: 12,
              ),
            ),
            Text(
              '34:00',
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, color: AppColors.primaryTextColor, size: 32),
          onPressed: () {},
        ),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(32),
          ),
          child: const Icon(Icons.play_arrow, size: 32, color: Colors.white),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next, color: AppColors.primaryTextColor, size: 32),
          onPressed: () {},
        ),
      ],
    );
  }
}
