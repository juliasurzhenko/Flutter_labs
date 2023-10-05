import 'package:flutter/material.dart';

void main() {
  runApp(GalleryApp());
}

class GalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AlbumListPage(),
      routes: {
        '/album': (context) {
          final album = ModalRoute.of(context)!.settings.arguments as Album;
          return AlbumPhotosPage(album: album);
        },
      },
    );
  }
}

class AlbumListPage extends StatelessWidget {
  final List<Album> albums = [
    Album("Minions 1", [
      'assets/img1.jpeg',
      'assets/img2.jpg',
      'assets/img1.jpeg',
      'assets/img2.jpg',
      'assets/img1.jpeg',
      'assets/img2.jpg',
      'assets/img1.jpeg',
      'assets/img2.jpg',
    ]),
    Album("Minions 2", [
      'assets/img2.jpg',
      'assets/img1.jpeg',
      'assets/img2.jpg',
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Albums"),
      ),
      body: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          return ListTile(
            title: Text(album.name),
            leading: Image.asset(
              album.photos[0], // Display the first photo as a thumbnail
              width: 50, // Adjust as needed
              height: 50, // Adjust as needed
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/album',
                arguments: album,
              );
            },
          );
        },
      ),
    );
  }
}

class AlbumPhotosPage extends StatefulWidget {
  final Album album;

  AlbumPhotosPage({required this.album});

  @override
  _AlbumPhotosPageState createState() => _AlbumPhotosPageState();
}

class _AlbumPhotosPageState extends State<AlbumPhotosPage> {
  int _currentIndex = 0;

  void _previousPhoto() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  void _nextPhoto() {
    setState(() {
      if (_currentIndex < widget.album.photos.length - 1) {
        _currentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(widget.album.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                widget.album.photos[_currentIndex],
                width: 300, // Adjust as needed
                height: 300, // Adjust as needed
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _previousPhoto,
              ),
              Text("${_currentIndex + 1} / ${widget.album.photos.length}"),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: _nextPhoto,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Album {
  final String name;
  final List<String> photos;

  Album(this.name, this.photos);
}
