import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../video/video_player_screen.dart';
import '../saved/saved_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _selectedCategory = 'all';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<String> get categories => [
    'all',
    'education',
    'mobileInfo',
    'government',
    'upiPayments',
    'onlineSafety',
    'healthcare',
  ];

  String _getCategoryDisplayName(String key) {
    switch (key) {
      case 'all':
        return 'All';
      case 'education':
        return 'Education';
      case 'mobileInfo':
        return 'Mobile Info';
      case 'government':
        return 'Government';
      case 'upiPayments':
        return 'UPI & Payments';
      case 'onlineSafety':
        return 'Online Safety';
      case 'healthcare':
        return 'Healthcare';
      default:
        return key;
    }
  }

  final List<Map<String, String>> videos = [
    {
      'title': 'Google Classroom Basics',
      'title_te': 'గూగుల్ క్లాస్‌రూమ్ మౌలికాలు',
      'category': 'Education',
      'views': '1.2k',
      'time': '3 days ago',
      'duration': '5:30',
      'description': 'Learn how to use Google Classroom for online studies.',
      'description_te':
          'ఆన్‌లైన్ చదువుల కోసం గూగుల్ క్లాస్‌రూమ్ వాడకం నేర్చుకోండి.',
    },
    {
      'title': 'Online Safety for Students',
      'title_te': 'విద్యార్థులకు ఆన్‌లైన్ భద్రత',
      'category': 'Online Safety',
      'views': '980',
      'time': '5 days ago',
      'duration': '4:15',
      'description': 'Stay safe online and protect your personal information.',
      'description_te':
          'ఆన్‌లైన్‌లో సురక్షితంగా ఉండండి మరియు మీ వ్యక్తిగత సమాచారాన్ని రక్షించుకోండి.',
    },
    {
      'title': 'UPI Payment Guide',
      'title_te': 'UPI చెల్లింపు మార్గదర్శి',
      'category': 'UPI & Payments',
      'views': '2.1k',
      'time': '1 day ago',
      'duration': '6:45',
      'description': 'Step by step guide to make payments using UPI apps.',
      'description_te':
          'UPI యాప్స్ ఉపయోగించి చెల్లింపులు ఎలా చేయాలో నేర్చుకోండి.',
    },
    {
      'title': 'WhatsApp Basics',
      'title_te': 'వాట్సాప్ మౌలికాలు',
      'category': 'Mobile Info',
      'views': '3.4k',
      'time': '2 days ago',
      'duration': '7:20',
      'description':
          'Learn to send messages, images and make calls on WhatsApp.',
      'description_te': 'WhatsApp లో మెసేజ్‌లు, ఫోటోలు పంపడం నేర్చుకోండి.',
    },
    {
      'title': 'Government Schemes Guide',
      'title_te': 'ప్రభుత్వ పథకాల మార్గదర్శి',
      'category': 'Government',
      'views': '1.5k',
      'time': '4 days ago',
      'duration': '8:10',
      'description':
          'Know about PM Jan Dhan, Ayushman Bharat and other schemes.',
      'description_te': 'ప్రభుత్వ పథకాల గురించి తెలుసుకోండి.',
    },
    {
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
    },
    {
      'title': 'Install Apps from Play Store',
      'title_te': 'ప్లే స్టోర్ నుండి యాప్స్ ఇన్‌స్టాల్',
      'category': 'Mobile Info',
      'views': '2.8k',
      'time': '6 days ago',
      'duration': '3:45',
      'description': 'How to search and install apps from Google Play Store.',
      'description_te':
          'గూగుల్ ప్లే స్టోర్ నుండి యాప్స్ ఎలా ఇన్‌స్టాల్ చేయాలో నేర్చుకోండి.',
    },
    {
      'title': 'Online Fraud Awareness',
      'title_te': 'ఆన్‌లైన్ మోసాల అవగాహన',
      'category': 'Online Safety',
      'views': '1.9k',
      'time': '2 days ago',
      'duration': '9:00',
      'description': 'Protect yourself from online fraud and scams.',
      'description_te': 'ఆన్‌లైన్ మోసాల నుండి మిమ్మల్ని రక్షించుకోండి.',
    },
  ];

  List<Map<String, String>> get filteredVideos {
    return videos.where((video) {
      final matchesCategory =
          _selectedCategory == 'all' || video['category'] == _selectedCategory;
      final matchesSearch =
          _searchQuery.isEmpty ||
          video['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          video['title_te']!.contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeTab(),
          _buildSearchTab(),
          const SavedScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.primaryGreen,
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.gold,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'DS',
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Digital Saathi',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.translate, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() => _currentIndex = 3);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search videos...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primaryGreen,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final isSelected = _selectedCategory == cat;
                        return GestureDetector(
                          onTap: () {
                            setState(() => _selectedCategory = cat);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryGreen
                                  : AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryGreen
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Text(
                              _getCategoryDisplayName(cat),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textSecondary,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  filteredVideos.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Icon(
                                Icons.video_library_outlined,
                                size: 64,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'No videos found',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.78,
                              ),
                          itemCount: filteredVideos.length,
                          itemBuilder: (context, index) {
                            return _buildVideoCard(filteredVideos[index]);
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(Map<String, String> video) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(video: video),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.15),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.play_circle_filled,
                      size: 40,
                      color: AppColors.primaryGreen.withOpacity(0.7),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video['duration']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      video['category']!,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${video['views']} views • ${video['time']}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTab() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Videos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              autofocus: false,
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: 'Search videos...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryGreen,
                ),
                filled: true,
                fillColor: AppColors.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredVideos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No videos found',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredVideos.length,
                      itemBuilder: (context, index) {
                        final video = filteredVideos[index];
                        return ListTile(
                          leading: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.play_circle_outline,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                          title: Text(
                            video['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            video['category']!,
                            style: const TextStyle(
                              color: AppColors.primaryGreen,
                              fontSize: 12,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VideoPlayerScreen(video: video),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
