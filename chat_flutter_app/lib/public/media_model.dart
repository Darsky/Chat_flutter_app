class MediaModel {
  String mdType;
  String mdUrl;
  String mdSize;
  String mdWidth;
  String mdHeight;
  int    mdDuration;

  MediaModel();

  MediaModel.modelFromJson(Map<String, dynamic> json) {
    mdType = json['mdType'] as String;
    mdUrl = json['mdUrl'] as String;
    mdSize = json['mdSize'] as String;
    mdDuration = json['mdDuration'] == null ?0: json['mdDuration'] as int;
    mdWidth = json['mdWidth'] as String;
    mdHeight = json['mdHeight'] as String;
  }

}
