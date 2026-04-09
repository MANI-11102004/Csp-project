class UserModel {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String? profileImage;
  final String? village;
  final String? district;
  final String preferredLanguage;
  final DateTime? createdAt;
  final List<String> completedVideoIds;
  final List<String> savedVideoIds;
  final Map<String, int>? quizScores;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.profileImage,
    this.village,
    this.district,
    this.preferredLanguage = 'en',
    this.createdAt,
    this.completedVideoIds = const [],
    this.savedVideoIds = const [],
    this.quizScores,
  });

  String get displayName => name ?? email?.split('@').first ?? 'User';
  String get initials =>
      displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'village': village,
      'district': district,
      'preferredLanguage': preferredLanguage,
      'createdAt': createdAt?.toIso8601String(),
      'completedVideoIds': completedVideoIds,
      'savedVideoIds': savedVideoIds,
      'quizScores': quizScores,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      profileImage: map['profileImage'] as String?,
      village: map['village'] as String?,
      district: map['district'] as String?,
      preferredLanguage: map['preferredLanguage'] as String? ?? 'en',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      completedVideoIds: List<String>.from(map['completedVideoIds'] ?? []),
      savedVideoIds: List<String>.from(map['savedVideoIds'] ?? []),
      quizScores: map['quizScores'] != null
          ? Map<String, int>.from(map['quizScores'] as Map)
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'village': village,
      'district': district,
      'preferredLanguage': preferredLanguage,
      'createdAt':
          createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'completedVideoIds': completedVideoIds,
      'savedVideoIds': savedVideoIds,
      'quizScores': quizScores,
    };
  }

  factory UserModel.fromFirestore(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      profileImage: map['profileImage'] as String?,
      village: map['village'] as String?,
      district: map['district'] as String?,
      preferredLanguage: map['preferredLanguage'] as String? ?? 'en',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      completedVideoIds: List<String>.from(map['completedVideoIds'] ?? []),
      savedVideoIds: List<String>.from(map['savedVideoIds'] ?? []),
      quizScores: map['quizScores'] != null
          ? Map<String, int>.from(map['quizScores'] as Map)
          : null,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    String? village,
    String? district,
    String? preferredLanguage,
    DateTime? createdAt,
    List<String>? completedVideoIds,
    List<String>? savedVideoIds,
    Map<String, int>? quizScores,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      village: village ?? this.village,
      district: district ?? this.district,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      createdAt: createdAt ?? this.createdAt,
      completedVideoIds: completedVideoIds ?? this.completedVideoIds,
      savedVideoIds: savedVideoIds ?? this.savedVideoIds,
      quizScores: quizScores ?? this.quizScores,
    );
  }
}
