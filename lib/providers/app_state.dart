import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../models/user_model.dart';
import '../models/survey_model.dart';
import '../services/video_service.dart';
import '../services/storage_service.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/database_helper.dart';

class AppState extends ChangeNotifier {
  final VideoService _videoService = VideoService();
  final StorageService _storageService = StorageService();
  final AuthService _authService = AuthService.instance;
  final FirestoreService _firestoreService = FirestoreService.instance;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  String _preferredLanguage = 'en';
  List<String> _savedVideoIds = [];
  List<String> _completedVideoIds = [];
  UserModel? _currentUser;
  bool _isLoading = true;
  bool _isInitialized = false;

  String get preferredLanguage => _preferredLanguage;
  List<String> get savedVideoIds => _savedVideoIds;
  List<String> get completedVideoIds => _completedVideoIds;
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  List<VideoModel> get allVideos => _videoService.getAllVideos();
  List<String> get categories => _videoService.getCategories();

  Future<void> init() async {
    if (_isInitialized) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _dbHelper.database;
      await _storageService.init();
      await _authService.initialize();
      _currentUser = _authService.currentUser;

      if (_currentUser != null) {
        _preferredLanguage = _currentUser!.preferredLanguage;
        _savedVideoIds = List<String>.from(_currentUser!.savedVideoIds);
        _completedVideoIds = List<String>.from(_currentUser!.completedVideoIds);

        try {
          await _firestoreService.initDefaultVideos();
          final cloudUser = await _firestoreService.getUser(_currentUser!.id);
          if (cloudUser != null) {
            _savedVideoIds = List<String>.from(cloudUser.savedVideoIds);
            _completedVideoIds = List<String>.from(cloudUser.completedVideoIds);
            _preferredLanguage = cloudUser.preferredLanguage;
            _currentUser = cloudUser;
          }
        } catch (e) {
          debugPrint('Cloud sync error: $e');
        }
      } else {
        _savedVideoIds = await _storageService.getSavedVideoIds();
        _completedVideoIds = await _storageService.getCompletedVideoIds();
        _preferredLanguage = await _storageService.getPreferredLanguage();
      }

      _isInitialized = true;
    } catch (e) {
      debugPrint('Init error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      final user = await _authService.signInWithEmailPassword(email, password);
      _currentUser = user;

      try {
        final cloudUser = await _firestoreService.getUser(user.id);
        if (cloudUser != null) {
          _savedVideoIds = List<String>.from(cloudUser.savedVideoIds);
          _completedVideoIds = List<String>.from(cloudUser.completedVideoIds);
          _preferredLanguage = cloudUser.preferredLanguage;
          _currentUser = cloudUser.copyWith(email: user.email, name: user.name);
        } else {
          await _firestoreService.createUser(user);
          _savedVideoIds = [];
          _completedVideoIds = [];
          _preferredLanguage = 'en';
        }
      } catch (e) {
        debugPrint('Cloud sync error: $e');
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUpWithEmail(
    String email,
    String password, {
    String? name,
  }) async {
    try {
      final user = await _authService.signUpWithEmailPassword(
        email,
        password,
        name: name,
      );
      _currentUser = user;

      try {
        await _firestoreService.createUser(user);
      } catch (e) {
        debugPrint('Cloud sync error: $e');
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _syncToLocal();
      await _authService.signOut();
      _currentUser = null;
      _savedVideoIds = [];
      _completedVideoIds = [];
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    await _authService.resetPassword(email);
  }

  Future<void> setLanguage(String languageCode) async {
    _preferredLanguage = languageCode;
    await _storageService.setPreferredLanguage(languageCode);

    if (_currentUser != null) {
      try {
        await _firestoreService.updatePreferredLanguage(
          _currentUser!.id,
          languageCode,
        );
      } catch (e) {
        debugPrint('Cloud sync error: $e');
      }
    }

    notifyListeners();
  }

  Future<void> _syncToLocal() async {
    if (_currentUser == null) return;

    for (var videoId in _savedVideoIds) {
      await _storageService.saveVideo(videoId);
    }

    for (var videoId in _completedVideoIds) {
      await _storageService.markVideoCompleted(videoId);
    }
  }

  List<VideoModel> getSavedVideos() {
    return allVideos.where((v) => _savedVideoIds.contains(v.id)).toList();
  }

  List<VideoModel> getCompletedVideos() {
    return allVideos.where((v) => _completedVideoIds.contains(v.id)).toList();
  }

  Future<void> toggleSaveVideo(String videoId) async {
    final isCurrentlySaved = _savedVideoIds.contains(videoId);

    if (isCurrentlySaved) {
      _savedVideoIds.remove(videoId);
      await _storageService.unsaveVideo(videoId);
      if (_currentUser != null) {
        try {
          await _firestoreService.unsaveVideo(_currentUser!.id, videoId);
        } catch (e) {
          debugPrint('Cloud sync error: $e');
        }
      }
    } else {
      _savedVideoIds.add(videoId);
      await _storageService.saveVideo(videoId);
      if (_currentUser != null) {
        try {
          await _firestoreService.saveVideo(_currentUser!.id, videoId);
        } catch (e) {
          debugPrint('Cloud sync error: $e');
        }
      }
    }
    notifyListeners();
  }

  bool isVideoSaved(String videoId) {
    return _savedVideoIds.contains(videoId);
  }

  Future<void> markVideoCompleted(String videoId) async {
    if (!_completedVideoIds.contains(videoId)) {
      _completedVideoIds.add(videoId);
      await _storageService.markVideoCompleted(videoId);
      if (_currentUser != null) {
        try {
          await _firestoreService.markVideoCompleted(_currentUser!.id, videoId);
        } catch (e) {
          debugPrint('Cloud sync error: $e');
        }
      }
      notifyListeners();
    }
  }

  bool isVideoCompleted(String videoId) {
    return _completedVideoIds.contains(videoId);
  }

  Future<void> saveSurveyResult(SurveyResult result) async {
    if (_currentUser != null) {
      try {
        await _firestoreService.saveSurveyResult(_currentUser!.id, result);
      } catch (e) {
        debugPrint('Cloud sync error: $e');
      }
    }
  }

  List<VideoModel> searchVideos(String query) {
    return _videoService.searchVideos(query);
  }

  List<VideoModel> getVideosByCategory(String category) {
    return _videoService.getVideosByCategory(category);
  }

  VideoModel? getVideoById(String id) {
    return _videoService.getVideoById(id);
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? profileImage,
    String? village,
    String? district,
  }) async {
    if (_currentUser == null) return;

    _currentUser = _currentUser!.copyWith(
      name: name ?? _currentUser!.name,
      phone: phone ?? _currentUser!.phone,
      profileImage: profileImage ?? _currentUser!.profileImage,
    );

    await _storageService.saveUserData(_currentUser!.toMap());

    try {
      await _firestoreService.updateUserProfile(
        _currentUser!.id,
        name: name,
        phone: phone,
        profileImage: profileImage,
        village: village,
        district: district,
      );
    } catch (e) {
      debugPrint('Cloud sync error: $e');
    }

    notifyListeners();
  }
}
