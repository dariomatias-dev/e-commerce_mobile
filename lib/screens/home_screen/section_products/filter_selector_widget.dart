import 'package:flutter/material.dart';

class FilterSelectorWidget extends StatefulWidget {
  const FilterSelectorWidget({super.key});

  @override
  State<FilterSelectorWidget> createState() => _FilterSelectorWidgetState();
}

List<String> names = [
  "Menor preço",
  "Maior preço",
  "Promoções",
  "Mais procurados",
  "Mais avaliados",
];

class _FilterSelectorWidgetState extends State<FilterSelectorWidget> {
  String dropdownValue = names.first;

  void setDropdownValue(String value) {
    setState(() {
      dropdownValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: dropdownValue,
        onChanged: (value) => setDropdownValue(value as String),
        underline: const SizedBox(),
        items: names.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
      ),
    );
  }
}
