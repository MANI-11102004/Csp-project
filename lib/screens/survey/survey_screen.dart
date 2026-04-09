import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/survey_model.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final List<SurveyQuestion> _questions = [
    SurveyQuestion(
      id: '1',
      question: 'What is UPI in digital payments?',
      questionTe: 'డిజిటల్ చెల్లింపులలో UPI అంటే ఏమిటి?',
      options: [
        'Unified Payment Interface',
        'Universal Payment Integration',
        'User Payment Information',
        'United Payment International',
      ],
      optionsTe: [
        'యూనిఫైడ్ పేమెంట్ ఇంటర్‌ఫేస్',
        'యూనివర్సల్ పేమెంట్ ఇంటిగ్రేషన్',
        'యూజర్ పేమెంట్ ఇన్ఫర్మేషన్',
        'యూనైటెడ్ పేమెంట్ ఇంటర్‌నేషనల్',
      ],
      correctAnswerIndex: 0,
    ),
    SurveyQuestion(
      id: '2',
      question: 'Which of these is a government digital service?',
      questionTe: 'వీటిలో ఏది ప్రభుత్వ డిజిటల్ సర్వీస్?',
      options: ['WhatsApp', 'DigiLocker', 'Instagram', 'Spotify'],
      optionsTe: ['వాట్సాప్', 'డిజిలాకర్', 'ఇన్‌స్టాగ్రామ్', 'స్పాటిఫై'],
      correctAnswerIndex: 1,
    ),
    SurveyQuestion(
      id: '3',
      question:
          'What should you do if you receive an OTP request from an unknown source?',
      questionTe: 'తెలియని మూలం నుండి OTP అభ్యర్థన వస్తే మీరు ఏమి చేయాలి?',
      options: [
        'Share it with family',
        'Never share it with anyone',
        'Post it on social media',
        'Delete your account',
      ],
      optionsTe: [
        'కుటుంబంతో పంచుకోండి',
        'ఎవరితోనూ పంచుకోకూడదు',
        'సోషల్ మీడియాలో పోస్ట్ చేయండి',
        'మీ ఖాతా తొలగించండి',
      ],
      correctAnswerIndex: 1,
    ),
    SurveyQuestion(
      id: '4',
      question: 'What is a strong password?',
      questionTe: 'బలమైన పాస్‌వర్డ్ అంటే ఏమిటి?',
      options: [
        'Your birth year',
        '12345678',
        'Mix of letters, numbers, and symbols',
        'Your phone number',
      ],
      optionsTe: [
        'మీ జన్మ సంవత్సరం',
        '12345678',
        'అక్షరాలు, సంఖ్యలు, చిహ్నాల మిశ్రమం',
        'మీ ఫోన్ నంబర్',
      ],
      correctAnswerIndex: 2,
    ),
    SurveyQuestion(
      id: '5',
      question: 'Which app is used for video calling?',
      questionTe: 'వీడియో కాలింగ్‌కు ఏ యాప్ ఉపయోగించబడుతుంది?',
      options: ['Calculator', 'WhatsApp', 'Notepad', 'Weather'],
      optionsTe: ['కాలిక్యులేటర్', 'వాట్సాప్', 'నోట్‌ప్యాడ్', 'వాతావరణం'],
      correctAnswerIndex: 1,
    ),
    SurveyQuestion(
      id: '6',
      question: 'What is Phishing?',
      questionTe: 'ఫిషింగ్ అంటే ఏమిటి?',
      options: [
        'A fishing sport',
        'Fraudulent attempt to steal personal information',
        'A type of mobile game',
        'An email service',
      ],
      optionsTe: [
        'ఒక ఫిషింగ్ ఆట',
        'వ్యక్తిగత సమాచారం చౌకబాటు చేయడానికి మోసపు ప్రయత్నం',
        'మొబైల్ గేమ్ రకం',
        'ఇమెయిల్ సర్వీస్',
      ],
      correctAnswerIndex: 1,
    ),
    SurveyQuestion(
      id: '7',
      question: 'What is the use of Aadhaar e-KYC?',
      questionTe: 'ఆధార్ ఇ-కెవైసీ ఏమిటి?',
      options: [
        'To watch movies',
        'To verify identity digitally',
        'To play games',
        'To edit photos',
      ],
      optionsTe: [
        'సినిమాలు చూడటానికి',
        'డిజిటల్‌గా గుర్తింపు ధృవీకరించడానికి',
        'గేమ్‌లు ఆడటానికి',
        'ఫోటోలు ఎడిట్ చేయడానికి',
      ],
      correctAnswerIndex: 1,
    ),
    SurveyQuestion(
      id: '8',
      question: 'Which of these is a safe practice for online transactions?',
      questionTe: 'వీటిలో ఏది ఆన్‌లైన్ లావాదేవీలకు సురక్షిత అభ్యాసం?',
      options: [
        'Use public WiFi',
        'Share payment details on social media',
        'Use official banking apps only',
        'Save passwords in browser',
      ],
      optionsTe: [
        'పబ్లిక్ వైఫై ఉపయోగించండి',
        'పేమెంట్ డీటెయిల్స్ సోషల్ మీడియాలో పంచండి',
        'అధికారిక బ్యాంకింగ్ యాప్స్ మాత్రమే ఉపయోగించండి',
        'బ్రౌజర్‌లో పాస్‌వర్డ్‌లు సేవ్ చేయండి',
      ],
      correctAnswerIndex: 2,
    ),
  ];

  int _currentQuestionIndex = 0;
  final Map<String, int> _answers = {};
  bool _showResults = false;

  int get _correctAnswers {
    int count = 0;
    _answers.forEach((questionId, selectedIndex) {
      final question = _questions.firstWhere((q) => q.id == questionId);
      if (question.correctAnswerIndex == selectedIndex) {
        count++;
      }
    });
    return count;
  }

  double get _scorePercentage {
    return (_correctAnswers / _questions.length) * 100;
  }

  String get _literacyLevel {
    if (_scorePercentage >= 80) return 'Advanced';
    if (_scorePercentage >= 60) return 'Intermediate';
    if (_scorePercentage >= 40) return 'Basic';
    return 'Beginner';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        title: const Text('Digital Literacy Survey'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showExitConfirmation(context),
        ),
      ),
      body: _showResults ? _buildResults() : _buildQuestionnaire(),
    );
  }

  Widget _buildQuestionnaire() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: (_currentQuestionIndex + 1) / _questions.length,
          backgroundColor: AppColors.primaryGreen.withOpacity(0.2),
          valueColor: const AlwaysStoppedAnimation<Color>(
            AppColors.primaryGreen,
          ),
          minHeight: 6,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                    style: const TextStyle(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _questions[_currentQuestionIndex].question,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _questions[_currentQuestionIndex].questionTe,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 24),
                ...List.generate(
                  _questions[_currentQuestionIndex].options.length,
                  (index) => _buildOptionTile(index),
                ),
              ],
            ),
          ),
        ),
        _buildNavigationButtons(),
      ],
    );
  }

  Widget _buildOptionTile(int index) {
    final question = _questions[_currentQuestionIndex];
    final isSelected = _answers[question.id] == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _answers[question.id] = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGreen.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryGreen
                    : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.options[index],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? AppColors.primaryGreen
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    question.optionsTe[index],
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected
                          ? AppColors.primaryGreen.withOpacity(0.7)
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primaryGreen),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final currentQuestion = _questions[_currentQuestionIndex];
    final hasAnswer = _answers.containsKey(currentQuestion.id);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentQuestionIndex > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex--;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryGreen,
                  side: const BorderSide(color: AppColors.primaryGreen),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Previous'),
              ),
            ),
          if (_currentQuestionIndex > 0) const SizedBox(width: 12),
          Expanded(
            flex: _currentQuestionIndex > 0 ? 1 : 2,
            child: ElevatedButton(
              onPressed: hasAnswer ? _goToNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.primaryGreen.withOpacity(
                  0.3,
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                _currentQuestionIndex < _questions.length - 1
                    ? 'Next'
                    : 'See Results',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToNext() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _showResults = true;
        _showResults = true;
      });
    }
  }

  Widget _buildResults() {
    final Color resultColor;
    final IconData resultIcon;

    if (_scorePercentage >= 80) {
      resultColor = AppColors.success;
      resultIcon = Icons.emoji_events;
    } else if (_scorePercentage >= 60) {
      resultColor = AppColors.lightGreen;
      resultIcon = Icons.thumb_up;
    } else if (_scorePercentage >= 40) {
      resultColor = AppColors.warning;
      resultIcon = Icons.school;
    } else {
      resultColor = AppColors.error;
      resultIcon = Icons.lightbulb;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: resultColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(resultIcon, size: 80, color: resultColor),
          ),
          const SizedBox(height: 24),
          Text(
            '$_literacyLevel Digital Literacy',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: resultColor,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: resultColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              '${_scorePercentage.round()}%',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: resultColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$_correctAnswers out of ${_questions.length} correct',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Your Results Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildResultStat(
                      'Correct',
                      _correctAnswers.toString(),
                      AppColors.success,
                    ),
                    _buildResultStat(
                      'Wrong',
                      (_questions.length - _correctAnswers).toString(),
                      AppColors.error,
                    ),
                    _buildResultStat(
                      'Total',
                      _questions.length.toString(),
                      AppColors.primaryGreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primaryGreen.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.tips_and_updates,
                  color: AppColors.primaryGreen,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _getRecommendation(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Continue Learning',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _restartSurvey,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryGreen,
                side: const BorderSide(color: AppColors.primaryGreen),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Take Survey Again',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
      ],
    );
  }

  String _getRecommendation() {
    if (_scorePercentage >= 80) {
      return 'Excellent! You have advanced digital skills. Keep exploring new technologies!';
    } else if (_scorePercentage >= 60) {
      return 'Good job! You have intermediate skills. Watch more videos to improve further.';
    } else if (_scorePercentage >= 40) {
      return 'You\'re making progress! We recommend watching our beginner tutorials.';
    } else {
      return 'Don\'t worry! Start with our basic tutorials to build your digital skills.';
    }
  }

  void _restartSurvey() {
    setState(() {
      _currentQuestionIndex = 0;
      _answers.clear();
      _showResults = false;
    });
  }

  void _showExitConfirmation(BuildContext context) {
    if (_answers.isEmpty) {
      Navigator.pop(context);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Survey?'),
        content: const Text(
          'Your progress will be lost. Are you sure you want to exit?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}
