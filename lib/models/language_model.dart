class Language{
  final LanguageName name;
  final String visualName;
  final String flag;

  Language({
    required this.name,
    required this.visualName,
    required this.flag,
});

  static List<Language> languageList(){
    return [
      Language(name: LanguageName.ita, visualName: "Italiano", flag: "🇮🇹"),
      Language(name: LanguageName.eng, visualName: "English", flag: "🇬🇧"),
    ];
  }
}


enum LanguageName{
  eng,
  ita
}