import 'package:flutter/material.dart';
import 'package:kailo/utils/constants.dart';

class AddOption extends StatefulWidget {
  final int questionIndex;
  double rating;
  AddOption(this.questionIndex, this.rating);
  @override
  _AddOptionState createState() => _AddOptionState();
}

class _AddOptionState extends State<AddOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SliderTheme(
            data: SliderThemeData(
              activeTickMarkColor: Colors.white,
              inactiveTrackColor: Colors.grey,
              activeTrackColor: Colors.purple.shade400,
              thumbColor: Colors.purple.shade600,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
            ),
            child: Slider(
              value: widget.rating,
              onChanged: (newRating) {
                scoreValues[widget.questionIndex] = newRating;
                setState(() {
                  widget.rating = newRating;
                });
              },
              min: 0,
              max: 4,
              divisions: 4,
              label: widget.rating.round().toString(),
            ),
          ),
        ),
      ),
    );
  }
}

// List<bool> _selections = List.generate(5, (_) => false);
//     child: ToggleButtons(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//             child: Text('0'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//             child: Text('1'),
//             ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//             child: Text('2'),
//             ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//             child: Text('3'),
//             ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//             child: Text('4'),
//             ),
//         ],
//         isSelected: _selections,
//         onPressed: (int index){
//           setState(() {
//             for (int i = 0; i < _selections.length; i++) {
//             _selections[i] = i == index;
//           }
//         });
//       },
//       color: Colors.black,
//       selectedColor: Colors.white,
//       fillColor: Colors.blue,
//     ),
