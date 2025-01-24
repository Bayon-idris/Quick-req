import 'package:flutter/material.dart';

class DropdownContainer extends StatefulWidget {
  final List<String> options;
  final String title;
  final String subtitle;
  final bool isTextField;
  final ValueChanged<String?>? onChanged; // Ajout du paramètre onChanged

  const DropdownContainer({
    Key? key,
    required this.options,
    this.title = 'Unite(UE)',
    this.subtitle = 'Click Here To Select a UE',
    this.isTextField = false,
    this.onChanged, // Ajout du paramètre onChanged
  }) : super(key: key);

  @override
  _DropdownContainerState createState() => _DropdownContainerState();
}

class _DropdownContainerState extends State<DropdownContainer> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    if (widget.isTextField) {
      return Container(
        width: MediaQuery.of(context).size.width * 3 / 2,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 10,
              bottom: 10,
              child: Icon(
                Icons.label_important_outline,
                size: 24,
                color: Colors.black,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.title,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Click to enter your title',
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width * 3 / 2,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.title,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    hint: Text(widget.subtitle),
                    icon: SizedBox.shrink(),
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(newValue); // Appel de la fonction onChanged
                      }
                    },
                    items: widget.options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Colors.black,
                  size: 36,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}