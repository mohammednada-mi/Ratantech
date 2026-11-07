import 'package:flutter/material.dart';
import 'package:ratan/dart/save_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ratan/dart/logic.dart';

class ScreenLogic extends StatefulWidget {
  const ScreenLogic({super.key});

  @override
  State<ScreenLogic> createState() => _ScreenLogicState();
}

class _ScreenLogicState extends State<ScreenLogic> {
  double length = 0.0;
  double width = 0.0;
  double thickness = 0.0;
  double rimLength = 0.0;
  double height = 0.0;
  double? resultfaceWidth;
  double? resultfaceLength;
  double? resultThickness;
  double? resultHeight;
  double? resultrimLength;
  double? resultbaseWidth;
  double? resultbaseLength;

  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _thicknessController = TextEditingController();
  final TextEditingController _rimLengthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      length = prefs.getDouble('length') ?? 0.0;
      width = prefs.getDouble('width') ?? 0.0;
      thickness = prefs.getDouble('thickness') ?? 0.0;
      rimLength = prefs.getDouble('rimLength') ?? 0.0;
      height = prefs.getDouble('height') ?? 0.0;

      _lengthController.text = length.toString();
      _widthController.text = width.toString();
      _thicknessController.text = thickness.toString();
      _rimLengthController.text = rimLength.toString();
      _heightController.text = height.toString();
    });
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    _thicknessController.dispose();
    _rimLengthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Logic')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // الصف الأول: الطول والعرض
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _lengthController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'الطول',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          length = double.tryParse(value) ?? 0.0;
                          SaveFile.saveData('length', value);
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: _widthController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'العرض',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          width = double.tryParse(value) ?? 0.0;
                          SaveFile.saveData('width', value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // الصف الثاني: السماكة وطول الحافة
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _thicknessController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'السماكة',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          thickness = double.tryParse(value) ?? 0.0;
                          SaveFile.saveData('thickness', value);
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: _rimLengthController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'طول الحافة',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          rimLength = double.tryParse(value) ?? 0.0;
                          SaveFile.saveData('rimLength', value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // الصف الثالث: الارتفاع
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'الارتفاع',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    height = double.tryParse(value) ?? 0.0;
                    SaveFile.saveData('height', value);
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (length <= 0 ||
                      width <= 0 ||
                      thickness <= 0 ||
                      rimLength <= 0 ||
                      height <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('الرجاء إدخال جميع القيم بشكل صحيح.'),
                      ),
                    );
                    return;
                  }
                  final logic = Logic();
                  final rfaceLength = logic.faceLength(length, rimLength);
                  final rfaceWidth = logic.faceWidth(width, thickness);
                  final rbaseLength = logic.baseLength(length);
                  final rbaseWidth = logic.baseWidth(width, thickness);

                  final rHeight = logic.column(height);
                  setState(() {
                    resultfaceWidth = rfaceWidth;
                    resultfaceLength = rfaceLength;
                    resultbaseWidth = rbaseWidth;
                    resultbaseLength = rbaseLength;
                    resultHeight = rHeight;
                  });
                },
                child: const Text('احسب'),
              ),
              const SizedBox(height: 16.0),
              if (resultfaceWidth != null &&
                  resultfaceLength != null &&
                  resultbaseWidth != null &&
                  resultbaseLength != null &&
                  resultHeight != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        Text(
                          'عرض الوجه: ${resultfaceWidth!.toStringAsFixed(2)}',
                        ),
                        Text(
                          'طول الوجه: ${resultfaceLength!.toStringAsFixed(2)}',
                        ),
                        Text(
                          'عرض القاعدة: ${resultbaseWidth!.toStringAsFixed(2)}',
                        ),
                        Text(
                          'طول القاعدة: ${resultbaseLength!.toStringAsFixed(2)}',
                        ),
                        Text(
                          'ارتفاع العمود: ${resultHeight!.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
