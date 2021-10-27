class CategoriesModel {
  bool status;

  Data data;
  CategoriesModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int currentPage;
  List<DataModel> datamodel = [];

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      datamodel = <DataModel>[];
      json['data'].forEach((v) {
        datamodel.add(new DataModel.formJson(v));
      });
    }
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datamodel != null) {
      data['data'] = this.datamodel.map((v) => v.toJson()).toList();
    }

    data['currentPage'] = this.currentPage;
    return data;
  }
}

class DataModel {
  int id;
  String name;
  String image;
  DataModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['category'] = this.name;
    return data;
  }
}
