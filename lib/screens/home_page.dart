import 'package:flutter/material.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const HomePage({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> sectors = [
    "Education",
    "General Mobile Info",
    "Government Services",
    "Digital Skills",
    "Financial Literacy",
    "Communication",
    "General Awareness"
  ];

  String selectedSector = "Education";
  String searchQuery = "";

  final Map<String, List<Map<String, String>>> videos = {};

  @override
  void initState() {
    super.initState();

    videos["Education"] = [
      {"title": "Basics of Reading and Writing", "thumbnail": "assets/images/education.jpg"},
      {"title": "How to Use Online Learning Apps", "thumbnail": "assets/images/education.jpg"},
      {"title": "Finding Free Education Resources", "thumbnail": "assets/images/education.jpg"},
      {"title": "Typing Skills for Beginners", "thumbnail": "assets/images/education.jpg"},
      {"title": "How to Attend Online Classes", "thumbnail": "assets/images/education.jpg"},
      {"title": "Using YouTube for Learning", "thumbnail": "assets/images/education.jpg"},
      {"title": "Improving English Skills", "thumbnail": "assets/images/education.jpg"},
      {"title": "Learning from PDFs & eBooks", "thumbnail": "assets/images/education.jpg"},
      {"title": "Time Management for Students", "thumbnail": "assets/images/education.jpg"},
      {"title": "Basics of Using Google Search", "thumbnail": "assets/images/education.jpg"},
    ];

    videos["General Mobile Info"] = [
      {"title": "How to Use a Smartphone", "thumbnail": "assets/images/mobile.jpg"},
      {"title": "Installing Mobile Apps", "thumbnail": "assets/images/mobile.jpg"},
      {"title": "Managing Contacts", "thumbnail": "assets/images/mobile.jpg"},
      {"title": "Using Camera and Gallery", "thumbnail": "assets/images/mobile.jpg"},
      {"title": "Setting Up Mobile Internet", "thumbnail": "assets/images/mobile.jpg"},
      {"title": "Using Google Maps", "thumbnail": "assets/images/mobile.jpg"},
      {"title": "How to Update Apps", "thumbnail": "assets/images/mobile.jpg"},
      {"title": "Saving Battery Life", "thumbnail": "assets/images/mobile.jpg"},
      {"title": "Basic Phone Troubleshooting", "thumbnail": "assets/images/mobile.jpg"},
      {"title": "How to Use Bluetooth", "thumbnail": "assets/images/mobile.jpg"},
    ];

    videos["Government Services"] = [
      {"title": "Applying for Ration Card Online", "thumbnail": "assets/images/government.jpg"},
      {"title": "How to Use DigiLocker", "thumbnail": "assets/images/government.jpg"},
      {"title": "Paying Electricity Bills Online", "thumbnail": "assets/images/government.jpg"},
      {"title": "Booking Gas Cylinder Online", "thumbnail": "assets/images/government.jpg"},
      {"title": "Applying for Pension", "thumbnail": "assets/images/government.jpg"},
      {"title": "Using Government Portals", "thumbnail": "assets/images/government.jpg"},
      {"title": "Checking Aadhaar Details", "thumbnail": "assets/images/government.jpg"},
      {"title": "Downloading Certificates Online", "thumbnail": "assets/images/government.jpg"},
      {"title": "Filing Complaints Online", "thumbnail": "assets/images/government.jpg"},
      {"title": "Applying for Birth Certificate", "thumbnail": "assets/images/government.jpg"},
    ];

    videos["Digital Skills"] = [
      {"title": "How to Create an Email Account", "thumbnail": "assets/images/digital.jpg"},
      {"title": "Sending and Receiving Emails", "thumbnail": "assets/images/digital.jpg"},
      {"title": "Using Social Media Safely", "thumbnail": "assets/images/digital.jpg"},
      {"title": "Online Safety Tips", "thumbnail": "assets/images/digital.jpg"},
      {"title": "Searching for Jobs Online", "thumbnail": "assets/images/digital.jpg"},
      {"title": "How to Join Zoom Meetings", "thumbnail": "assets/images/digital.jpg"},
      {"title": "Creating Documents in Google Docs", "thumbnail": "assets/images/digital.jpg"},
      {"title": "Using Cloud Storage", "thumbnail": "assets/images/digital.jpg"},
      {"title": "Basic Photo Editing on Mobile", "thumbnail": "assets/images/digital.jpg"},
      {"title": "Recording and Sharing Videos", "thumbnail": "assets/images/digital.jpg"},
    ];

    videos["Financial Literacy"] = [
      {"title": "Using UPI Payments", "thumbnail": "assets/images/finance.jpg"},
      {"title": "Checking Bank Balance Online", "thumbnail": "assets/images/finance.jpg"},
      {"title": "Avoiding Online Scams", "thumbnail": "assets/images/finance.jpg"},
      {"title": "Applying for Bank Loan", "thumbnail": "assets/images/finance.jpg"},
      {"title": "Using Net Banking", "thumbnail": "assets/images/finance.jpg"},
      {"title": "Understanding Interest Rates", "thumbnail": "assets/images/finance.jpg"},
      {"title": "Saving Money Effectively", "thumbnail": "assets/images/finance.jpg"},
      {"title": "Budget Planning Basics", "thumbnail": "assets/images/finance.jpg"},
      {"title": "Mobile Banking Safety", "thumbnail": "assets/images/finance.jpg"},
      {"title": "Investing for Beginners", "thumbnail": "assets/images/finance.jpg"},
    ];

    videos["Communication"] = [
      {"title": "How to Make Video Calls", "thumbnail": "assets/images/communication.jpg"},
      {"title": "Sending WhatsApp Messages", "thumbnail": "assets/images/communication.jpg"},
      {"title": "Using Telegram", "thumbnail": "assets/images/communication.jpg"},
      {"title": "Email Etiquette", "thumbnail": "assets/images/communication.jpg"},
      {"title": "Group Chat Basics", "thumbnail": "assets/images/communication.jpg"},
      {"title": "Using Social Media to Connect", "thumbnail": "assets/images/communication.jpg"},
      {"title": "Participating in Online Meetings", "thumbnail": "assets/images/communication.jpg"},
      {"title": "Creating a Group in WhatsApp", "thumbnail": "assets/images/communication.jpg"},
      {"title": "Sharing Photos & Videos", "thumbnail": "assets/images/communication.jpg"},
      {"title": "Making International Calls", "thumbnail": "assets/images/communication.jpg"},
    ];

    videos["General Awareness"] = [
      {"title": "How to Read News Online", "thumbnail": "assets/images/awareness.jpg"},
      {"title": "Weather Forecast Apps", "thumbnail": "assets/images/awareness.jpg"},
      {"title": "Job Search Websites", "thumbnail": "assets/images/awareness.jpg"},
      {"title": "Understanding Fake News", "thumbnail": "assets/images/awareness.jpg"},
      {"title": "Government Announcements", "thumbnail": "assets/images/awareness.jpg"},
      {"title": "Health Awareness Apps", "thumbnail": "assets/images/awareness.jpg"},
      {"title": "Election Info Online", "thumbnail": "assets/images/awareness.jpg"},
      {"title": "Online Job Fairs", "thumbnail": "assets/images/awareness.jpg"},
      {"title": "Travel Information Sites", "thumbnail": "assets/images/awareness.jpg"},
      {"title": "Daily Motivation Videos", "thumbnail": "assets/images/awareness.jpg"},
    ];
  }

  List<Map<String, String>> _getFilteredVideos() {
    if (searchQuery.isEmpty) {
      return videos[selectedSector] ?? [];
    }
    List<Map<String, String>> allVideos = videos.values.expand((v) => v).toList();
    return allVideos
        .where((video) => video["title"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedVideos = _getFilteredVideos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorial Videos"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SettingsPage(
                  isDarkMode: widget.isDarkMode,
                  onThemeChanged: widget.onThemeChanged,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search videos...",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (searchQuery.isEmpty)
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sectors.length,
                itemBuilder: (context, index) {
                  final sector = sectors[index];
                  final bool isSelected = sector == selectedSector;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSector = sector;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        sector,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedVideos.length,
              itemBuilder: (context, index) {
                final video = displayedVideos[index];
                return ListTile(
                  leading: Image.asset(
                    video["thumbnail"]!,
                    width: 120,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                  title: Text(video["title"]!),
                  subtitle: Text(searchQuery.isEmpty ? selectedSector : "Search Result"),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Play ${video["title"]}")),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
