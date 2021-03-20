class Story{
  String body;
  String author;
  String emotion;
  var timestamp;

  Story(String body, String author, String emotion, var timestamp){
    this.body = body;
    this.author = "Anonymous " + author;
    this.emotion = emotion;
    this.timestamp = timestamp;
  }

  String toString() {
    return """
      author: ${this.author}
      emotion: ${this.emotion}
      body: ${this.body}
      timestamp: ${this.timestamp}
    """;
  }

}