enum Mood {
  happy,
  sad,
  energetic,
  calm
}

class Song {
  final String title;
  final Mood mood;
  int plays = 0;

  Song(this.title, this.mood);
}

class User {
  final String name;
  final Map<Mood, int> _moodScore = {};

  User(this.name);

  void listen(Song song) {
    song.plays++;
    _moodScore[song.mood] = (_moodScore[song.mood] ?? 0) + 1;
  }

  Mood preferredMood() {
    Mood best = Mood.happy;
    int max = -1;

    for (var entry in _moodScore.entries) {
      if (entry.value > max) {
        max = entry.value;
        best = entry.key;
      }
    }
    return best;
  }
}

class PlaylistEngine {
  final List<Song> _songs = [];

  void addSong(String title, Mood mood) {
    _songs.add(Song(title, mood));
  }

  List<Song> recommend(User user) {
    Mood mood = user.preferredMood();
    List<Song> result = [];

    for (var song in _songs) {
      if (song.mood == mood) {
        result.add(song);
      }
    }
    return result;
  }
}

void main() {
  PlaylistEngine engine = PlaylistEngine();

  engine.addSong("Rise", Mood.energetic);
  engine.addSong("Calm Waves", Mood.calm);
  engine.addSong("Smile Again", Mood.happy);
  engine.addSong("Lonely Road", Mood.sad);

  User user = User("Ama");

  user.listen(engine.recommend(user).first);

  List<Song> playlist = engine.recommend(user);

  for (var song in playlist) {
    print(song.title);
  }
}