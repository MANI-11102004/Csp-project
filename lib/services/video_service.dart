import '../models/video_model.dart';

class VideoService {
  static final List<Map<String, String>> _sampleVideos = [
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
          'ఆన్‌లైన్ చదువుల కోసం గూగుల్ క్లాస్‌రూమ్ వాడకం నేర్చుకోండి. ఖాతా సెటప్, క్లాసులో చేరడం, అసైన్‌మెంట్లు సబ్మిట్ చేయడం మరియు లైవ్ సెషన్స్ హాజరు కావడం ఈ గైడ్ కవర్ చేస్తుంది.',
      'videoUrl':
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
          'ఆన్‌లైన్‌లో సురక్షితంగా ఉండండి మరియు మీ వ్యక్తిగత సమాచారాన్ని రక్షించుకోండి. బలమైన పాస్‌వర్డ్‌లు, మోసాలను గుర్తించడం మరియు సురక్షిత బ్రౌజింగ్ పద్ధతుల గురించి నేర్చుకోండి.',
      'videoUrl':
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
          'Step by step guide to make payments using UPI apps like Google Pay, PhonePe, and Paytm. Learn to send money, pay bills, and scan QR codes.',
      'description_te':
          'UPI యాప్స్ ఉపయోగించి చెల్లింపులు ఎలా చేయాలో నేర్చుకోండి. గూగుల్ పే, ఫోన్‌పే మరియు పేటీఎమ్ లాంటి యాప్స్ గురించి ఈ గైడ్ చూసుకోండి.',
      'videoUrl':
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
          'Learn to send messages, images and make calls on WhatsApp. This tutorial covers text messages, voice notes, group chats, and video calls.',
      'description_te':
          'WhatsApp లో మెసేజ్‌లు, ఫోటోలు పంపడం నేర్చుకోండి. టెక్స్ట్ మెసేజ్‌లు, వాయిస్ నోట్స్, గ్రూప్ చాట్స్ మరియు వీడియో కాల్స్ ఈ ట్యుటోరియల్ కవర్ చేస్తుంది.',
      'videoUrl':
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
          'Know about PM Jan Dhan, Ayushman Bharat and other government schemes. Learn how to apply online and check your eligibility.',
      'description_te':
          'ప్రభుత్వ పథకాల గురించి తెలుసుకోండి. PM జన్ ధన్, ఆయుష్మాన్ భారత్ మరియు ఇతర పథకాలు గురించి ఈ గైడ్ చూడండి.',
      'videoUrl':
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
          'Learn how to manage contacts and make calls on your phone. Save contacts, create groups, and use speed dial features.',
      'description_te':
          'మీ ఫోన్‌లో కాంటాక్ట్లు మరియు కాల్స్ ఎలా నిర్వహించాలో నేర్చుకోండి. కాంటాక్ట్లు సేవ్ చేయడం, గ్రూప్‌లు క్రియేట్ చేయడం మరియు స్పీడ్ డయల్ ఫీచర్స్ ఉపయోగించడం నేర్చుకోండి.',
      'videoUrl':
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
      'description':
          'How to search and install apps from Google Play Store. Learn about app permissions and keeping your apps updated.',
      'description_te':
          'గూగుల్ ప్లే స్టోర్ నుండి యాప్స్ ఎలా ఇన్‌స్టాల్ చేయాలో నేర్చుకోండి. యాప్ పర్మిషన్స్ గురించి మరియు యాప్స్ అప్‌డేటెడ్‌గా ఉంచుకోవడం గురించి నేర్చుకోండి.',
      'videoUrl':
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
      'description':
          'Protect yourself from online fraud and scams. Learn to identify phishing attempts, fake calls, and OTP scams.',
      'description_te':
          'ఆన్‌లైన్ మోసాల నుండి మిమ్మల్ని రక్షించుకోండి. ఫిషింగ్ ప్రయత్నాలను గుర్తించడం, ఫేక్ కాల్స్ మరియు OTP మోసాల గురించి నేర్చుకోండి.',
      'videoUrl':
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
      'description':
          'Learn to use UIDAI portal for Aadhaar services. Download e-Aadhaar, update details, and check Aadhaar status online.',
      'description_te':
          'ఆధార్ సర్వీసెస్ కోసం UIDAI పోర్టల్ ఉపయోగించడం నేర్చుకోండి. ఇ-ఆధార్ డౌన్‌లోడ్, డీటెయిల్స్ అప్‌డేట్ మరియు ఆధార్ స్టేటస్ ఆన్‌లైన్ చెక్ చేయడం నేర్చుకోండి.',
      'videoUrl':
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
      'description_te':
          'అపాయింట్‌మెంట్‌లు బుక్ చేయడం, ఓషుధాలు ఆర్డర్ చేయడం మరియు ఆన్‌లైన్ డాక్టర్లను కన్సల్ట్ చేయడం కోసం హెల్త్ యాప్స్ ఉపయోగించడం నేర్చుకోండి.',
      'videoUrl':
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
    },
  ];

  List<VideoModel> getAllVideos() {
    return _sampleVideos.map((v) => VideoModel.fromMap(v)).toList();
  }

  VideoModel? getVideoById(String id) {
    try {
      final videoMap = _sampleVideos.firstWhere((v) => v['id'] == id);
      return VideoModel.fromMap(videoMap);
    } catch (e) {
      return null;
    }
  }

  List<VideoModel> getVideosByCategory(String category) {
    if (category == 'All') return getAllVideos();
    return _sampleVideos
        .where((v) => v['category'] == category)
        .map((v) => VideoModel.fromMap(v))
        .toList();
  }

  List<VideoModel> searchVideos(String query) {
    final lowerQuery = query.toLowerCase();
    return _sampleVideos
        .where(
          (v) =>
              v['title']!.toLowerCase().contains(lowerQuery) ||
              v['title_te']!.contains(query) ||
              v['category']!.toLowerCase().contains(lowerQuery),
        )
        .map((v) => VideoModel.fromMap(v))
        .toList();
  }

  List<String> getCategories() {
    return [
      'All',
      'Education',
      'Mobile Info',
      'Government',
      'UPI & Payments',
      'Online Safety',
      'Healthcare',
    ];
  }
}
