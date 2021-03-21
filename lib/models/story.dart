class Story{
  String body;
  String author;
  String emotion;
  String Body;
  String id;
  int count;
  List<String> responses;
  var timestamp;

  Story(String id,String body, String author, String emotion, var timestamp,List<String> responses, int count){
    this.id = id;
    this.body = body;
    this.author = "Anonymous " + author;
    this.emotion = emotion;
    this.timestamp = timestamp;
    this.responses = responses;
    this.count = count;
  }

  void addResponses(){
    this.count +=1;
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
