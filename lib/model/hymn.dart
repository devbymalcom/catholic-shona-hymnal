const String hymnalTable = 'shona_hymnal';

class HymnFields {
  static final List<String> values = [
    hymnNumber,
    isFavorite,
    hymnTitle,
    hymnLyrics,
    hymnAuthor,
    hymnCategory
  ];
  static const String hymnNumber = 'hymnNumber';
  static const String isFavorite = 'isFavorite';
  static const String hymnTitle = 'hymnTitle';
  static const String hymnLyrics = 'hymnLyrics';
  static const String hymnAuthor = 'hymnAuthor';
  static const String hymnCategory = 'hymnCategory';
}

class Hymn {
  final int hymnNumber;
  final String hymnTitle;
  final String hymnLyrics;
  final String hymnAuthor;
  final String hymnCategory;
  bool isFavorite;

  Hymn({
    required this.hymnNumber,
    required this.hymnTitle,
    required this.hymnLyrics,
    this.isFavorite = false,
    required this.hymnAuthor,
    required this.hymnCategory,
  });

  @override
  String toString() {
    return '{hymnNumber: $hymnNumber, hymnTitle: $hymnTitle, hymnLyrics: $hymnLyrics, hymnAuthor: $hymnAuthor, hymnCategory$hymnCategory, isFavorite: $isFavorite}';
  }

  factory Hymn.fromMap(Map<String, dynamic> json) => Hymn(
      hymnNumber: json['hymnNumber'],
      isFavorite: json['isFavorite'] == 1 ? true : false,
      hymnTitle: json['hymnTitle'],
      hymnLyrics: json['hymnLyrics'],
      hymnAuthor: json['hymnAuthor'],
      hymnCategory: json['hymnCategory']);

  Map<String, Object> toMap() => {
        'hymnNumber': hymnNumber,
        'hymnTitle': hymnTitle,
        'isFavorite': isFavorite ? 1 : 0,
        'hymnLyrics': hymnLyrics,
        'hymnAuthor': hymnAuthor,
        'hymnCategory': hymnCategory
      };
}

List<Hymn> offlineFetchedList = [];
