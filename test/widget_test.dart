import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '';
  double _num1 = 0.0;
  String _operator = '';
  bool _isResultCalculated = false;

  void _onButtonPressed(String buttonText) {
    if (buttonText == 'C') {
      _clearDisplay();
    } else if (buttonText == '=') {
      _calculateResult();
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      _setOperator(buttonText);
    } else {
      _updateDisplay(buttonText);
    }
  }

  void _updateDisplay(String text) {
    if (_isResultCalculated) {
      _displayText = text;
      _isResultCalculated = false;
    } else {
      setState(() {
        _displayText += text;
      });
    }
  }

  void _clearDisplay() {
    setState(() {
      _displayText = '';
      _num1 = 0.0;
      _operator = '';
      _isResultCalculated = false;
    });
  }

  void _setOperator(String operator) {
    setState(() {
      _num1 = double.parse(_displayText);
      _operator = operator;
      _displayText += ' $operator ';
    });
  }

  void _calculateResult() {
    if (_operator.isEmpty || _displayText.isEmpty) return;

    List<String> parts = _displayText.split(' $_operator ');

    if (parts.length != 2) {
      _displayText = 'Error';
      return;
    }

    double num2 = double.parse(parts[1]);
    double result = 0.0;

    switch (_operator) {
      case '+':
        result = _num1 + num2;
        break;
      case '-':
        result = _num1 - num2;
        break;
      case '*':
        result = _num1 * num2;
        break;
      case '/':
        if (num2 != 0) {
          result = _num1 / num2;
        } else {
          _displayText = 'Error';
          return;
        }
        break;
    }

    setState(() {
      _displayText = result.toString();
      _isResultCalculated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.black87,
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _displayText,
                style: TextStyle(fontSize: 36.0, color: Colors.white),
              ),
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          _buildButtonRow(['7', '8', '9', '/']),
          _buildButtonRow(['4', '5', '6', '*']),
          _buildButtonRow(['1', '2', '3', '-']),
          _buildButtonRow(['0', '.', 'C', '+']),
          Divider(height: 1.0, color: Colors.grey),
          _buildButtonRow(['=']),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> texts) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: texts.map((text) => _buildCalcButton(text)).toList(),
      ),
    );
  }

  Widget _buildCalcButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(text),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[800], // Change button color to grey
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ),
    );
  }
}
