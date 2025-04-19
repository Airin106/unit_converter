import 'package:flutter/material.dart';

void main() {
  runApp(ConverterApp());
}

class ConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Segoe UI',
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
      ),
      home: ConverterPage(),
    );
  }
}

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _controller = TextEditingController();
  String _convertedValue = "";

  String _category = "Distance";
  String _selectedConversion = "Km to Miles";

  final Map<String, List<String>> _conversionOptions = {
    "Distance": [
      "Km to Miles",
      "Miles to Km",
      "Inch to Cm",
      "Cm to Inch",
      "Meter to Foot",
      "Foot to Meter",
    ],
    "Temperature": [
      "Celsius to Fahrenheit",
      "Fahrenheit to Celsius",
      "Celsius to Kelvin",
      "Kelvin to Celsius",
    ],
  };

  void _convert() {
    double? input = double.tryParse(_controller.text);
    if (input == null) {
      setState(() {
        _convertedValue = "Please enter a valid number.";
      });
      return;
    }

    double result;
    String unitResult = "";

    if (_category == "Distance") {
      switch (_selectedConversion) {
        case "Km to Miles":
          result = input * 0.621371;
          unitResult = "$input km = ${result.toStringAsFixed(2)} miles";
          break;
        case "Miles to Km":
          result = input / 0.621371;
          unitResult = "$input miles = ${result.toStringAsFixed(2)} km";
          break;
        case "Inch to Cm":
          result = input * 2.54;
          unitResult = "$input inches = ${result.toStringAsFixed(2)} cm";
          break;
        case "Cm to Inch":
          result = input / 2.54;
          unitResult = "$input cm = ${result.toStringAsFixed(2)} inches";
          break;
        case "Meter to Foot":
          result = input * 3.28084;
          unitResult = "$input meters = ${result.toStringAsFixed(2)} feet";
          break;
        case "Foot to Meter":
          result = input / 3.28084;
          unitResult = "$input feet = ${result.toStringAsFixed(2)} meters";
          break;
      }
    } else if (_category == "Temperature") {
      switch (_selectedConversion) {
        case "Celsius to Fahrenheit":
          result = (input * 9 / 5) + 32;
          unitResult = "$input °C = ${result.toStringAsFixed(2)} °F";
          break;
        case "Fahrenheit to Celsius":
          result = (input - 32) * 5 / 9;
          unitResult = "$input °F = ${result.toStringAsFixed(2)} °C";
          break;
        case "Celsius to Kelvin":
          result = input + 273.15;
          unitResult = "$input °C = ${result.toStringAsFixed(2)} K";
          break;
        case "Kelvin to Celsius":
          result = input - 273.15;
          unitResult = "$input K = ${result.toStringAsFixed(2)} °C";
          break;
      }
    }

    setState(() {
      _convertedValue = unitResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    final conversionList = _conversionOptions[_category]!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A148C), Color(0xFF00796B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            width: double.infinity,
            constraints: BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.swap_calls_rounded, size: 50, color: Colors.teal),
                const SizedBox(height: 10),
                Text(
                  "Unit Converter",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 25),

                // Category Dropdown (Distance or Temperature)
                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items:
                      ["Distance", "Temperature"]
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                      _selectedConversion =
                          _conversionOptions[_category]!.first;
                      _convertedValue = "";
                      _controller.clear();
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Conversion Type Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedConversion,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items:
                      conversionList
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                      _convertedValue = "";
                      _controller.clear();
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Input Field
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter value",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.straighten),
                  ),
                ),
                const SizedBox(height: 20),

                // Convert Button
                ElevatedButton.icon(
                  onPressed: _convert,
                  icon: Icon(Icons.sync_alt),
                  label: Text("Convert"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Result Display
                Text(
                  _convertedValue,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}