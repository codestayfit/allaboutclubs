class ClubData {
  final String id, name, country, image;
  final int value, europeanTitles;
  final Map<String, dynamic> stadium, location;

  const ClubData({
    required this.id,
    required this.name,
    required this.country,
    required this.image,
    required this.value,
    required this.europeanTitles,
    required this.stadium,
    required this.location,
  });

  factory ClubData.fromJson(Map<String, dynamic> json) {
    return ClubData(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      country: json['country'] ?? "",
      image: json['image'] ?? "",
      value: json['value'] ?? "",
      europeanTitles: json['european_titles'] ?? "",
      stadium: json['stadium'] ?? "",
      location: json['location'] ?? "",
    );
  }
}
