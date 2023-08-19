import 'package:flutter/foundation.dart';import 'package:flutter/material.dart';import 'package:intl/intl.dart';import 'package:restaurant_app/constants.dart';//import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';// import 'package:oktoast/oktoast.dart';import 'package:esc_pos_utils/esc_pos_utils.dart';import 'pos_screen.dart';import 'package:esc_pos_printer/esc_pos_printer.dart' ;import 'package:restaurant_app/components/database_con.dart';//import 'package:network_pos_printer/network_pos_printer.dart';double grandTotal = 0;List<String> kotList = [];// PrinterBluetoothManager printerManager = PrinterBluetoothManager();// network.PrinterNetworkManager printerNetworkManager =// network.PrinterNetworkManager();// List<PrinterBluetooth> _devices = [];selectedMode _printerSelected = selectedMode.Bluetooth;//PrinterBluetooth selectedPrinter;TextEditingController ipAddressController1=TextEditingController();class PrinterSettings extends StatefulWidget {  @override  _PrinterSettingsState createState() => _PrinterSettingsState();}enum selectedMode { Bluetooth, Network, USB }bool showSettings=true;bool addPrinter=false;bool showKot=true;class _PrinterSettingsState extends State<PrinterSettings> {  List<bool> mainSelect;  List<bool> kotSelect;  int mainMode=0;  int kotMode=0;  @override  void initState() {    // TODO: implement initState    mainSelect = [true, false];    kotSelect = [true, false];    // printerManager.scanResults.listen((devices) async {    //   // print('UI: Devices found ${devices.length}');    //   setState(() {    //     _devices = devices;    //   });    // });    super.initState();  }  // void _startScanDevices() {  //   setState(() {  //     _devices = [];  //   });  //   printerManager.startScan(Duration(seconds: 4));  //   print(_devices);  // }  //  // void _stopScanDevices() {  //   printerManager.stopScan();  // }  @override  Widget build(BuildContext context) {    double boxWidth=MediaQuery.of(context).size.width/2;    return SafeArea(      child: Scaffold(          appBar: AppBar(            backgroundColor: kGreenColor,          ),          body:SingleChildScrollView(            scrollDirection: Axis.vertical,            child: Container(              child: Column(                children: [                  Center(                    child: ToggleButtons(                      isSelected: mainSelect,                      borderColor: kItemContainer,                      fillColor: kGreenColor,                      borderWidth: 2,                      selectedBorderColor: kItemContainer,                      selectedColor: kItemContainer,                      borderRadius: BorderRadius.circular(0),                      children: <Widget>[                        Padding(                          padding: const EdgeInsets.all(8.0),                          child: Text(                            'DEFAULT PRINTER SETTINGS',                            style: TextStyle( fontSize: MediaQuery.of(context).textScaleFactor*20,),                          ),                        ),                        Padding(                          padding: const EdgeInsets.all(8.0),                          child: Text(                            'KOT PRINTER SETTINGS',                            style: TextStyle( fontSize: MediaQuery.of(context).textScaleFactor*20,),                          ),                        ),                      ],                      onPressed: (int index) {                        mainMode=index+1;                        print(mainMode);                        setState(() {                          for (int i = 0; i < mainSelect.length; i++) {                            mainSelect[i] = i == index;                          }                          index==1?showSettings=false:showSettings=true;                        });                      },                    ),                  ),                  Visibility(                    visible: showSettings,                    child: Column(                      children: [                        Container(                          child: Column(                            children: [                              RadioListTile(                                  activeColor: kGreenColor,                                  title: Text('Bluetooth'),                                  value: selectedMode.Bluetooth,                                  groupValue: _printerSelected,                                  onChanged: (value){                                    setState(() {                                      _printerSelected=value;                                    });                                  }                              ),                              RadioListTile(                                  activeColor: kGreenColor,                                  title: Text('Network'),                                  value: selectedMode.Network,                                  groupValue: _printerSelected,                                  onChanged: (value){                                    setState(() {                                      _printerSelected=value;                                    });                                  }                              ),                              RadioListTile(                                  activeColor: kGreenColor,                                  title: Text('USB'),                                  value: selectedMode.USB,                                  groupValue: _printerSelected,                                  onChanged: (value){                                    setState(() {                                      _printerSelected=value;                                    });                                  }                              ),                            ],                          ),                        ),                        getWidget(_printerSelected),                      ],                    ),                    replacement:Column(                      children: [                        ToggleButtons(                          isSelected: kotSelect,                          borderColor: kItemContainer,                          fillColor: kGreenColor,                          borderWidth: 2,                          selectedBorderColor: kItemContainer,                          selectedColor: kItemContainer,                          borderRadius: BorderRadius.circular(0),                          children: <Widget>[                            Padding(                              padding: const EdgeInsets.all(8.0),                              child: Text(                                'Printer',                                style: TextStyle( fontSize: MediaQuery.of(context).textScaleFactor*20,),                              ),                            ),                            Padding(                              padding: const EdgeInsets.all(8.0),                              child: Text(                                'Category',                                style: TextStyle( fontSize: MediaQuery.of(context).textScaleFactor*20,),                              ),                            ),                          ],                          onPressed: (int index) {                            kotMode=index+1;                            print(kotMode);                            setState(() {                              for (int i = 0; i < kotSelect.length; i++) {                                kotSelect[i] = i == index;                              }                              index==1?showKot=false:showKot=true;                            });                          },                        ),                        Visibility(child: Visibility(                          child: MaterialButton(                            child: Text('Add Printer'),                            color: kLightBlueColor,                            padding: EdgeInsets.all(8.0),                            onPressed: (){                              setState(() {                                addPrinter=true;                              });                            },                          ),                        ))                      ],                    ) ,                  ),                ],),            ),          )      ),    );  }  Widget getWidget(selectedMode selectedType){    if(selectedType==selectedMode.USB){      return Container(          child: Column(            children: [              Text('USB selected'),            ],          ));    }    else if(selectedType==selectedMode.Bluetooth){      return Container(child:      Column(        children: [          Text('Bluetooth selected'),          MaterialButton(            onPressed: (){              //_startScanDevices();            },            color: kLightBlueColor,            child: Padding(              padding: EdgeInsets.all(8.0),              child: Text('SCAN'),            ),          ),          // Container(          //   child: ListView.builder(          //       shrinkWrap: true,          //       itemCount: _devices.length,          //       itemBuilder: (BuildContext context, int index) {          //         return InkWell(          //           onTap: () {          //             selectedPrinter=_devices[index];          //             print(selectedPrinter);          //           },          //           child: Column(          //             children: <Widget>[          //               Container(          //                 height: 60,          //                 padding: EdgeInsets.only(left: 10),          //                 alignment: Alignment.centerLeft,          //                 child: Row(          //                   children: <Widget>[          //                     Icon(Icons.print),          //                     SizedBox(width: 10),          //                     Expanded(          //                       child: Column(          //                         crossAxisAlignment: CrossAxisAlignment.start,          //                         mainAxisAlignment: MainAxisAlignment.center,          //                         children: <Widget>[          //                           Text(_devices[index].name ?? ''),          //                           Text(_devices[index].address),          //                         ],          //                       ),          //                     )          //                   ],          //                 ),          //               ),          //               Divider(),          //             ],          //           ),          //         );          //       }),          // ),        ],      )      );    }    else if(selectedType==selectedMode.Network){      return Container(child: Column(        mainAxisAlignment: MainAxisAlignment.spaceAround,        children: [          Text('Enter IP Address'),          SizedBox(            width: MediaQuery.of(context).size.width/4,            child: TextField(              controller: ipAddressController1,              onChanged: (value){                ipAddress1=value;              },            ),          ),          MaterialButton(onPressed: (){            showDialog(context: context, builder: (context)=>Dialog(              child: Container(                  child: Text('saved')),            ));          })        ],      ));    }  }}void kotPrint(int orderNo, int tableNo) async {  // printerManager.selectPrinter(selectedPrinter);  //  // // TODO Don't forget to choose printer's paper  // const PaperSize paper = PaperSize.mm58;  //  // // DEMO RECEIPT  // final PosPrintResult res =  // await printerManager.printTicket(await kot(paper, orderNo, tableNo));  // kotList = [];  // showToast(res.msg);}void checkoutPrint(List cart, int orderNo) async {  // printerManager.selectPrinter(selectedPrinter);  //  // // TODO Don't forget to choose printer's paper  // const PaperSize paper = PaperSize.mm58;  //  // // DEMO RECEIPT  // final PosPrintResult res =  // await printerManager.printTicket(await checkOut(paper, cart, orderNo));  // showToast(res.msg);}// Future<Ticket> kot(PaperSize paper, int orderNo, int tableNo) async {//   final Ticket ticket = Ticket(paper);////   ticket.text('Order No:$salesPrefix$orderNo',//       styles: PosStyles(align: PosAlign.center));//   ticket.text('Table:$tableNo', styles: PosStyles(align: PosAlign.center));//   ticket.row([//     PosColumn(text: 'Item  ', width: 4),//     PosColumn(//       text: 'Qty  ',//       width: 4,//     ),//     PosColumn(//       text: 'Description',//       width: 4,//     ),//   ]);//   print('kotlist $kotList');//   for (int i = 0; i < kotList.length; i++) {//     List kotItemsString = kotList[i].split(':');//     ticket.row([//       PosColumn(text: kotItemsString[0], width: 4),//       PosColumn(//         text: kotItemsString[1],//         width: 4,//       ),//       PosColumn(//         text: kotItemsString[2],//         width: 4,//       ),//     ]);//   }//   ticket.feed(2);////   final now = DateTime.now();//   final formatter = DateFormat('MM/dd/yyyy H:m');//   final String timestamp = formatter.format(now);//   ticket.text(timestamp,//       styles: PosStyles(align: PosAlign.center), linesAfter: 2);////   ticket.feed(2);//   ticket.cut();//   return ticket;// }// Future<Ticket> checkOut(PaperSize paper, List cart, int orderNo) async {//   final Ticket ticket = Ticket(paper);////   ticket.text('POSIMATE',//       styles: PosStyles(//         align: PosAlign.center,//         height: PosTextSize.size2,//         width: PosTextSize.size2,//       ),//       linesAfter: 1);////   ticket.text('NEAR METRO STATION', styles: PosStyles(align: PosAlign.center));//   ticket.text('Kochi,India', styles: PosStyles(align: PosAlign.center));//   ticket.text('Ph :8877112233', styles: PosStyles(align: PosAlign.center));//   ticket.text('GSTIN :7788899ABCD1ZF',//       styles: PosStyles(align: PosAlign.center));//   ticket.text('Tax Invoice',//       styles: PosStyles(//         align: PosAlign.center,//         bold: true,//       ),//       linesAfter: 2);//   final now = DateTime.now();//   final formatter = DateFormat('MM/dd/yyyy H:m');//   final String timestamp = formatter.format(now);//   ticket.text('Invoice No: $salesPrefix$orderNo',//       styles: PosStyles(align: PosAlign.left, bold: true));//   ticket.text(timestamp,//       styles: PosStyles(align: PosAlign.left, bold: true), linesAfter: 1);//   ticket.hr();//   ticket.row([//     PosColumn(text: 'Item ', width: 3),//     PosColumn(text: 'Price', width: 3),//     PosColumn(//       text: 'Qty',//       width: 3,//     ),//     PosColumn(//       text: 'Total',//       width: 3,//     ),//   ]);//   ticket.hr();//   grandTotal = 0;//   for (int i = 0; i < cart.length; i++) {//     print('cart $cart');//     List cartItemsString = cart[i].split(':');//     double tempTotal =//         double.parse(cartItemsString[2]) * double.parse(cartItemsString[3]);//     grandTotal += tempTotal;//     ticket.row([//       PosColumn(text: '${cartItemsString[0]}', width: 3),//       PosColumn(text: '${cartItemsString[2]}', width: 3),//       PosColumn(//         text: '${cartItemsString[3]}',//         width: 3,//       ),//       PosColumn(//         text: '${tempTotal.toString()}',//         width: 3,//       ),//     ]);//   }//   ticket.hr();//   ticket.text('GRAND TOTAL               $grandTotal',//       styles: PosStyles(//           align: PosAlign.left,//           height: PosTextSize.size1,//           width: PosTextSize.size1),//       linesAfter: 2);//   ticket.row([//     PosColumn(text: 'CGST 2.5%', width: 4),//     PosColumn(text: 'SGST 2.5%', width: 4),//     PosColumn(text: 'GST 5%', width: 4),//   ]);//   ticket.row([//     PosColumn(//         text: '${((2.5 * grandTotal) / 100).toStringAsPrecision(3)}', width: 4),//     PosColumn(//         text: '${((2.5 * grandTotal) / 100).toStringAsPrecision(3)}', width: 4),//     PosColumn(//         text: '${((5 * grandTotal) / 100).toStringAsPrecision(3)}', width: 4)//   ]);//   ticket.cut();//   return ticket;// }