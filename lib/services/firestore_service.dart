import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/video_model.dart';
import '../models/survey_model.dart';

class FirestoreService {
  static final FirestoreService instance = FirestoreService._init();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirestoreService._init();

  CollectionReference get _usersCollection => _firestore.collection('users');
  CollectionReference get _videosCollection => _firestore.collection('videos');
  CollectionReference get _surveyResultsCollection =>
      _firestore.collection('survey_results');

  Future<void> initDefaultVideos() async {
    final videosSnapshot = await _videosCollection.limit(1).get();
    if (videosSnapshot.docs.isEmpty) {
      await _addDefaultVideos();
    }
  }

  Future<void> _addDefaultVideos() async {
    final videos = [
      {
        'id': '1',
        'title': 'Google Classroom Basics',
        'titleTe': 'గూగుల్ క్లాస్‌రూమ్ మౌలికాలు',
        'category': 'Education',
        'views': '1.2k',
        'time': '3 days ago',
        'duration': '5:30',
        'description': 'Learn how to use Google Classroom for online studies.',
        'descriptionTe':
            'ఆన్‌లైన్ చదువుల కోసం గూగుల్ క్లాస్‌రూమ్ వాడకం నేర్చుకోండి.',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      },
      {
        'id': '2',
        'title': 'Online Safety for Students',
        'titleTe': 'విద్యార్థులకు ఆన్‌లైన్ భద్రత',
        'category': 'Online Safety',
        'views': '980',
        'time': '5 days ago',
        'duration': '4:15',
        'description':
            'Stay safe online and protect your personal information.',
        'descriptionTe': 'ఆన్‌లైన్‌లో సురక్షితంగా ఉండండి.',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      },
      {
        'id': '3',
        'title': 'UPI Payment Guide',
        'titleTe': 'UPI చెల్లింపు మార్గదర్శి',
        'category': 'UPI & Payments',
        'views': '2.1k',
        'time': '1 day ago',
        'duration': '6:45',
        'description': 'Step by step guide to make payments using UPI apps.',
        'descriptionTe': 'UPI యాప్స్ ఉపయోగించి చెల్లింపులు ఎలా చేయాలో.',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      },
      {
        'id': '4',
        'title': 'WhatsApp Basics',
        'titleTe': 'వాట్సాప్ మౌలికాలు',
        'category': 'Mobile Info',
        'views': '3.4k',
        'time': '2 days ago',
        'duration': '7:20',
        'description':
            'Learn to send messages, images and make calls on WhatsApp.',
        'descriptionTe': 'WhatsApp లో మెసేజ్‌లు, ఫోటోలు పంపడం.',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      },
      {
        'id': '5',
        'title': 'Government Schemes Guide',
        'titleTe': 'ప్రభుత్వ పథకాల మార్గదర్శి',
        'category': 'Government',
        'views': '1.5k',
        'time': '4 days ago',
        'duration': '8:10',
        'description':
            'Know about PM Jan Dhan, Ayushman Bharat and other schemes.',
        'descriptionTe': 'ప్రభుత్వ పథకాల గురించి.',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      },
      {
        'id': '6',
        'title': 'Manage Contacts and Calls',
        'titleTe': 'కాంటాక్ట్లు మరియు కాల్స్',
        'category': 'Mobile Info',
        'views': '1.1k',
        'time': '3 days ago',
        'duration': '4:50',
        'description': 'Learn how to manage contacts and make calls.',
        'descriptionTe': 'కాంటాక్ట్లు మరియు కాల్స్ నిర్వహణ.',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      },
      {
        'id': '7',
        'title': 'Install Apps from Play Store',
        'titleTe': 'ప్లే స్టోర్ నుండి యాప్స్',
        'category': 'Mobile Info',
        'views': '2.8k',
        'time': '6 days ago',
        'duration': '3:45',
        'description': 'How to search and install apps from Google Play Store.',
        'descriptionTe': 'ప్లే స్టోర్ నుండి యాప్స్ ఇన్‌స్టాల్.',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
      },
      {
        'id': '8',
        'title': 'Online Fraud Awareness',
        'titleTe': 'ఆన్‌లైన్ మోసాల అవగాహన',
        'category': 'Online Safety',
        'views': '1.9k',
        'time': '2 days ago',
        'duration': '9:00',
        'description': 'Protect yourself from online fraud and scams.',
        'descriptionTe': 'ఆన్‌లైన్ మోసాల నుండి రక్షణ.',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      },
    ];

    for (var video in videos) {
      await _videosCollection.doc(video['id']).set(video);
    }
  }

  Future<void> createUser(UserModel user) async {
    await _usersCollection.doc(user.id).set(user.toFirestore());
  }

  Future<void> updateUser(UserModel user) async {
    await _usersCollection.doc(user.id).update(user.toFirestore());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await _usersCollection.doc(userId).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromFirestore(_convertToMap(doc.data()!));
    }
    return null;
  }

  Future<List<VideoModel>> getAllVideos() async {
    final snapshot = await _videosCollection.get();
    return snapshot.docs.map((doc) {
      return VideoModel.fromFirestore(_convertToMap(doc.data()!));
    }).toList();
  }

  Future<List<VideoModel>> getVideosByCategory(String category) async {
    final snapshot = await _videosCollection
        .where('category', isEqualTo: category)
        .get();
    return snapshot.docs.map((doc) {
      return VideoModel.fromFirestore(_convertToMap(doc.data()!));
    }).toList();
  }

  Map<String, dynamic> _convertToMap(Object data) {
    return Map<String, dynamic>.from(data as Map);
  }

  Future<void> saveVideoProgress(
    String userId,
    String videoId, {
    bool completed = false,
    bool saved = false,
  }) async {
    final userRef = _usersCollection.doc(userId);

    if (saved) {
      await userRef.update({
        'savedVideoIds': FieldValue.arrayUnion([videoId]),
      });
    } else {
      await userRef.update({
        'savedVideoIds': FieldValue.arrayRemove([videoId]),
      });
    }

    if (completed) {
      await userRef.update({
        'completedVideoIds': FieldValue.arrayUnion([videoId]),
      });
    }
  }

  Future<void> unsaveVideo(String userId, String videoId) async {
    await _usersCollection.doc(userId).update({
      'savedVideoIds': FieldValue.arrayRemove([videoId]),
    });
  }

  Future<void> saveVideo(String userId, String videoId) async {
    await _usersCollection.doc(userId).set({
      'savedVideoIds': FieldValue.arrayUnion([videoId]),
    }, SetOptions(merge: true));
  }

  Future<void> markVideoCompleted(String userId, String videoId) async {
    await _usersCollection.doc(userId).set({
      'completedVideoIds': FieldValue.arrayUnion([videoId]),
    }, SetOptions(merge: true));
  }

  Future<void> saveSurveyResult(String userId, SurveyResult result) async {
    await _surveyResultsCollection.add({
      'userId': userId,
      ...result.toFirestore(),
    });

    await _usersCollection.doc(userId).update({
      'lastSurveyResult': result.toFirestore(),
    });
  }

  Future<List<SurveyResult>> getSurveyResults(String userId) async {
    final snapshot = await _surveyResultsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .get();
    return snapshot.docs.map((doc) {
      return SurveyResult.fromFirestore(_convertToMap(doc.data()!));
    }).toList();
  }

  Future<void> updatePreferredLanguage(
    String userId,
    String languageCode,
  ) async {
    await _usersCollection.doc(userId).update({
      'preferredLanguage': languageCode,
    });
  }

  Future<void> updateUserProfile(
    String userId, {
    String? name,
    String? phone,
    String? profileImage,
    String? village,
    String? district,
  }) async {
    final updates = <String, dynamic>{};

    if (name != null) updates['name'] = name;
    if (phone != null) updates['phone'] = phone;
    if (profileImage != null) updates['profileImage'] = profileImage;
    if (village != null) updates['village'] = village;
    if (district != null) updates['district'] = district;

    if (updates.isNotEmpty) {
      await _usersCollection.doc(userId).update(updates);
    }
  }

  Future<void> syncLocalDataToCloud(
    String userId, {
    List<String>? savedVideoIds,
    List<String>? completedVideoIds,
    String? preferredLanguage,
  }) async {
    final updates = <String, dynamic>{};

    if (savedVideoIds != null) {
      updates['savedVideoIds'] = savedVideoIds;
    }
    if (completedVideoIds != null) {
      updates['completedVideoIds'] = completedVideoIds;
    }
    if (preferredLanguage != null) {
      updates['preferredLanguage'] = preferredLanguage;
    }

    if (updates.isNotEmpty) {
      await _usersCollection.doc(userId).update(updates);
    }
  }
}
