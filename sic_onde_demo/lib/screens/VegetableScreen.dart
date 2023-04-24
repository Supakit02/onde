part of lib.screens;

class VegetableScreen extends StatefulWidget {
  VegetableScreen({Key? key, required this.isMIP}) : super(key: key);

  final bool isMIP;

  @override
  _VegetableScreenState createState() => _VegetableScreenState();
}

class _VegetableScreenState extends State<VegetableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF73C2FB),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            widget.isMIP ? "Molecularly" : "Enzyme",
            style: GoogleFonts.nunito(color: Colors.white, fontSize: 30),
          )),
      backgroundColor: Color(0xFF73C2FB),
      body: SafeArea(
          bottom: false,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            )),
                        height: 30,
                        width: double.infinity,
                      ),
                      Positioned(
                        top: -35,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xFF41ACFA),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Choese Vegetables",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Icon(Icons.eco_rounded, color: Colors.white)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(35),
                      //   topRight: Radius.circular(35),
                      // )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: GridView.builder(
                        itemCount:
                            widget.isMIP ? products.length : productsEM.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                        itemBuilder: (context, index) => ProductCard(
                            onTap: () {
                              Get.to(
                                SelectMode(
                                  product: widget.isMIP
                                      ? products[index]
                                      : productsEM[index],
                                  isMIP: widget.isMIP,
                                ),
                                duration: Duration(milliseconds: 500),
                              );
                            },
                            product: widget.isMIP
                                ? products[index]
                                : productsEM[index]),
                      ),
                    ),
                  ),
                )),
              ],
            ),
          )),
    );
  }
}
