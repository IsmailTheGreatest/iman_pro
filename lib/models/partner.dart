class Partner {
  final String imageUrl;
  final String title;
  final double distance;
  final String? storeIconImgUrl;

  Partner({
    required this.imageUrl,
    required this.title,
    required this.distance,
    this.storeIconImgUrl,
  });
}