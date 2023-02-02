class Category {
  int id;
  String title;
  String icon;

  Category({
    required this.id,
    required this.title,
    required this.icon,
  });
}

List<Category> categories = [
  Category(id: 1, title: "Healthy", icon: "carrot.png"),
  Category(id: 2, title: "Sweets", icon: "cake.png"),
  Category(id: 3, title: "Burger", icon: "burger.png"),
  Category(id: 4, title: "Sushi", icon: "sushi.png"),
];
