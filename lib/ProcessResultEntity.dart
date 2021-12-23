// classs: ProcessResultEntity
// description: shell.run()序列化实体类
// author : jiangsl
// date: 22/12 2021

class ProcessResultEntity {
  int pid = 0; //线程pid
  int phashCode = 0;
  int exitCode = 127; //错误码
  String stderr = ""; // error
  String stdout = ""; //标准输出

  // 默认构造函数,无参数
  ProcessResultEntity();

  void setInfo(
    int pid,
    int phashCode,
    int pexitCode,
    String stdout,
  ) {
    this.pid = pid;
    this.phashCode = phashCode;
    this.exitCode = pexitCode;
    this.stdout = stdout;
  }

  void getInfo() {
    print('$this.pid-----$this.phashCode ----$this.stdout');
  }
}
