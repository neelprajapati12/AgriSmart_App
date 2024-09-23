import 'dart:convert';
import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WeatherForecast_page extends StatefulWidget {
  final temp;
  final humidity;
  final wind;
  final pressure;
  WeatherForecast_page(
      {required this.humidity,
      required this.pressure,
      required this.temp,
      required this.wind,
      super.key});

  @override
  State<WeatherForecast_page> createState() => _WeatherForecast_pageState();
}

class _WeatherForecast_pageState extends State<WeatherForecast_page> {
  List temp = [];
  List weatherCondition = [];
  bool isLoading = false;
  double roundedTemp = 0;

  Future<void> getWeather() async {
    try {
      setState(() {
        isLoading = true;
      });

      final apiKey = '429fe6c2a4e8b682c98b1afc04bcf293';
      final response = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?id=524901&appid=$apiKey'),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<double> tempList = [];
        List<String> weatherConditionList = [];

        for (var item in data['list']) {
          double tempInCelsius =
              item['main']['temp'] - 273.15; // Convert from Kelvin to Celsius
          tempList.add(double.parse(
              tempInCelsius.toStringAsFixed(2))); // Round to two decimal places

          weatherConditionList.add(item['weather'][0]['main']);
        }

        setState(() {
          temp = tempList;
          weatherCondition = weatherConditionList;
          print(temp);
          print(weatherCondition);
        });
      } else {
        print("There's an error: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // print("into the init state");
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          'Weather forecast',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: temp.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.greenn,
            ))
          : weatherCondition.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColors.greenn,
                ))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Fri, 30th Aug, 2024',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: h * 0.15,
                            width: w * 0.9,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  weatherDayWidget('Today', '${widget.temp}',
                                      Icons.wb_sunny, true),
                                  weatherDayWidget(
                                      'Sat', '${temp[0]}', Icons.wb_sunny),
                                  weatherDayWidget(
                                      'Sun', '32° C', Icons.wb_sunny),
                                  weatherDayWidget(
                                      'Mon', '32° C', Icons.wb_sunny),
                                  weatherDayWidget(
                                      'Tue', '32° C', Icons.wb_sunny),
                                  weatherDayWidget(
                                      'Wed', '31° C', Icons.wb_cloudy),
                                  weatherDayWidget(
                                      'Thu', '28° C', Icons.wb_cloudy),
                                  weatherDayWidget(
                                      'Fri', '29° C', Icons.wb_sunny),
                                  weatherDayWidget(
                                      'Sat', '32° C', Icons.wb_sunny),
                                  weatherDayWidget(
                                      'Sun', '32° C', Icons.wb_sunny),
                                  weatherDayWidget(
                                      'Mon', '30° C', Icons.wb_sunny),
                                  weatherDayWidget(
                                      'Tue', '29° C', Icons.wb_sunny),
                                  weatherDayWidget(
                                      'Wed', '31° C', Icons.wb_cloudy),
                                  weatherDayWidget(
                                      'Thu', '28° C', Icons.wb_cloudy),
                                  weatherDayWidget(
                                      'Fri', '29° C', Icons.wb_sunny),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 5,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      'Mumbai',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Icon(Icons.wb_sunny, color: Colors.black),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${widget.temp}° C',
                                  style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                weatherDetailWidget(
                                    'Humidity', '${widget.humidity}%'),
                                weatherDetailWidget(
                                    'Pressure', '${widget.pressure} Atm'),
                                weatherDetailWidget('Wind', '${widget.wind}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Weather update',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            weatherUpdateWidget(
                                'Saturday',
                                '31 Aug, 2024',
                                '${weatherCondition[0]}',
                                '${temp[0]}° C',
                                Icons.wb_sunny),
                            weatherUpdateWidget(
                                'Sunday',
                                '1 Sep, 2024',
                                '${weatherCondition[1]}',
                                '${temp[1]}° C',
                                Icons.wb_sunny),
                            weatherUpdateWidget(
                                'Monday',
                                '2 Sep, 2024',
                                '${weatherCondition[2]}',
                                '${temp[2]}° C',
                                Icons.wb_sunny),
                            weatherUpdateWidget(
                                'Tuesday',
                                '3 Sep, 2024',
                                '${weatherCondition[3]}',
                                '${temp[3]}° C',
                                Icons.wb_sunny),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget weatherDayWidget(String day, String temperature, IconData icon,
      [bool isSelected = false]) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.greenn : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              temperature,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
          ],
        ),
      ),
    );
  }

  Widget weatherDetailWidget(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget weatherUpdateWidget(
      String day, String date, String weather, String temp, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                weather,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 16),
              Text(
                temp,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
