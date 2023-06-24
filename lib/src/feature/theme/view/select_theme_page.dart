import 'package:app/src/common/providers/theme_provider.dart';
import 'package:app/src/common/utils/build_context_x.dart';
import 'package:app/src/common/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectThemePage extends StatefulWidget {
  const SelectThemePage({Key? key}) : super(key: key);

  static const String routeName = '/SelectTheme';

  @override
  State<SelectThemePage> createState() => _SelectThemePageState();
}

class _SelectThemePageState extends State<SelectThemePage> {
  ThemeMode selectedTheme = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    ThemeProvider themeProvider = context.read();
    selectedTheme = themeProvider.themeMode;
  }

  void onSelectLocale(ThemeMode? theme) {
    if (theme != null) {
      setState(() {
        selectedTheme = theme;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.watch();
    const themes = ThemeMode.values;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.language),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colorScheme.surface,
                  ),
                  child: Column(
                    children: List.generate(
                      themes.length,
                      (index) => Column(
                        children: [
                          ListTile(
                            title: Text(themes[index].name),
                            trailing: Radio<ThemeMode>(
                              groupValue: selectedTheme,
                              value: themes[index],
                              onChanged: onSelectLocale,
                            ),
                            onTap: () => onSelectLocale(themes[index]),
                          ),
                          if (index < themes.length - 1) const Divider(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: context.screenWidth - 25,
              child: AppButton(
                label: context.localizations.save,
                onPressed: () {
                  themeProvider.themeMode = selectedTheme;
                  context.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
