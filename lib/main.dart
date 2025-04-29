import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const autora());
}

class autora extends StatelessWidget{
  const autora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Autora",
      debugShowCheckedModeBanner: false,
      home: autoraHome(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white,)
    );
  }
}

class Car {
  final String name;
  final String imagePath;
  final String details;

  Car({required this.name, required this.imagePath, required this.details});
}

final List<Car> carList = [
  Car(name: "Tesla Model S", imagePath: 'assets/Tesla Model S.jpg', details: "Range: 348ml\nTopSpeed: 200mph\nPower: 1020hp"),
  Car(name: "BMW M3 Competition", imagePath: 'assets/BMW M3 Competition.jpg', details: "Engine: 3.0L Twin-Turbocharged Inline-Six\nTop Speed: 155mph\nPower: 503hp"),
  Car(name: "Mercedes G Wagon", imagePath: 'assets/Mercedes G Wagon.jpg', details: "Engine:  3.0L Inline-Six Turbo\nTorque: 627 lb-ft\nPower: 577hp")
];

class autoraHome extends StatelessWidget {
  const autoraHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AUTORA", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: Color(0xff000000)),),
        centerTitle: true,
        backgroundColor: Color(0xf6f6f6f6),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: ListView.builder(
          itemCount: carList.length,
          
          itemBuilder: (context, index) {
            final car = carList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => carDetailPage(car: car)));
              },

              child: Card(
                color: Color(0xf6f6f6f6),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                elevation: 2,

                child: Padding(
                  padding: const EdgeInsets.all(10),
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: car.imagePath,
                        child: Image.asset(car.imagePath, height: 80, width: 80, fit: BoxFit.cover)
                      ),

                      SizedBox(width: 20,),

                      Expanded(
                        child: Hero(
                          tag: car.name,
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              car.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Color(0xff000000))
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            );
          }
        )
      )
    );
  }
}

class carDetailPage extends StatelessWidget {
  final Car car;

  const carDetailPage({required this.car});

  List<MapEntry<String, String>> parseDetails(String details) {
    return details
        .split('\n')
        .map((line) => line.split(':'))
        .where((pair) => pair.length == 2)
        .map((pair) => MapEntry(pair[0].trim(), pair[1].trim()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.3;
    final detailEntries = parseDetails(car.details);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("AUTORA", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: Color(0xff000000)),),
        centerTitle: true,
        backgroundColor: Color(0xf6f6f6f6),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            Hero(
              tag: car.imagePath,
              child: Image.asset(car.imagePath, width: double.infinity, height: 250, fit: BoxFit.cover),
            ),

            SizedBox(height: 20),

            Center(
              child: Hero(
                tag: car.name,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    car.name,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(4),
              },

              border: TableBorder.all(color: Color(0xcccccccc)),
              children: detailEntries.map((entry) {
                return TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Text(
                        entry.key,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF000000)),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Text(
                        entry.value,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Color(0xFF000000)),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            
          ],
        ),
      ),
    );
  }
}
