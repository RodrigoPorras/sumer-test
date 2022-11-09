import 'dart:convert';

GIF gifFromJson(String str) => GIF.fromJson(json.decode(str));

String gifToJson(GIF data) => json.encode(data.toJson());

class GIF {
  GIF({
    required this.type,
    required this.id,
    required this.url,
    required this.slug,
    required this.trendingDatetime,
    required this.images,
  });

  final String type;
  final String id;
  final String url;
  final String slug;
  final DateTime trendingDatetime;
  final Images images;

  factory GIF.fromJson(Map<String, dynamic> json) => GIF(
        type: json['type'],
        id: json['id'],
        url: json['url'],
        slug: json['slug'],
        trendingDatetime: DateTime.parse(json['trending_datetime']),
        images: Images.fromJson(json['images']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'url': url,
        'slug': slug,
        'trending_datetime': trendingDatetime.toIso8601String(),
        'images': images.toJson(),
      };
}

class Images {
  Images({
    required this.original,
    required this.fixedHeight,
    required this.fixedWidth,
    required this.previewGif,
  });

  final FixedHeight original;
  final FixedHeight fixedHeight;
  final FixedHeight fixedWidth;
  final FixedHeight previewGif;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        original: FixedHeight.fromJson(json['original']),
        fixedHeight: FixedHeight.fromJson(json['fixed_height']),
        fixedWidth: FixedHeight.fromJson(json['fixed_width']),
        previewGif: FixedHeight.fromJson(json['preview_gif']),
      );

  Map<String, dynamic> toJson() => {
        'original': original.toJson(),
        'fixed_height': fixedHeight.toJson(),
        'fixed_width': fixedWidth.toJson(),
        'preview_gif': previewGif.toJson(),
      };
}

class FixedHeight {
  FixedHeight({
    required this.height,
    required this.width,
    required this.size,
    required this.url,
    required this.mp4Size,
    required this.mp4,
    required this.webpSize,
    required this.webp,
    required this.frames,
    required this.hash,
  });

  final String? height;
  final String? width;
  final String? size;
  final String? url;
  final String? mp4Size;
  final String? mp4;
  final String? webpSize;
  final String? webp;
  final String? frames;
  final String? hash;

  factory FixedHeight.fromJson(Map<String, dynamic> json) => FixedHeight(
        height: json['height'],
        width: json['width'],
        size: json['size'],
        url: json['url'],
        mp4Size: json['mp4_size'],
        mp4: json['mp4'],
        webpSize: json['webp_size'],
        webp: json['webp'],
        frames: json['frames'],
        hash: json['hash'],
      );

  Map<String, dynamic> toJson() => {
        'height': height,
        'width': width,
        'size': size,
        'url': url,
        'mp4_size': mp4Size,
        'mp4': mp4,
        'webp_size': webpSize,
        'webp': webp,
        'frames': frames,
        'hash': hash,
      };
}
