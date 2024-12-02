import 'package:flutter/material.dart';
import 'package:project/services/d.dart';
import 'package:project/util/util.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context, listen: false).lease;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CostumText(data: "Detail"),
        ),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.length,
              itemBuilder: (context, index) {
                var item = order[index];
                return Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0.1, 0.1),
                                            blurRadius: 1)
                                      ],
                                    ),
                                    child: Image.network(
                                      item['product']['picURL'],
                                      height: 80,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 3.0, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width -
                                          180,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['product']['name'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins-regular',
                                                color: Color.fromARGB(
                                                    255, 117, 117, 117)),
                                          ),
                                          Text(
                                            formatCurrency(item['product']
                                                    ['price']
                                                .toString()),
                                            style: TextStyle(
                                                fontFamily: 'Poppins-rgular'),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color.fromARGB(
                                                        255, 247, 246, 246)),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0,
                                                      right: 8.0,
                                                      top: 4),
                                                  child: Text(
                                                    item['size'] == 'Large'
                                                        ? 'L'
                                                        : 'R',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Poppins-regular',
                                                        color: Color.fromARGB(
                                                            255,
                                                            151,
                                                            151,
                                                            151)),
                                                  ),
                                                ),
                                              ),
                                              item['ice'] == 'Normal'
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: SizedBox(
                                                        width: 1,
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    247,
                                                                    246,
                                                                    246)),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8.0,
                                                                  right: 8.0,
                                                                  top: 4),
                                                          child: Text(
                                                            '${item['ice']} ice',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins-regular',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        151,
                                                                        151,
                                                                        151)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              item['sugar'] == 'Normal'
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: SizedBox(
                                                        width: 1,
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    247,
                                                                    246,
                                                                    246)),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8.0,
                                                                  right: 8.0,
                                                                  top: 4),
                                                          child: Text(
                                                            '${item['sugar']} sugar',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins-regular',
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        151,
                                                                        151,
                                                                        151)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          StarRatingWidget(
                                              onRatingSelected: (rate, enable) {
                                            final productmap =
                                                ProductModel.fromMap(
                                                    item['product'],
                                                    item['product']['id']);
                                            product.updateProductRating(
                                                productmap, rate);
                                          })
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ));
  }
}
