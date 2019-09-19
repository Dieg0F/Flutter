class PhotoGallery {
  String photoPath;
  String uploadDate;

  PhotoGallery({
    this.photoPath,
    this.uploadDate,
  });

  factory PhotoGallery.fromJson(Map<String, dynamic> json) => new PhotoGallery(
        photoPath: json["photoPath"],
        uploadDate: json["uploadDate"],
      );

  Map<String, dynamic> toJson() => {
        "photoPath": photoPath,
        "uploadDate": uploadDate,
      };
}
