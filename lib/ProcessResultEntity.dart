class ProcessResultEntity {
  int pid = 0;
  int phashCode = 0;
  int exitCode = 127;
  String stderr = "";
  String stdout = "";

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
