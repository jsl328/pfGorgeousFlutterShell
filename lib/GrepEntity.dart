class GrepEntity {
  String grepName = "";
  int status = 0;
  String grepRes = "";

  // 默认构造函数,无参数
  GrepEntity();
  void setInfo(
    String grepName,
    int status,
    String grepRes,
  ) {
    this.grepName = grepName;
    this.status = status;
    this.grepRes = grepRes;
  }

  void getInfo() {
    print('${this.grepName}-----${this.status} ----${this.grepRes}');
  }
}
