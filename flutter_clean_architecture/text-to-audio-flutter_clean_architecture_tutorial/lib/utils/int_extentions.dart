extension TimerFormatter on int {
  String toFormattedTime() {
    String numberStr = this.toString();
    if (this < 10) {
      numberStr = '0' + numberStr;
    }
    return numberStr;
  }
}
