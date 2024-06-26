import 'package:flutter/material.dart';
import 'package:good_morning_app1/presentation/journeys/details_screen.dart';
import 'package:good_morning_app1/presentation/widgets/parallax_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// This is your screen where you want to display list
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final hotelImages = [
    'https://glowmess.com/en/wp-content/uploads/2024/01/good-morning-quotes.jpg.webp',
    'https://goodmorningland.com/wp-content/uploads/2023/05/Beautiful-Good-Morning-Quotes-For-Her.jpg',
    'https://marketplace.canva.com/EAFrsFQN0fA/1/0/900w/canva-beige-and-brown-elegant-good-morning-instagram-reels-RjsYIUy7G4Q.jpg',
    'https://www.icegif.com/wp-content/uploads/2022/07/icegif-1117.gif',
    'https://i.pinimg.com/736x/81/c7/ff/81c7ff4ea1bf29439340cabce3d7814b.jpg',
    'https://i.pinimg.com/736x/fa/82/09/fa82091da54205079f39d1add2c2c4e5.jpg',
    'https://i.pinimg.com/564x/59/d5/ac/59d5ac38268ec1cbbb69b79b98f26aea.jpg',
    'https://i.pinimg.com/736x/9b/f7/9a/9bf79a80a11b95bf78108829c42d38c5.jpg',
    'https://i.pinimg.com/564x/db/04/a1/db04a1eb892a69ca4da7e9519cd98e4f.jpg',
    'https://media1.giphy.com/media/ZXXshfXaR8IwQFUEj7/giphy.gif?cid=6c09b9526cr7uqrvefsgey4pbivnj2kbnjbsz82vhud2uexc&ep=v1_internal_gif_by_id&rid=giphy.gif&ct=g',
    'https://glowmess.com/en/wp-content/uploads/2024/01/have-a-blessed-day.jpg.webp',
    'https://www.lovethispic.com/uploaded_images/399006-Beautiful-Rainbow-Daisy-Butterfly-Good-Morning-Gif.gif',
    'https://i.pinimg.com/736x/73/c4/ae/73c4ae2ee31ee2478e30cd84a1b642d4.jpg',
    'https://www.gifcen.com/wp-content/uploads/2022/01/good-morning-gif-11.gif',
    'https://glowmess.com/en/wp-content/uploads/2024/01/have-a-good-day.jpg.webp',
    'https://i.pinimg.com/originals/04/a7/eb/04a7eb63ab67d291e7350af39827640c.gif',
    'https://glowmess.com/en/wp-content/uploads/2024/01/good-morning-greetings.jpg.webp',
    'https://i.pinimg.com/originals/53/2b/54/532b5450381f1ff920c7776c74fd9465.gif',
    'https://static.tnn.in/photo/104327756/104327756.jpg',
    'https://i.pinimg.com/originals/78/13/66/781366b7ae656e4cd77e18b140ba4a0b.gif',
    'https://goodmorningland.com/wp-content/uploads/2022/10/Latest-Good-Morning-Pictures-On-Pinterest-For-Download.jpg',
    'https://i.pinimg.com/736x/f6/b2/b9/f6b2b9f0f394a9f3596e6877e60b2ac9.jpg',
    'https://marketplace.canva.com/EAFEcfcyw24/1/0/900w/canva-yellow-good-morning-instagram-your-story-DP6IenjOZJQ.jpg',
    'https://media1.giphy.com/media/wFVcp526Gj0B1RnslJ/giphy.gif?cid=6c09b952g2wuqhg6ojghuy5nyw3v2861pa9n7h98o46st02v&ep=v1_internal_gif_by_id&rid=giphy.gif&ct=g',
  ];
  final Connectivity _connectivity = Connectivity();
  late Stream<ConnectivityResult> _connectivityStream;

  @override
  void initState() {
    super.initState();
    _connectivityStream = _connectivity.onConnectivityChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Good Morning Wishes & Images',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: _connectivityStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == ConnectivityResult.none) {
              return const Center(
                child: Text('No Internet Connection'),
              );
            }
            return ImagesList(hotelImages: hotelImages);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ImagesList extends StatelessWidget {
  const ImagesList({
    super.key,
    required this.hotelImages,
  });

  final List<String> hotelImages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsScreen(
                imagePath: hotelImages[index],
              ),
            ));
          },
          child: ParallaxImage(
            imagePath: hotelImages[index],
          ),
        ),
      ),
      itemCount: hotelImages.length,
    );
  }
}
