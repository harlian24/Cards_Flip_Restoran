import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Menu Makanan'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://assets.simpleviewinc.com/simpleview/image/upload/c_fill,f_jpg,h_639,q_65,w_639/v1/clients/cincy/Restaurants_By_Cuisine_5be3473e-65cf-4a1d-887f-b5f3e10c9845.jpg',
            fit: BoxFit.cover,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 10, // Misalnya ada 10 menu makanan
                  itemBuilder: (BuildContext context, int index) {
                    return MenuCard(
                      title: 'Makanan $index',
                      subtitle: 'Deskripsi makanan $index',
                      price: 'Rp ${(index + 1) * 10000}',
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;

  const MenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text(title),
            subtitle: Text(subtitle),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              price,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Pesan'),
                onPressed: () {
                  _showPaymentDialog(context, title, price);
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Detail'),
                onPressed: () {
                  // Aksi ketika tombol Detail ditekan
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context, String title, String price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembayaran'),
          content:
              Text('Apakah Anda yakin ingin memesan $title seharga $price?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: Text('Bayar'),
              onPressed: () {
                // Lakukan aksi pembayaran di sini
                Navigator.of(context).pop(); // Tutup dialog setelah pembayaran
              },
            ),
          ],
        );
      },
    );
  }
}
