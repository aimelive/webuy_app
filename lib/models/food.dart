class Food {
  int id;
  int categoryId;
  String title;
  double price;
  String currency;
  String imgUrl;
  int quantity;

  Food({
    required this.id,
    required this.categoryId,
    this.currency = "USD",
    this.quantity = 1,
    required this.imgUrl,
    required this.price,
    required this.title,
  });
}

List<Food> foods = [
  Food(
    id: 1,
    categoryId: 2,
    imgUrl:
        "https://res.cloudinary.com/dofeqwgfb/image/upload/v1675249491/image_4_bkuegk.png",
    price: 89,
    title: "Martabak Ujang",
  ),
  Food(
    id: 2,
    categoryId: 1,
    imgUrl:
        "https://res.cloudinary.com/dofeqwgfb/image/upload/v1675249544/image_4_1_zxoucz.png",
    price: 12.5,
    title: "Es Tongtong",
  ),
  Food(
    id: 3,
    categoryId: 4,
    imgUrl:
        "https://res.cloudinary.com/dofeqwgfb/image/upload/v1675249544/image_4_2_xy6xcm.png",
    price: 59,
    title: "Donat Cherry",
  ),
  Food(
    id: 4,
    categoryId: 2,
    imgUrl:
        "https://res.cloudinary.com/dofeqwgfb/image/upload/v1675249544/image_4_3_q48vmi.png",
    price: 80,
    title: "Telur Jahe",
  ),
  Food(
    id: 5,
    categoryId: 3,
    imgUrl:
        "https://res.cloudinary.com/dofeqwgfb/image/upload/v1675249544/image_4_4_msmah0.png",
    price: 45,
    title: "Silver Choco",
  ),
  Food(
    id: 6,
    categoryId: 2,
    imgUrl:
        "https://res.cloudinary.com/dofeqwgfb/image/upload/v1675249544/image_4_5_tlqz2p.png",
    price: 90,
    title: "Candy Pizza",
  ),
];
