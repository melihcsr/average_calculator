import 'package:flutter/material.dart';
import 'package:ortalama_hesapla/bilgiler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String harfDeger = 'CC';
  var tfController = TextEditingController();
  double krediDeger = 1.0;
  double ortalama = 0;
  List<Bilgiler> ogrenciler = [];
  var harfler = [
    'AA',
    'BA',
    'BB',
    'CB',
    'CC',
    'DC',
    'DD',
    'FD',
    "FF",
  ];
  var kredi = [
    1.0,
    2.0,
    3.0,
    4.0,
    5.0,
    6.0,
    7.0,
    8.0,
    9.0,
    10.0,
  ];
  double toplamNot = 0;
  double toplamKredi = 0;
  double ortalamaHesapla(double krediSayisi, double puanDegeri) {
    ogrenciler.forEach((element) {
      toplamNot = toplamNot + (element.krediSayisi * puanDegeri);
      toplamKredi += element.krediSayisi;
    });
    return (toplamNot / toplamKredi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "Ortalama Hesaplama",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Expanded(
                          child: Container(
                            width: 190,
                            height: 50,
                            child: TextFormField(
                              controller: tfController,
                              decoration: const InputDecoration(
                                  hintText: "Ders Giriniz",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(235, 236, 246, 1),
                              ),
                              child: DropdownButton(
                                value: harfDeger,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: harfler.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    harfDeger = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(235, 236, 246, 1),
                              ),
                              child: DropdownButton(
                                value: krediDeger,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: kredi.map((double items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text("$items"),
                                  );
                                }).toList(),
                                onChanged: (double? newValue) {
                                  setState(() {
                                    krediDeger = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    Bilgiler yeniOgrenci = Bilgiler(
                                        dersAdi: tfController.text,
                                        harfNotu: harfDeger,
                                        krediSayisi: krediDeger);

                                    ogrenciler.add(yeniOgrenci);
                                    var puanDegeri = harfiNotaCevir(harfDeger);

                                    ortalama =
                                        ortalamaHesapla(krediDeger, puanDegeri);
                                  });
                                },
                                icon: Icon(Icons.arrow_forward_ios),
                                color: Colors.indigo,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, top: 20),
                  child: Column(
                    children: [
                      Text(
                        "${ogrenciler.length} Ders Girildi",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${ortalama.toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.indigo,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Ortalama"),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: ogrenciler.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      child: ListTile(
                        subtitle: Text(
                            "Kredi Degeri => ${ogrenciler[index].krediSayisi} , Not Degeri => ${ogrenciler[index].harfNotu}"),
                        leading: Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 40,
                          height: 40,
                        ),
                        title: Text(ogrenciler[index].dersAdi),
                      ),
                    );
                  })),
            )
          ],
        ),
      )),
    );
  }
}

double harfiNotaCevir(String harf) {
  switch (harf) {
    case "AA":
      return 4.0;
    case "BA":
      return 3.5;
    case "BB":
      return 3.0;
    case "CB":
      return 2.5;
    case "CC":
      return 2.0;
    case "DC":
      return 1.5;
    case "DD":
      return 1.0;
    case "FF":
      return 0.0;
  }
  return 0.0;
}
