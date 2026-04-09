class VideoModel {
  final String id;
  final String title;
  final String titleTe;
  final String category;
  final String views;
  final String time;
  final String duration;
  final String description;
  final String descriptionTe;
  final String? thumbnailUrl;
  final String? videoUrl;

  VideoModel({
    required this.id,
    required this.title,
    required this.titleTe,
    required this.category,
    required this.views,
    required this.time,
    required this.duration,
    required this.description,
    required this.descriptionTe,
    this.thumbnailUrl,
    this.videoUrl,
  });

  factory VideoModel.fromMap(Map<String, String> map) {
    return VideoModel(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: map['title'] ?? '',
      titleTe: map['title_te'] ?? '',
      category: map['category'] ?? '',
      views: map['views'] ?? '0',
      time: map['time'] ?? '',
      duration: map['duration'] ?? '0:00',
      description: map['description'] ?? '',
      descriptionTe: map['description_te'] ?? '',
      thumbnailUrl: map['thumbnailUrl'],
      videoUrl: map['videoUrl'],
    );
  }

  factory VideoModel.fromMapSQLite(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      titleTe: map['title_te'] as String? ?? '',
      category: map['category'] as String? ?? '',
      views: map['views'] as String? ?? '0',
      time: map['time'] as String? ?? '',
      duration: map['duration'] as String? ?? '0:00',
      description: map['description'] as String? ?? '',
      descriptionTe: map['description_te'] as String? ?? '',
      thumbnailUrl: map['thumbnail_url'] as String?,
      videoUrl: map['video_url'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'titleTe': titleTe,
      'category': category,
      'views': views,
      'time': time,
      'duration': duration,
      'description': description,
      'descriptionTe': descriptionTe,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'titleTe': titleTe,
      'category': category,
      'views': views,
      'time': time,
      'duration': duration,
      'description': description,
      'descriptionTe': descriptionTe,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
    };
  }

  factory VideoModel.fromFirestore(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      titleTe: map['titleTe'] as String? ?? '',
      category: map['category'] as String? ?? '',
      views: map['views'] as String? ?? '0',
      time: map['time'] as String? ?? '',
      duration: map['duration'] as String? ?? '0:00',
      description: map['description'] as String? ?? '',
      descriptionTe: map['descriptionTe'] as String? ?? '',
      thumbnailUrl: map['thumbnailUrl'] as String?,
      videoUrl: map['videoUrl'] as String?,
    );
  }
}
