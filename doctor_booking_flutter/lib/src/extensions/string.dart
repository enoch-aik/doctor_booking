extension StringCapitalization on String {
  String capitalizeFirstLetter() {
    if (isEmpty) return this;

    // Split the string by spaces
    List<String> words = split(' ');

    // Capitalize the first letter of each word
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }

    // Join the words back together with spaces
    return words.join(' ');
  }
}

void main() {
  String name = 'john doe';
  String capitalizedName = name.capitalizeFirstLetter();
  //print(capitalizedName); // Output: "John Doe"
}
