import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/video_model.dart';
import '../models/survey_model.dart';
import '../models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('digital_saathi.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT UNIQUE,
        phone TEXT,
        preferred_language TEXT DEFAULT 'en',
        created_at TEXT,
        profile_image TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE videos (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        title_te TEXT,
        category TEXT,
        views TEXT,
        time TEXT,
        duration TEXT,
        description TEXT,
        description_te TEXT,
        video_url TEXT,
        thumbnail_url TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE saved_videos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT,
        video_id TEXT,
        saved_at TEXT,
        FOREIGN KEY (video_id) REFERENCES videos (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE completed_videos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT,
        video_id TEXT,
        completed_at TEXT,
        watch_duration INTEGER DEFAULT 0,
        FOREIGN KEY (video_id) REFERENCES videos (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE survey_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT,
        total_questions INTEGER,
        correct_answers INTEGER,
        score_percentage REAL,
        literacy_level TEXT,
        completed_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE quiz_scores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT,
        video_id TEXT,
        score INTEGER,
        max_score INTEGER,
        attempted_at TEXT
      )
    ''');

    await _insertSampleVideos(db);
  }

  Future<void> _insertSampleVideos(Database db) async {
    final videos = [
      {
        'id': '1',
        'title': 'Google Classroom Basics',
        'title_te': 'గూగుల్ క్లాస్‌రూమ్ మౌలికాలు',
        'category': 'Education',
        'views': '1.2k',
        'time': '3 days ago',
        'duration': '5:30',
        'description':
            'Learn how to use Google Classroom for online studies. This guide covers account setup, joining classes, submitting assignments, and attending live sessions.',
        'description_te':
            'ఆన్‌లైన్ చదువుల కోసం గూగుల్ క్లాస్‌రూమ్ వాడకం నేర్చుకోండి.',
        'video_url':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      },
      {
        'id': '2',
        'title': 'Online Safety for Students',
        'title_te': 'విద్యార్థులకు ఆన్‌లైన్ భద్రత',
        'category': 'Online Safety',
        'views': '980',
        'time': '5 days ago',
        'duration': '4:15',
        'description':
            'Stay safe online and protect your personal information. Learn about strong passwords, recognizing scams, and safe browsing practices.',
        'description_te':
            'ఆన్‌లైన్‌లో సురక్షితంగా ఉండండి మరియు మీ వ్యక్తిగత సమాచారాన్ని రక్షించుకోండి.',
        'video_url':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      },
      {
        'id': '3',
        'title': 'UPI Payment Guide',
        'title_te': 'UPI చెల్లింపు మార్గదర్శి',
        'category': 'UPI & Payments',
        'views': '2.1k',
        'time': '1 day ago',
        'duration': '6:45',
        'description':
            'Step by step guide to make payments using UPI apps like Google Pay, PhonePe, and Paytm.',
        'description_te':
            'UPI యాప్స్ ఉపయోగించి చెల్లింపులు ఎలా చేయాలో నేర్చుకోండి.',
        'video_url':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      },
      {
        'id': '4',
        'title': 'WhatsApp Basics',
        'title_te': 'వాట్సాప్ మౌలికాలు',
        'category': 'Mobile Info',
        'views': '3.4k',
        'time': '2 days ago',
        'duration': '7:20',
        'description':
            'Learn to send messages, images and make calls on WhatsApp.',
        'description_te': 'WhatsApp లో మెసేజ్‌లు, ఫోటోలు పంపడం నేర్చుకోండి.',
        'video_url':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      },
      {
        'id': '5',
        'title': 'Government Schemes Guide',
        'title_te': 'ప్రభుత్వ పథకాల మార్గదర్శి',
        'category': 'Government',
        'views': '1.5k',
        'time': '4 days ago',
        'duration': '8:10',
        'description':
            'Know about PM Jan Dhan, Ayushman Bharat and other government schemes.',
        'description_te': 'ప్రభుత్వ పథకాల గురించి తెలుసుకోండి.',
        'video_url':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      },
      {
        'id': '6',
        'title': 'Manage Contacts and Calls',
        'title_te': 'కాంటాక్ట్లు మరియు కాల్స్ నిర్వహణ',
        'category': 'Mobile Info',
        'views': '1.1k',
        'time': '3 days ago',
        'duration': '4:50',
        'description':
            'Learn how to manage contacts and make calls on your phone.',
        'description_te':
            'మీ ఫోన్‌లో కాంటాక్ట్లు మరియు కాల్స్ ఎలా నిర్వహించాలో నేర్చుకోండి.',
        'video_url':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      },
      {
        'id': '7',
        'title': 'Install Apps from Play Store',
        'title_te': 'ప్లే స్టోర్ నుండి యాప్స్ ఇన్‌స్టాల్',
        'category': 'Mobile Info',
        'views': '2.8k',
        'time': '6 days ago',
        'duration': '3:45',
        'description': 'How to search and install apps from Google Play Store.',
        'description_te':
            'గూగుల్ ప్లే స్టోర్ నుండి యాప్స్ ఎలా ఇన్‌స్టాల్ చేయాలో నేర్చుకోండి.',
        'video_url':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
      },
      {
        'id': '8',
        'title': 'Online Fraud Awareness',
        'title_te': 'ఆన్‌లైన్ మోసాల అవగాహన',
        'category': 'Online Safety',
        'views': '1.9k',
        'time': '2 days ago',
        'duration': '9:00',
        'description': 'Protect yourself from online fraud and scams.',
        'description_te': 'ఆన్‌లైన్ మోసాల నుండి మిమ్మల్ని రక్షించుకోండి.',
        'video_url':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      },
      {
        'id': '9',
        'title': 'Aadhaar Card Online Services',
        'title_te': 'ఆధార్ కార్డ్ ఆన్‌లైన్ సర్వీసెస్',
        'category': 'Government',
        'views': '2.3k',
        'time': '5 days ago',
        'duration': '6:00',
        'description': 'Learn to use UIDAI portal for Aadhaar services.',
        'description_te':
            'ఆధార్ సర్వీసెస్ కోసం UIDAI పోర్టల్ ఉపయోగించడం నేర్చుకోండి.',
        'video_url':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
      },
      {
        'id': '10',
        'title': 'Healthcare Apps Tutorial',
        'title_te': 'హెల్త్‌కేర్ యాప్స్ ట్యుటోరియల్',
        'category': 'Healthcare',
        'views': '1.3k',
        'time': '1 day ago',
        'duration': '5:15',
        'description':
            'Learn to use health apps for booking appointments, ordering medicines, and consulting doctors online.',
        'description_te': 'హెల్త్ యాప్స్ ఉపయోగించడం నేర్చుకోండి.',
        'video_url':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
      },
    ];

    for (var video in videos) {
      await db.insert('videos', video);
    }
  }

  Future<UserModel?> getUser(String id) async {
    final db = await database;
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<void> insertUser(UserModel user) async {
    final db = await database;
    await db.insert('users', {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'preferred_language': user.preferredLanguage,
      'created_at': DateTime.now().toIso8601String(),
      'profile_image': user.profileImage,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateUser(UserModel user) async {
    final db = await database;
    await db.update(
      'users',
      {
        'name': user.name,
        'phone': user.phone,
        'preferred_language': user.preferredLanguage,
        'profile_image': user.profileImage,
      },
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<List<VideoModel>> getAllVideos() async {
    final db = await database;
    final maps = await db.query('videos');
    return maps.map((map) => VideoModel.fromMapSQLite(map)).toList();
  }

  Future<VideoModel?> getVideoById(String id) async {
    final db = await database;
    final maps = await db.query('videos', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return VideoModel.fromMapSQLite(maps.first);
    }
    return null;
  }

  Future<List<VideoModel>> getVideosByCategory(String category) async {
    final db = await database;
    if (category == 'All') {
      return getAllVideos();
    }
    final maps = await db.query(
      'videos',
      where: 'category = ?',
      whereArgs: [category],
    );
    return maps.map((map) => VideoModel.fromMapSQLite(map)).toList();
  }

  Future<void> saveVideo(String userId, String videoId) async {
    final db = await database;
    await db.insert('saved_videos', {
      'user_id': userId,
      'video_id': videoId,
      'saved_at': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<void> unsaveVideo(String userId, String videoId) async {
    final db = await database;
    await db.delete(
      'saved_videos',
      where: 'user_id = ? AND video_id = ?',
      whereArgs: [userId, videoId],
    );
  }

  Future<List<String>> getSavedVideoIds(String userId) async {
    final db = await database;
    final maps = await db.query(
      'saved_videos',
      columns: ['video_id'],
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return maps.map((m) => m['video_id'] as String).toList();
  }

  Future<bool> isVideoSaved(String userId, String videoId) async {
    final db = await database;
    final maps = await db.query(
      'saved_videos',
      where: 'user_id = ? AND video_id = ?',
      whereArgs: [userId, videoId],
    );
    return maps.isNotEmpty;
  }

  Future<void> markVideoCompleted(String userId, String videoId) async {
    final db = await database;
    await db.insert('completed_videos', {
      'user_id': userId,
      'video_id': videoId,
      'completed_at': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<String>> getCompletedVideoIds(String userId) async {
    final db = await database;
    final maps = await db.query(
      'completed_videos',
      columns: ['video_id'],
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return maps.map((m) => m['video_id'] as String).toList();
  }

  Future<void> saveSurveyResult(String userId, SurveyResult result) async {
    final db = await database;
    await db.insert('survey_results', {
      'user_id': userId,
      'total_questions': result.totalQuestions,
      'correct_answers': result.correctAnswers,
      'score_percentage': result.scorePercentage,
      'literacy_level': result.literacyLevel,
      'completed_at': result.completedAt.toIso8601String(),
    });
  }

  Future<List<SurveyResult>> getSurveyResults(String userId) async {
    final db = await database;
    final maps = await db.query(
      'survey_results',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'completed_at DESC',
    );
    return maps.map((map) => SurveyResult.fromMapSQLite(map)).toList();
  }

  Future<void> saveQuizScore(
    String userId,
    String videoId,
    int score,
    int maxScore,
  ) async {
    final db = await database;
    await db.insert('quiz_scores', {
      'user_id': userId,
      'video_id': videoId,
      'score': score,
      'max_score': maxScore,
      'attempted_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }

  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'digital_saathi.db');
    await databaseFactory.deleteDatabase(path);
  }
}
