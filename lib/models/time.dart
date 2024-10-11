class TimeItem {
  final int id;
  final String title;
  final String end;
  final int slot;
  final int kuotaBooking;
  final int kuotaKiosk;
  final bool available;

  TimeItem({
    required this.id,
    required this.title,
    required this.end,
    required this.slot,
    required this.kuotaBooking,
    required this.kuotaKiosk,
    required this.available,
  });
}
