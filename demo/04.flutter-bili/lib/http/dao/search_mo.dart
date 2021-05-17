class SearchMo {
  int numberPerPage;
  int currentPage;
  List<SortListMo> sortList;
  List<FiltersMo> filters;

  SearchMo({this.numberPerPage, this.currentPage, this.sortList, this.filters});

  SearchMo.fromJson(Map<String, dynamic> json) {
    numberPerPage = json['numberPerPage'];
    currentPage = json['currentPage'];
    if (json['sortList'] != null) {
      sortList = [];
      json['sortList'].forEach((v) {
        sortList.add(new SortListMo.fromJson(v));
      });
    }
    if (json['filters'] != null) {
      filters = [];
      json['filters'].forEach((v) {
        filters.add(new FiltersMo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberPerPage'] = this.numberPerPage;
    data['currentPage'] = this.currentPage;
    if (this.sortList != null) {
      data['sortList'] = this.sortList.map((v) => v.toJson()).toList();
    }
    if (this.filters != null) {
      data['filters'] = this.filters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SortListMo {
  String columnName;
  int sortOrder;

  SortListMo({this.columnName, this.sortOrder});

  SortListMo.fromJson(Map<String, dynamic> json) {
    columnName = json['columnName'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['columnName'] = this.columnName;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}

class FiltersMo {
  String key;
  int filterType;
  String value;

  FiltersMo({this.key, this.filterType, this.value});

  FiltersMo.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    filterType = json['filterType'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['filterType'] = this.filterType;
    data['value'] = this.value;
    return data;
  }
}
