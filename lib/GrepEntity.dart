// classs: GrepEntity
// description: which()序列化实体类
// author : jiangsl
// date: 22/12 2021

class GrepEntity {
  String grepName = "";
  int status = 0;
  String grepRes = ""; //which()返回的shell命令行路径，只有路径才可以调用shell.run()

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
