String formatString(String input) {
  const Map<String, String> accents = {
    'á': 'a',
    'é': 'e',
    'í': 'i',
    'ó': 'o',
    'ú': 'u',
    'â': 'a',
    'ê': 'e',
    'î': 'i',
    'ô': 'o',
    'û': 'u',
    'ã': 'a',
    'õ': 'o',
    'ç': 'c',
  };

  String result = input.replaceAllMapped(
    RegExp(r'[áéíóúâêîôûãõç]'),
    (match) => accents[match.group(0)]!,
  );

  result = result.replaceAll(' ', '-');
  result = result.replaceAll('.', '');

  result = result.toLowerCase();

  return result;
}
