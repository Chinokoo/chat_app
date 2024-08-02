import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
          title: const Center(child: Text('Settings')),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Theme',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  LiteRollingSwitch(
                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode,
                    textOn: 'light',
                    textOff: 'dark',
                    colorOn: Theme.of(context).colorScheme.inversePrimary,
                    colorOff: Theme.of(context).colorScheme.inversePrimary,
                    iconOn: Icons.nightlight_round,
                    iconOff: Icons.wb_sunny,
                    textSize: 16.0,
                    onChanged: (value) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme(),
                    onTap: () {},
                    onDoubleTap: () {},
                    onSwipe: () {},
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
