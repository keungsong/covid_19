import 'package:flutter/material.dart';

class NavigationOption extends StatelessWidget {
  final String title;
  final bool selected;
  final Function() onSelected;

  NavigationOption(
      {@required this.title,
      @required this.selected,
      @required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: selected ? Color(0xFF166DE0) : Colors.grey[400],
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          selected
              ? Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
