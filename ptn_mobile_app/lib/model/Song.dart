class Song {
  final int id;          // Şarkı ID'si
  final String title;    // Şarkı adı
  final String artist;   // Şarkıcı
  final String imagePath;  // Resim yolu

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.imagePath,
  });

  // JSON'dan model oluşturmak için factory constructor
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      imagePath: json['imagePath'] ?? '',
    );
  }

  // Modeli JSON'a çevirmek için method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'imagePath': imagePath,
    };
  }
}
