import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungpos/models/product_model.dart';
import 'package:ungpos/models/sqlite_model.dart';
import 'package:ungpos/utility/my_constant.dart';
import 'package:ungpos/utility/sqlit_helper.dart';
import 'package:ungpos/widgets/show_progress.dart';
import 'package:ungpos/widgets/show_title.dart';

class OfficerService extends StatefulWidget {
  const OfficerService({Key? key}) : super(key: key);

  @override
  _OfficerServiceState createState() => _OfficerServiceState();
}

class _OfficerServiceState extends State<OfficerService> {
  bool load = true;
  List<ProductModel> productModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllProduct();
  }

  Future<Null> readAllProduct() async {
    String apiReadAllProduct =
        'https://www.androidthai.in.th/bigc/getAllFood.php';
    await Dio().get(apiReadAllProduct).then((value) {
      // print('Valuet ==>$value');
      for (var item in json.decode(value.data)) {
        ProductModel model = ProductModel.fromMap(item);
        // print('nameFood ==>> ${model.nameFood}');
        setState(() {
          load = false;
          productModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, MyConstant.routeShowCart),
            icon: Icon(Icons.shopping_cart),
          ),
        ],
        backgroundColor: MyConstant.primary,
        title: Text('Officer Service'),
      ),
      body: load ? ShowProgress() : shwoGridProduct(),
    );
  }

  Future<Null> confirmOrderDialog(ProductModel productModel) async {
    int amount = 1;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: ListTile(
            leading: Image.network('${MyConstant.domain}${productModel.image}'),
            title: ShowTitle(
                title: productModel.nameFood,
                textStyle: MyConstant().h2Style()),
            subtitle: ShowTitle(
                title: 'Price = ${productModel.price} THB',
                textStyle: MyConstant().h3Style()),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      amount++;
                      print('### amount ==>> $amount');
                    });
                  },
                  icon: Icon(Icons.add_circle)),
              ShowTitle(title: '$amount', textStyle: MyConstant().h1Style()),
              IconButton(
                  onPressed: () {
                    if (amount > 1) {
                      setState(() {
                        amount--;
                      });
                    }
                  },
                  icon: Icon(Icons.remove_circle)),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    processInsertOrder(productModel, amount);
                  },
                  child: Text('Order'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget shwoGridProduct() => GridView.builder(
        gridDelegate:
            SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 250),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            print('Click index ==> $index');
            confirmOrderDialog(productModels[index]);
          },
          child: Card(
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 130,
                  child: Image.network(
                      '${MyConstant.domain}${productModels[index].image}'),
                ),
                ShowTitle(
                    title: productModels[index].nameFood,
                    textStyle: MyConstant().h2Style()),
                ShowTitle(
                    title: productModels[index].price,
                    textStyle: MyConstant().h1Style()),
              ],
            ),
          ),
        ),
        itemCount: productModels.length,
      );

  Future<Null> processInsertOrder(ProductModel productModel, int amount) async {
    int priceInt = int.parse(productModel.price);
    int sumInt = priceInt * amount;
    SQLModel model = SQLModel(
        id: null,
        idproduct: productModel.id,
        name: productModel.nameFood,
        price: productModel.price,
        amount: amount.toString(),
        sum: sumInt.toString());

    await SQLiteHelper()
        .insertValueToSQLite(model)
        .then((value) => print('## insert SQLite Success'));
  }
}
