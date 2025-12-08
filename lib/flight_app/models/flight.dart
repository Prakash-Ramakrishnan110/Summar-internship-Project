class Flight {
  final String from;
  final String to;
  final String fromCode;
  final String toCode;
  final String departureTime;
  final String arrivalTime;
  final String date;
  final String price;
  final String airline;
  final String seatNumber;

  Flight({
    required this.from,
    required this.to,
    required this.fromCode,
    required this.toCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
    required this.price,
    this.airline = 'Alexson',
    this.seatNumber = '15A',
  });
}
