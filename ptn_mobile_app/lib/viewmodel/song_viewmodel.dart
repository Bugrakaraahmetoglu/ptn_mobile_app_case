import 'package:flutter/material.dart';
import '../model/Song.dart';

class SongViewModel extends ChangeNotifier {
  Song? _selectedSong;
  
  Song? get selectedSong => _selectedSong;
  
  void selectSong(Song song) {
    _selectedSong = song;
    notifyListeners();
  }
} 