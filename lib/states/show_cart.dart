import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungpos/models/sqlite_model.dart';
import 'package:ungpos/utility/my_constant.dart';
import 'package:ungpos/utility/sqlit_helper.dart';
import 'package:ungpos/widgets/show_title.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({Key? key}) : super(key: key);

  @override
  _ShowCartState createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<SQLModel> sqlModels = [];
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllCart();
  }

  Future<Null> readAllCart() async {
    if (sqlModels.length != 0) {
      sqlModels.clear();
      total = 0;
    }

    await SQLiteHelper().readSQLite().then((value) {
      print('## value = $value');
      if (value.length != 0) {
        setState(() {
          sqlModels = value;

          for (var item in sqlModels) {
            int sumInt = int.parse(item.sum);
            total = total + sumInt;
          }
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: Text('Show Cart'),
      ),
      body: sqlModels.length == 0
          ? Center(
              child: ShowTitle(
                  title: 'Empty Cart', textStyle: MyConstant().h1Style()))
          : SingleChildScrollView(
              child: Column(
                children: [
                  buildHead(),
                  showListOrder(),
                  buildTotal(),
                  buildOrder(),
                ],
              ),
            ),
    );
  }

  Row buildOrder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(right: 100),
          width: 250,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle(),
            onPressed: () => processOrder(),
            child: Text('Order'),
          ),
        ),
      ],
    );
  }

  Future<Null> processOrder() async {
    String idUser = '1';
    String dateTimeOrder = '1/7/21';
    String idProducts = createArrayIdProduct();
    String amounts = createArrayAmount();

    String apiInsertOrderToServer =
        'https://www.androidthai.in.th/bigc/insertUng.php?isAdd=true&idUser=$idUser&dateTimeOrder=$dateTimeOrder&idProducts=$idProducts&amounts=$amounts&total=$total';
    await Dio().get(apiInsertOrderToServer).then((value) async {
      await SQLiteHelper().emptySQLite().then((value) {
        readAllCart();
        print('Success Insert');
      });
    });
  }

  String createArrayIdProduct() {
    List<String> strings = [];
    for (var item in sqlModels) {
      strings.add(item.idproduct);
    }

    return strings.toString();
  }

  String createArrayAmount() {
    List<String> strings = [];
    for (var item in sqlModels) {
      strings.add(item.amount);
    }

    return strings.toString();
  }

  Row buildTotal() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowTitle(
                title: 'Total :',
                textStyle: MyConstant().h1Style(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: ShowTitle(
            title: total.toString(),
            textStyle: MyConstant().h1Style(),
          ),
        ),
      ],
    );
  }

  Container buildHead() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(color: MyConstant.light),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ShowTitle(
              title: 'Product',
              textStyle: MyConstant().h2Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: 'Price',
              textStyle: MyConstant().h2Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: 'Amount',
              textStyle: MyConstant().h2Style(),
            ),
          ),
          Expanded(
            flex: 2,
            child: ShowTitle(
              title: 'Sum',
              textStyle: MyConstant().h2Style(),
            ),
          ),
        ],
      ),
    );
  }

  ListView showListOrder() => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: sqlModels.length,
        itemBuilder: (context, index) => Row(
          children: [
            Expanded(
              flex: 3,
              child: ShowTitle(
                title: sqlModels[index].name,
                textStyle: MyConstant().h3Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: sqlModels[index].price,
                textStyle: MyConstant().h3Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: sqlModels[index].amount,
                textStyle: MyConstant().h3Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: sqlModels[index].sum,
                textStyle: MyConstant().h3Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () async {
                  await SQLiteHelper()
                      .deleteSQLiteById(sqlModels[index].id!)
                      .then((value) => readAllCart());
                },
                icon: Icon(Icons.delete_forever),
              ),
            ),
          ],
        ),
      );
}
