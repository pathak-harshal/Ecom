// To parse this JSON data, do
//
//     final apiResultModel = apiResultModelFromJson(jsonString);

import 'dart:convert';

ApiResultModel apiResultModelFromJson(String str) => ApiResultModel.fromJson(json.decode(str));

String apiResultModelToJson(ApiResultModel data) => json.encode(data.toJson());

class ApiResultModel {
    ApiResultModel({
        this.categories,
        this.rankings,
    });

    List<Category> categories;
    List<Ranking> rankings;

    factory ApiResultModel.fromJson(Map<String, dynamic> json) => ApiResultModel(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        rankings: List<Ranking>.from(json["rankings"].map((x) => Ranking.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "rankings": List<dynamic>.from(rankings.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.name,
        this.products,
        this.childCategories,
    });

    int id;
    String name;
    List<CategoryProduct> products;
    List<int> childCategories;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        products: List<CategoryProduct>.from(json["products"].map((x) => CategoryProduct.fromJson(x))),
        childCategories: List<int>.from(json["child_categories"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "child_categories": List<dynamic>.from(childCategories.map((x) => x)),
    };
}

class CategoryProduct {
    CategoryProduct({
        this.id,
        this.name,
        this.dateAdded,
        this.variants,
        this.tax,
    });

    int id;
    String name;
    DateTime dateAdded;
    List<Variant> variants;
    Tax tax;

    factory CategoryProduct.fromJson(Map<String, dynamic> json) => CategoryProduct(
        id: json["id"],
        name: json["name"],
        dateAdded: DateTime.parse(json["date_added"]),
        variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
        tax: Tax.fromJson(json["tax"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_added": dateAdded.toIso8601String(),
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "tax": tax.toJson(),
    };
}

class Tax {
    Tax({
        this.name,
        this.value,
    });

    Name name;
    double value;

    factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        name: nameValues.map[json["name"]],
        value: json["value"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "value": value,
    };
}

enum Name { VAT, VAT4 }

final nameValues = EnumValues({
    "VAT": Name.VAT,
    "VAT4": Name.VAT4
});

class Variant {
    Variant({
        this.id,
        this.color,
        this.size,
        this.price,
    });

    int id;
    String color;
    int size;
    int price;

    factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        color: json["color"],
        size: json["size"] == null ? 0 : json["size"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
        "size": size == null ? 0 : size,
        "price": price,
    };
}

class Ranking {
    Ranking({
        this.ranking,
        this.products,
    });

    String ranking;
    List<RankingProduct> products;

    factory Ranking.fromJson(Map<String, dynamic> json) => Ranking(
        ranking: json["ranking"],
        products: List<RankingProduct>.from(json["products"].map((x) => RankingProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ranking": ranking,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class RankingProduct {
    RankingProduct({
        this.id,
        this.viewCount,
        this.orderCount,
        this.shares,
    });

    int id;
    int viewCount;
    int orderCount;
    int shares;

    factory RankingProduct.fromJson(Map<String, dynamic> json) => RankingProduct(
        id: json["id"],
        viewCount: json["view_count"] == null ? null : json["view_count"],
        orderCount: json["order_count"] == null ? null : json["order_count"],
        shares: json["shares"] == null ? null : json["shares"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "view_count": viewCount == null ? 0 : viewCount,
        "order_count": orderCount == null ? 0 : orderCount,
        "shares": shares == null ? 0 : shares,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
