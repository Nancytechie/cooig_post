import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooig_firebase/home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Notifications extends StatefulWidget {
  final String userId;

  const Notifications({super.key, required this.userId});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('toUserID', isEqualTo: widget.userId)
            .where('type',
                whereIn: ['like', 'comment', 'like notes']) // Add 'like notes'
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error loading notifications: ${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No notifications yet!",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            );
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification =
                  notifications[index].data() as Map<String, dynamic>;
              final type = notification['type'] ?? 'default';
              final fromUserID = notification['fromUserID'] ?? '';
              final postID = notification['postID'] ?? '';
              final noteId = notification['noteId'] ?? '';
              final timestamp =
                  notification['timestamp'] as Timestamp? ?? Timestamp.now();

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(fromUserID)
                    .get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return const ListTile(
                      title: Text('Loading...',
                          style: TextStyle(color: Colors.white)),
                    );
                  }

                  final userData =
                      userSnapshot.data!.data() as Map<String, dynamic>? ?? {};
                  final userName = userData['full_name'] ?? 'Unknown';
                  final userImage = userData['profilepic'] ??
                      'https://via.placeholder.com/150';

                  return InkWell(
                    onTap: () {
                      if (type == 'like notes') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NoteDetailScreen(noteId: noteId),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PostDetailScreen(postID: postID),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(userImage),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  type == 'like'
                                      ? '$userName liked your post'
                                      : type == 'like notes'
                                          ? '$userName liked your notes'
                                          : '$userName commented on your post',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatTimestamp(timestamp),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class PostDetailScreen extends StatelessWidget {
  final String postID;
  final String? commentID;

  const PostDetailScreen({super.key, required this.postID, this.commentID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('posts_upload')
            .doc(postID)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
                child: Text('Post not found',
                    style: TextStyle(color: Colors.white)));
          }

          final postData = snapshot.data!.data() as Map<String, dynamic>?;
          if (postData == null) {
            return const Center(
                child: Text('Post data is null',
                    style: TextStyle(color: Colors.white)));
          }

          final userID = postData['userID'] ?? '';
          final comments = postData['comments'] as List<dynamic>? ?? [];

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(userID)
                .get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                return const Center(
                    child: Text('User not found',
                        style: TextStyle(color: Colors.white)));
              }

              final userData =
                  userSnapshot.data!.data() as Map<String, dynamic>? ?? {};
              final userName = userData['full_name'] ?? 'Unknown';
              final userImage = userData['profilepic'] ?? '';

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Display the post with user details
                    PostWidget(
                      postID: postID,
                      userName: userName,
                      userImage: userImage,
                      text: postData['text'] ?? '',
                      mediaUrls: postData['media'] != null
                          ? List<String>.from(postData['media'])
                          : [],
                      timestamp: postData['timestamp'] ?? Timestamp.now(),
                    ),
                    const SizedBox(height: 16),
                    // Display comments with a heading
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Comments',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...comments.map((comment) {
                      final commentData =
                          comment as Map<String, dynamic>? ?? {};
                      final commentUserID = commentData['userID'] ?? '';
                      final commentText = commentData['text'] ?? '';

                      return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(commentUserID)
                            .get(),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const ListTile(
                              title: Text('Loading...',
                                  style: TextStyle(color: Colors.white)),
                            );
                          }

                          if (!userSnapshot.hasData ||
                              !userSnapshot.data!.exists) {
                            return const ListTile(
                              title: Text('User not found',
                                  style: TextStyle(color: Colors.white)),
                            );
                          }

                          final userData = userSnapshot.data!.data()
                                  as Map<String, dynamic>? ??
                              {};
                          final userName = userData['full_name'] ?? 'Unknown';
                          final userImage = userData['profilepic'] ?? '';

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(userImage),
                            ),
                            title: Text(
                              userName,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              commentText,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NoteDetailScreen extends StatelessWidget {
  final String noteId;

  const NoteDetailScreen({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('notes').doc(noteId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
                child: Text('Note not found',
                    style: TextStyle(color: Colors.white)));
          }

          final noteData = snapshot.data!.data() as Map<String, dynamic>?;
          if (noteData == null) {
            return const Center(
                child: Text('Note data is null',
                    style: TextStyle(color: Colors.white)));
          }

          final userId = noteData['userId'] ?? '';
          final notesLink = noteData['notesLink'] ?? '';

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                return const Center(
                    child: Text('User not found',
                        style: TextStyle(color: Colors.white)));
              }

              final userData =
                  userSnapshot.data!.data() as Map<String, dynamic>? ?? {};
              final userName = userData['full_name'] ?? 'Unknown';
              final userImage = userData['profilepic'] ?? '';

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Display the note with user details
                    NoteWidget(
                      userName: userName,
                      userImage: userImage,
                      text: noteData['text'] ?? '',
                      notesLink: notesLink,
                      timestamp: noteData['timestamp'] ?? Timestamp.now(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NoteWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final String text;
  final String notesLink;
  final Timestamp timestamp;

  const NoteWidget({
    super.key,
    required this.userName,
    required this.userImage,
    required this.text,
    required this.notesLink,
    required this.timestamp,
  });
  Future<void> _openLink(BuildContext context, String url) async {
    if (url.isNotEmpty && Uri.tryParse(url)?.hasScheme == true) {
      try {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          // Handle the error where the URL can't be launched
          throw 'Could not open the link';
        }
      } catch (e) {
        // Handle any exception thrown during the launch
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open link: $e')),
        );
      }
    } else {
      // Handle invalid URL
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.bottomRight,
          radius: 1.5,
          colors: [
            Color(0XFF9752C5),
            const Color.fromARGB(255, 132, 92, 241),
          ],
          stops: [2.0, 3.0],
        ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userImage),
                radius: 20,
              ),
              const SizedBox(width: 8.0),
              Text(
                userName,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () => _openLink(context, notesLink),
            child: Text(
              'Open Notes',
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
