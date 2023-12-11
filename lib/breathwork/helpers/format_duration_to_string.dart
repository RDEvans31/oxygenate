String formatDisplayTime(Duration time) {
  final minutes = time.inMinutes;
  final seconds = time.inSeconds % 60;
  final formattedTime =
      '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  return formattedTime;
}
