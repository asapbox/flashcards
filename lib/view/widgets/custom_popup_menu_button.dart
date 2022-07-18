import 'package:flashcards/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_horiz_outlined),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dark Mode'),
              Consumer<ProfileManager>(
                builder: (context, state, child) {
                  return Switch(
                    value: state.isDarkMode,
                    onChanged: (bool value) {
                      state.setDarkMode(value);
                    },
                  );
                },
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('My Favorites'),
            ],
          ),
        ),
      ],
    );
  }
}