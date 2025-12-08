import 'package:flutter/material.dart';
import '../colors.dart';
import '../models/flight.dart';
import 'flight_detail_screen.dart';

class FlightListScreen extends StatelessWidget {
  const FlightListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flights = [
      Flight(
        from: 'New York',
        to: 'Indonesia',
        fromCode: 'NYC',
        toCode: 'IDN',
        departureTime: '09:00 AM',
        arrivalTime: '21:00 PM',
        date: '20 June, 2021',
        price: '\$400',
      ),
      Flight(
        from: 'New York',
        to: 'Indonesia',
        fromCode: 'NYC',
        toCode: 'IDN',
        departureTime: '12:00 AM',
        arrivalTime: '00:00 AM',
        date: '20 June, 2021',
        price: '\$200',
      ),
    ];

    return Scaffold(
      backgroundColor: FlightColors.lightPurple,
      appBar: AppBar(
        backgroundColor: FlightColors.primaryPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              gradient: FlightColors.purpleGradient,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: FlightColors.accentBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.flight_takeoff, color: Colors.white, size: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'NYC',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'New York',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          '20 June, 2021',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: List.generate(
                        10,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 4,
                          height: 1,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          'IDN',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Indonesia',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filter Row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.tune, color: FlightColors.darkPurple),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: FlightColors.accentOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.arrow_downward, color: Colors.white),
                ),
              ],
            ),
          ),
          
          // Flight List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: flights.length,
              itemBuilder: (context, index) {
                return _buildFlightCard(context, flights[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightCard(BuildContext context, Flight flight) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FlightDetailScreen(flight: flight)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: FlightColors.primaryPurple.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      flight.fromCode,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: FlightColors.darkPurple,
                      ),
                    ),
                    Text(
                      flight.from,
                      style: TextStyle(
                        fontSize: 12,
                        color: FlightColors.darkPurple.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: List.generate(
                    10,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 4,
                      height: 1,
                      color: FlightColors.darkPurple.withOpacity(0.3),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      flight.toCode,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: FlightColors.darkPurple,
                      ),
                    ),
                    Text(
                      flight.to,
                      style: TextStyle(
                        fontSize: 12,
                        color: FlightColors.darkPurple.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  flight.departureTime,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: FlightColors.darkPurple,
                  ),
                ),
                Text(
                  flight.arrivalTime,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: FlightColors.darkPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  flight.date,
                  style: TextStyle(
                    fontSize: 12,
                    color: FlightColors.darkPurple.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(
                30,
                (index) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    height: 1,
                    color: FlightColors.darkPurple.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lorem ipsum',
                  style: TextStyle(
                    color: FlightColors.darkPurple,
                  ),
                ),
                Text(
                  flight.price,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: FlightColors.darkPurple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
