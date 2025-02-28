//import 'material_upload.dart';
import 'package:cooig_firebase/academic_section/unit_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BranchPage extends StatefulWidget {
  const BranchPage({super.key});

  @override
  State<BranchPage> createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage> {
  // Function to navigate to the respective branch page
  void navigateToBranch(String branch) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BranchMaterialPage(branch: branch),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xFF1C1C1E),
            Color(0xFF000000),
          ],
          radius: 0.0,
          center: Alignment.center,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Material Hub',
            style: GoogleFonts.ebGaramond(
              textStyle: const TextStyle(
                color: Color(0XFF9752C5), // Contrast with button colors
                fontSize: 30,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // B.Tech Section
                SectionHeader(
                  title: "B.Tech",
                  description: "Explore study materials for B.Tech branches",
                ),
                const SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    for (var branch in [
                      'CSE-AI',
                      'CSE',
                      'IT',
                      'MAE',
                      'ECE',
                      'ECE-AI',
                      'AI-ML',
                      'DMAM'
                    ])
                      AnimatedRoundedRectButton(
                        label: branch,
                        onPressed: () => navigateToBranch(branch),
                      ),
                  ],
                ),
                const SizedBox(height: 40),
                // Management Section
                SectionHeader(
                  title: "Management",
                  description: "Explore study materials Management programs",
                ),
                const SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    AnimatedRoundedRectButton(
                      label: "BBA",
                      onPressed: () => navigateToBranch("BBA"),
                    ),
                    AnimatedRoundedRectButton(
                      label: "MBA",
                      onPressed: () => navigateToBranch("MBA"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Section Header Widget
class SectionHeader extends StatelessWidget {
  final String title;
  final String description;

  const SectionHeader({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.ebGaramond(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Custom Animated Rounded Rectangle Button
class AnimatedRoundedRectButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const AnimatedRoundedRectButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  _AnimatedRoundedRectButtonState createState() =>
      _AnimatedRoundedRectButtonState();
}

class _AnimatedRoundedRectButtonState extends State<AnimatedRoundedRectButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: isHovered ? 160 : 140, // Adjusting size for hover effect
          height: isHovered ? 60 : 50, // Adjusting size for hover effect
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isHovered
                  ? [Color(0XFF9752C5), Colors.deepPurpleAccent]
                  : [Colors.purple, const Color.fromARGB(255, 115, 41, 165)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: Colors.pink.shade200,
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder for the branch material page

// BranchMaterialPage class
class BranchMaterialPage extends StatelessWidget {
  final String branch;

  const BranchMaterialPage({required this.branch, super.key});

  @override
  Widget build(BuildContext context) {
    // Define reusable text styles for better optimization
    TextStyle headingStyle = GoogleFonts.ebGaramond(
      textStyle: const TextStyle(
        color: Color(0XFF9752C5), // Title color
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
    );

    // Button text style for better optimization
    TextStyle buttonTextStyle = GoogleFonts.ebGaramond(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );

    // Determine the number of years based on the branch
    int totalYears = branch == 'MBA'
        ? 2
        : branch == 'BBA'
            ? 3
            : 4;

    // Generate semesters based on years for the branch
    List<List<int>> semestersPerYear = [];
    for (int year = 1; year <= totalYears; year++) {
      List<int> semesters = [];
      // Add semesters dynamically based on the year
      if (year == 1) {
        semesters.add(1);
        semesters.add(2);
      } else if (year == 2) {
        semesters.add(3);
        semesters.add(4);
      } else if (year == 3) {
        semesters.add(5);
        semesters.add(6);
      } else if (year == 4) {
        semesters.add(7);
        semesters.add(8);
      }
      semestersPerYear.add(semesters);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(branch, style: headingStyle),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Loop through each year
                for (var yearIndex = 0;
                    yearIndex < totalYears;
                    yearIndex++) ...[
                  // Year Title with Increased Font Size and Bold
                  Text(
                    "${yearIndex + 1} Year",
                    style: GoogleFonts.ebGaramond(
                      fontSize: 26, // Increased font size for year label
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Wrap to place semester buttons dynamically
                  Wrap(
                    spacing: 20, // Increased gap between buttons
                    runSpacing: 15, // Space between rows of buttons
                    alignment: WrapAlignment.center,
                    children: [
                      for (var semester in semestersPerYear[yearIndex])
                        AnimatedRoundedRectButton(
                          label: 'Sem $semester', // Shortened text

                          onPressed: () {
                            // Navigate to respective semester page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SemesterPage(
                                  branch: branch,
                                  year: yearIndex + 1,
                                  semester: semester,
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// SemesterPage class for displaying subject details

class SemesterPage extends StatelessWidget {
  final String branch;
  final int year;
  final int semester;

  const SemesterPage({
    required this.branch,
    required this.year,
    required this.semester,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Data for subjects, units, and links for each branch and semester
    Map<String, Map<int, Map<String, List<Map<String, String>>>>> data = {
      'CSE-AI': {
        1: {
          // First Semester
          'Probability and Statistics': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Environmental Sciences': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Programming with Python': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'IT Workshop': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Communication Skills': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Applied Mathematics': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Applied Physics': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        2: {
          // Second Semester
          'Introduction to Data Science': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Soft Skills and Personality Development': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Data Structures': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        3: {
          // Third Semester
          'Artificial Intelligence': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Data Structures': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Discrete Structures': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Software Engineering': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Material Science and Engineering': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Numerical Methods': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        4: {
          // Fourth Semester
          'Computer Networks': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Operating Systems': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Design and Analysis of Algorithms': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Optimization Techniques and Decision Making': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Disaster Management': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        5: {
          // Fifth Semester
          'Machine Learning': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Cyber Security': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Deep Learning – I': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Theory of Computation': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Professional Ethics and Human Values': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        6: {
          // Sixth Semester
          'Natural Language Processing': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Deep Learning – II': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Departmental Elective – I': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Departmental Elective – II': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Digital Image Processing': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Management Elective': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        7: {
          // Seventh Semester
          'Recent Trends in AI': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Big Data Analytics': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Multimodal Data Analysis': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        8: {
          // Eighth Semester
          'Creativity, Innovation and Entrepreneurship': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Departmental Elective – V': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Departmental Elective – VI': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
      },
      'CSE': {
        1: {
          'Applied Mathematics': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Applied Physics': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Programming with C': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Communication Skills (CS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Web Application Development': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Basics of Electrical and Electronics Engineering (BEE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        2: {
          'Math 102': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Computer Science 102': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Data Structures': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Discrete Mathematics': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Electronics 102': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        3: {
          'Numerical Method (NM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Data Structures (DS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Discrete Structures (DM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Software Engineering (SE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Material Science and Engineering (MSE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Artificial Intelligence (AI)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        4: {
          'Software Engineering': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Computer Networks': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Digital Logic': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Compiler Design': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Operating System Concepts': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        5: {
          'Theory of Computation (TOC)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Data Communication and Computer Network (DCCN)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Artificial Intelligence (AI)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Professional Ethics and Human Values (PEHV)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Modelling and Simulation (MS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        6: {
          'Computer Vision': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Software Testing': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Artificial Intelligence': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Cloud Computing': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Web Technologies': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        7: {
          'Mobile Computing (MC)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Evolutionary Computing (EC)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Machine Learning (ML)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'E-Commerce (E Com)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Knowledge Engineering (KE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        8: {
          'Capstone Project': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Enterprise Applications': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Agile Development': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Mobile App Development': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Cloud Technologies': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
      },
      'IT': {
        1: {
          // First Semester
          'Applied Mathematics (AM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Applied Physics (AP)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Communication Skills (CS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Programming with Python': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Web Application Development': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'IT Workshop': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        2: {
          // Second Semester
          'Applied Mathematics - II': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Applied Physics - II': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Environmental Sciences (EVS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Basic Electrical Engineering (BEE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Programming in C': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        3: {
          // Third Semester
          'Discrete Structures (DM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Software Engineering (SE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Data Structures (DS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Database Management Systems (DBMS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Material Science & Engineering (MSE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Numerical Method (NM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        4: {
          // Fourth Semester
          'Operating Systems (OS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Object-Oriented Programming (OOPS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Computer Organization and Architecture (COA)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Design and Analysis of Algorithms (DAA)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Optimization Techniques (OT)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Operations Management (OM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Disaster Management (DM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        5: {
          // Fifth Semester
          'Artificial Intelligence and Machine Learning (AI & ML)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Data Communication and Computer Network (DCCN)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Modeling and Simulation (MS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Professional Ethics and Human Values (PEHV)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Theory of Computation (TOC)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        6: {
          // Sixth Semester
          'Wireless Networks (WN)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Cloud Computing (CC)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Data Mining and Machine Learning (DMML)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Advanced Data Structure and Algorithm (ADSA)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Compiler Design (CD)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Computer Vision (CV)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Financial Management (FM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        7: {
          // Seventh Semester
          'Mobile Computing (MC)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Software Testing (ST)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Big Data Analytics (BD)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Cybersecurity and Forensics (CSF)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'E-Commerce': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Soft Computing': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Distributed Systems (DS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
        8: {
          // Eighth Semester
          'Information and Network Security (INS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Natural Language Processing (NLP)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Information Retrieval (IR)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Cryptography': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
        },
      },
      "mae": {
        1: {
          // First Semester
          'Applied Mathematics (AM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Applied Physics (AP)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Communication Skills (CS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Programming Fundamentals': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Elements of Mechanical Engineering and Workshop': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Basics of Electrical and Electronics Engineering': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ]
        },
        2: {
          // Second Semester
          'Applied Mathematics – II': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Applied Physics – II': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Environmental Sciences (EVS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Programming in C': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Basic Electrical Engineering': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ]
        },
        3: {
          // Third Semester
          'Production Technology (PT)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Strength Of Materials (SOM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Thermal Engineering (TE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Numerical Techniques for Engineers (NTE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Machine Drawing Lab (MED)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Database Management System (DBMS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ]
        },
        4: {
          // Fourth Semester
          'Production Technology-II (PT)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Theory of Machines (TOM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Engineering Materials (EMat)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Thermal Engineering -II (TE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Object Oriented Programming (OOPS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Disaster Management (DM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ]
        },
        5: {
          // Fifth Semester
          'Machine Design (MD)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Fluid Mechanics and Hydraulic Machines (FM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Automobile Engineering (AE)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Artificial Intelligence': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Professional Ethics and Human Values (PEHV)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ]
        },
        6: {
          // Sixth Semester
          'Heat Transfer (HT)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Computer Aided Design (CAD)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Production Management (PM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Quality Management & Six Sigma (QMS)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Industrial Tribology (I.Tr.)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Combustion, Emission & Pollution Control (CEPC)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Advanced Machine Design (AMD)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Marketing Management (MKM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Financial Management (FM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ]
        },
        7: {
          // Seventh Semester
          'Finite Element Analysis (FEA)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Mechatronics (MT)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Hydraulic & Pneumatic Control (HPC)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Internet of Things (IoT)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Machine Learning for Mechanical Engineers (ML)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ]
        },
        8: {
          // Eighth Semester
          'Computer Aided Manufacturing (CAM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Robotics (RBT)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Reliability & Maintenance (RM)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Renewable Energy Sources (RES)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ],
          'Design of Pressure Vessels (DPV)': [
            {'Unit 1': ''},
            {'Unit 2': ''},
            {'Unit 3': ''},
            {'Unit 4': ''},
          ]
        }
      },
      'ECE': {
        1: {
          "Probability and Statistics": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Environmental Sciences": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Signals and Systems": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Communication Skills": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Electronics Workshop": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Programming Fundamentals": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        2: {
          "Applied Mathematics - II": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Applied Physics - II": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Environmental Sciences (EVS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Communication Skills": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Engineering Mechanics": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Workshop Practice": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        3: {
          "Analog Electronics (AE)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Network Analysis & Synthesis (NAS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Digital Electronics (DE)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Signals & Systems (SS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Database Management System (DBMS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        4: {
          "Linear Integrated Circuits": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Digital System Design": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Electromagnetic Field Theory": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Communication Systems": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Object Oriented Programming (OOP)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Disaster Management": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        5: {
          "Digital Communication Systems (DCS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Control Systems (CS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Data Communication & Computer Networks (DCCN)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Artificial Intelligence (AI)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Professional Ethics and Human Values (PEHV)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Modelling and Simulation (MS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        6: {
          "Digital Signal Processing (DSP)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Information Theory & Coding (ITC)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "VLSI Design": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Microprocessors & Microcontrollers (MPMC)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Cloud Computing (CC)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Marketing Management (MM)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        7: {
          "Microwave Techniques (MT)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Cyber Security and Forensics (CSF)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Wireless and Mobile Communication (WMC)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Big Data Analytics": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        8: {
          "Embedded Systems (ES)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Information Retrieval (IR)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Non Conventional Energy Resources (NCER)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Wireless Sensor Network": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        }
      },
      'ECE-AI': {
        1: {
          "Probability and Statistics": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Environmental Sciences": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Signals and Systems": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Communication Skills": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Electronics Workshop": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Programming Fundamentals": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        2: {
          "Digital Electronics": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Signals and Systems": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Programming with Python": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "IT Workshop": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Probability and Statistics": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        3: {
          "Communication Systems": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Network Analysis and Synthesis": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Neural Network and Artificial Intelligence": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Data Structures": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Database Management System": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        4: {
          "Linear Integrated Circuits": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Electromagnetic Field Theory": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Digital Communication Systems": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Optimization Techniques and Decision Making": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Object Oriented Programming": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Disaster Management": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        5: {
          "Control Systems": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Digital Signal Processing": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Machine Learning": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Computer Networks": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Professional Ethics and Human Values": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        6: {
          "VLSI Design": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Microprocessors & Microcontrollers": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Digital Image Processing": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Cloud Computing": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Semantic Web": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Marketing Management": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        7: {
          "Software Project Management": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Wireless and Mobile Communication": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Deep Learning": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Computer Vision": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Multimodal Data Analysis": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        8: {
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        }
      },
      'AI-ML': {
        1: {
          "Probability and Statistics (PS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Environmental Sciences (EVS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Signals and Systems (SNS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Communication Skills (CS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Electronics Workshop (EW)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Programming Fundamentals (PF)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        2: {
          "Object Oriented Programming using Java (OOPS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Fundamentals of Data Structure": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Introduction to Data Science": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Environmental Science (EVS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Probability and Statistics (PS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "IT Workshop (ITW)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        3: {
          "Discrete Structures (DM)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Software Engineering (SE)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Material Science and Engineering (MSE)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Numerical Methods (NM)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Database Management System (DBMS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Artificial Intelligence (AI)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        4: {
          "Computer Networks (CN)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Operating System (OS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Design and Analysis of Algorithms (DAA)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Machine Learning (ML)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Optimization Techniques (OT)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Operations Management (OM)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Disaster Management (DM)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        5: {
          "Optimization Techniques and Decision Making (OTDM)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Cryptography and Network Security (CNS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Social Networking and Mining (SNM)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Theory of Computation (TOC)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Professional Ethics and Human Values (PEHV)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        6: {
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        7: {
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        8: {
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        }
      },
      'DMAM': {
        1: {
          "Probability and Statistics (PS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Environmental Sciences (EVS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Signals and Systems (SNS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Communication Skills (CS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Electronics Workshop (EW)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Programming Fundamentals (PF)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        2: {
          "Object Oriented Programming using Java (OOPS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Fundamentals of Data Structure (FDS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Introduction to Data Science (IDS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Environmental Science (EVS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "Probability and Statistics (PS)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "IT Workshop (ITW)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        3: {
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        4: {
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        5: {
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        6: {
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        7: {
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        },
        8: {
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ],
          "(To be updated)": [
            {"Unit 1": ""},
            {"Unit 2": ""},
            {"Unit 3": ""},
            {"Unit 4": ""}
          ]
        }
      },
    };

    // Get subjects for the current branch and semester
    var subjects = data[branch]?[semester] ?? {};
    var isEmpty = subjects.isEmpty;

    return Scaffold(
      appBar: AppBar(
          title: Text('$branch - Year $year, Sem $semester'),
          backgroundColor: Colors.black,
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white, // Title color
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          )),
      backgroundColor: Colors.black,
      body: isEmpty
          ? Center(
              child: Text(
                'No subjects available for $branch in Semester $semester',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Display subject containers dynamically
                    for (var subject in subjects.keys) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(
                            24), // Increased padding for better space
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(
                              0.1), // Light grey background with opacity for subtle effect
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2), // Soft shadow with black opacity for a more elegant look
                              spreadRadius: 3,
                              blurRadius: 6,
                              offset: Offset(
                                  0, 4), // Slight shadow offset for depth
                            ),
                          ],
                          border: Border.all(
                            width: 4, // Thicker border for better definition
                            color: Colors.grey.withOpacity(
                                0.5), // Grey border with opacity for a refined look
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              subject,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 132, 92,
                                    241), // Text color set to white
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Display units for each subject
                            for (var unit in subjects[subject]!) ...[
                              for (var unitName in unit.keys) ...[
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to the Unit page on click
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UnitPage(
                                          branch: branch,
                                          year: semester,
                                          subject: subject,
                                          unitName: unitName,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      unitName,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white.withOpacity(
                                            0.8), // Text color white with slight opacity
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}
