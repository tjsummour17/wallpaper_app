import 'package:app/src/common/providers/locale_provider.dart';
import 'package:app/src/common/utils/build_context_x.dart';
import 'package:app/src/common/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({Key? key}) : super(key: key);

  static const String routeName = '/SelectLanguage';

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  Locale selectedLocale = const Locale('en');

  @override
  void initState() {
    super.initState();
    LocaleProvider localeProvider = context.read();
    selectedLocale = localeProvider.locale;
  }

  void onSelectLocale(Locale? locale) {
    if (locale != null) {
      setState(() {
        selectedLocale = locale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider = context.watch();
    final locales = localeProvider.locales;
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
                      locales.length,
                      (index) => Column(
                        children: [
                          ListTile(
                            title: Text(
                              localeProvider.localeNameByLangCode(
                                locales[index].languageCode,
                              ),
                            ),
                            trailing: Radio<Locale>(
                              groupValue: selectedLocale,
                              value: locales[index],
                              onChanged: onSelectLocale,
                            ),
                            onTap: () => onSelectLocale(locales[index]),
                          ),
                          if (index < locales.length - 1) const Divider(),
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
                  localeProvider.setLocale(selectedLocale);
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
