import 'dart:convert';

import 'package:sumer_test/data/models/gif.dart';

TrendingGIFsRequest gifRequestFromJson(String str) => TrendingGIFsRequest.fromJson(json.decode(str));

String gifRequestToJson(TrendingGIFsRequest data) => json.encode(data.toJson());

class TrendingGIFsRequest {
    TrendingGIFsRequest({
        required this.gifList,
        required this.pagination,
        required this.meta,
    });

    final List<GIF> gifList;
    final Pagination pagination;
    final Meta meta;

    factory TrendingGIFsRequest.fromJson(Map<String, dynamic> json) => TrendingGIFsRequest(
        gifList: List<GIF>.from(json["data"].map((x) => GIF.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<GIF>.from(gifList.map((x) => x)),
        "pagination": pagination.toJson(),
        "meta": meta.toJson(),
    };
}

class Meta {
    Meta({
        required this.status,
        required this.msg,
        required this.responseId,
    });

    final int status;
    final String msg;
    final String responseId;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        status: json["status"],
        msg: json["msg"],
        responseId: json["response_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "response_id": responseId,
    };
}

class Pagination {
    Pagination({
        required this.totalCount,
        required this.count,
        required this.offset,
    });

    final int totalCount;
    final int count;
    final int offset;

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json["total_count"],
        count: json["count"],
        offset: json["offset"],
    );

    Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "count": count,
        "offset": offset,
    };
}
