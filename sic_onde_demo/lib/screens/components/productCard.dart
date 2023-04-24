part of lib.screens;

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.onTap, required this.product})
      : super(key: key);
  final Product product;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Color(0xFF8cccfc),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                  height: 100,
                  child: Center(
                    child: Hero(
                        tag: product.title!,
                        child: Image.asset(
                          product.image!,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${product.title}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                        Text("${product.subtitle}",
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12)),
                      ],
                    ),
                  ),
                  // RichText(
                  //     text: TextSpan(style: GoogleFonts.nunito(), children: [
                  //   TextSpan(
                  //       text: product.title,
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w400)),
                  //   TextSpan(
                  //       text: "\n${product.subtitle}",
                  //       style: TextStyle(color: Colors.grey[300], fontSize: 12))
                  // ])),
                  Container(
                    height: 25,
                    width: 27,
                    decoration: BoxDecoration(
                        color: Color(0xFF47AFFA), shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardHeavy extends StatelessWidget {
  const CardHeavy(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onTap,
      this.width})
      : super(key: key);
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: width ?? constraints.maxWidth / 2.1,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    spreadRadius: -18,
                    color: Colors.black)
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(style: GoogleFonts.nunito(), children: [
                  TextSpan(
                      text: title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: subtitle,
                      style: TextStyle(color: Colors.grey, fontSize: 12))
                ])),
                Container(
                  height: 25,
                  width: 27,
                  decoration: BoxDecoration(
                      color: Color(0xFF73C2FB), shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CardPesticide extends StatelessWidget {
  const CardPesticide(
      {Key? key,
      required this.title,
      required this.onTap,
      this.width,
      this.cardColor,
      this.iconColor,
      this.textColor,
      this.circleColor})
      : super(key: key);
  final String title;
  final Color? cardColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? circleColor;
  final VoidCallback onTap;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: width ?? constraints.maxWidth / 2.1,
          decoration: BoxDecoration(
              color: cardColor ?? Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    spreadRadius: -18,
                    color: Colors.black)
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                      text: TextSpan(style: GoogleFonts.nunito(), children: [
                    TextSpan(
                        text: title,
                        style: TextStyle(
                            color: textColor ?? Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ])),
                ),
                Container(
                  height: 25,
                  width: 27,
                  decoration: BoxDecoration(
                      color: circleColor ?? Color(0xFF73C2FB),
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: iconColor ?? Colors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
