import 'package:flutter/material.dart';
import 'package:quick_plate/widgets/rect_slider_thumb_shape.dart';

class SelectMacrosScreen extends StatefulWidget {
  const SelectMacrosScreen({super.key});

  @override
  _SelectMacrosScreenState createState() => _SelectMacrosScreenState();
}

class _SelectMacrosScreenState extends State<SelectMacrosScreen> {
  double _carbSliderValue = 10.0;
  double _proteinSliderValue = 0.0;
  double _fatSliderValue = 5.0;
  double _caloriesSliderValue = 300.0;
  double _fiberSliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextStyle sliderTextTheme = theme.textTheme.headlineSmall!.copyWith(
        // color: Colors.white,
        );
    return Scaffold(
      // backgroundColor: const Color(0xFF3E5F41),
      // backgroundColor: const Color.fromARGB(255, 159, 171, 206),
      appBar: AppBar(
        title: Text(
          'Select Macros',
          style: theme.textTheme.headlineLarge!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SliderTheme(
            data: const SliderThemeData(
              trackHeight: 4.0,
              thumbShape: RectSliderThumbShape(),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
              rangeTrackShape: RectangularRangeSliderTrackShape(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Carbs: ${_carbSliderValue.round()} g',
                  style: sliderTextTheme,
                ),
                Slider(
                  value: _carbSliderValue,
                  min: 10.0,
                  max: 150.0,
                  divisions: 150,
                  label: '${_carbSliderValue.round().toString()} g',
                  onChanged: (value) {
                    setState(() {
                      _carbSliderValue = value;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Protein: ${_proteinSliderValue.round()} g',
                  style: sliderTextTheme,
                ),
                Slider(
                  value: _proteinSliderValue,
                  min: 0.0,
                  max: 150.0,
                  divisions: 150,
                  label: '${_proteinSliderValue.round().toString()} g',
                  onChanged: (value) {
                    setState(() {
                      _proteinSliderValue = value;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Fat: ${_fatSliderValue.round()} g',
                  style: sliderTextTheme,
                ),
                Slider(
                  value: _fatSliderValue,
                  min: 5.0,
                  max: 100.0,
                  divisions: 100,
                  label: '${_fatSliderValue.round().toString()} g',
                  onChanged: (value) {
                    setState(() {
                      _fatSliderValue = value;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Calories: ${_caloriesSliderValue.round()} kcal',
                  style: sliderTextTheme,
                ),
                Slider(
                  value: _caloriesSliderValue,
                  min: 300,
                  max: 1500.0,
                  divisions: 150,
                  label: '${_caloriesSliderValue.round().toString()} kcal',
                  onChanged: (value) {
                    setState(() {
                      _caloriesSliderValue = value;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Fiber: ${_fiberSliderValue.round()} g',
                  style: sliderTextTheme,
                ),
                Slider(
                  value: _fiberSliderValue,
                  min: 0.0,
                  max: 30.0,
                  divisions: 30,
                  label: '${_fiberSliderValue.round().toString()} g',
                  onChanged: (value) {
                    setState(() {
                      _fiberSliderValue = value;
                    });
                  },
                ),
                const SizedBox(height: 64.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                  ),
                  child: Text(
                    'Generate',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
