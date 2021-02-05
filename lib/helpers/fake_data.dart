import 'package:e_commerece_app_ezzat/local/models/product_model.dart';

abstract class FakeData {
  static List<Product> items = [
    Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        is_fav: false),
    Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
        is_fav: true),
    Product(
        id: 'p3',
        title: 'Yellow Scarf',
        description: 'Warm and cozy - exactly what you need for the winter.',
        price: 19.99,
        imageUrl:
            'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
        is_fav: true),
    Product(
        id: 'p4',
        title: 'A Pan',
        description: 'Prepare any meal you want.',
        price: 49.99,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
        is_fav: false),
    Product(
        id: 'p5',
        title: 'A Red Bag',
        description: 'Prepare any meal you want.',
        price: 10.99,
        imageUrl:
            "https://cdn.fstoppers.com/styles/medium/s3/media/2015/12/07/white_background_bag_after.jpg?itok=uj0Yl1Gv&timestamp=1449548314",
        is_fav: true),
    Product(
        id: 'p6',
        title: 'A Red Watch 2020',
        description: 'Prepare any meal you want.',
        price: 5.99,
        imageUrl:
            "https://dqg5fqdy33g0r.cloudfront.net/photos/event-planner/null/spyne/1536769630868/logo_4yfU48oeZS.",
        is_fav: false),
    Product(
        id: 'p7',
        title: 'A Camera',
        description: 'Prepare any meal you want.',
        price: 100.99,
        imageUrl:
            'https://www.dtcommercialphoto.com/wp-content/upload/IQ4_XT_23mm_50mm-1500px.jpg',
        is_fav: true),
    Product(
        id: 'p8',
        title: 'Cream Face White',
        description: 'Prepare any meal you want.',
        price: 40.99,
        imageUrl:
            'https://photographyfirm.co.uk/wp-content/uploads/2016/06/WHITE-BACKGROUND-PRODUCT-PHOTOGRAPHY-25-383x383.jpg',
        is_fav: false),
  ];
}
