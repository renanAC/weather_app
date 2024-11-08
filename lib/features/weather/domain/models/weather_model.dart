class WeatherModel {
  String createdAt;
  String city;
  String avatar;
  String temperature;
  String description;
  String id;

  WeatherModel({
    required this.createdAt,
    required this.city,
    required this.avatar,
    required this.temperature,
    required this.description,
    required this.id,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      createdAt: json['createdAt'],
      city: json['city'],
      avatar: json['avatar'],
      temperature: json['temperature'],
      description: json['description'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'city': city,
      'avatar': avatar,
      'temperature': temperature,
      'description': description,
      'id': id,
    };
  }

  WeatherModel copyWith({
    String? createdAt,
    String? city,
    String? avatar,
    String? temperature,
    String? description,
    String? id,
  }) {
    return WeatherModel(
      createdAt: createdAt ?? this.createdAt,
      city: city ?? this.city,
      avatar: avatar ?? this.avatar,
      temperature: temperature ?? this.temperature,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }
}
