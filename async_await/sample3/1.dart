// 同期コード
void printDailyNewsDigest() {
  var newsDigest = gatherNewsReports(); // 時間がかかり得る
  print(newsDigest);
}

main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}
