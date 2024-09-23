import 'dart:convert';

import 'package:ai_farmer_app/Constants/app_colors.dart';
import 'package:ai_farmer_app/utility/customtextformfield.dart';
import 'package:ai_farmer_app/utility/drop_down_search.dart'; // Import DropDownItem
import 'package:ai_farmer_app/utility/sizedbox_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
import 'package:http/http.dart' as http;

class CropYieldPredictionPage extends StatefulWidget {
  const CropYieldPredictionPage({super.key});

  @override
  State<CropYieldPredictionPage> createState() =>
      _CropYieldPredictionPageState();
}

class _CropYieldPredictionPageState extends State<CropYieldPredictionPage> {
  final TextEditingController seasons = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController crop = TextEditingController();
  final TextEditingController landarea = TextEditingController();
  final List<String> items = [
    'NICOBARS',
    'NORTH AND MIDDLE ANDAMAN',
    'SOUTH ANDAMANS',
    'ANANTAPUR',
    'CHITTOOR',
    'EAST GODAVARI',
    'GUNTUR',
    'KADAPA',
    'KRISHNA',
    'KURNOOL',
    'PRAKASAM',
    'SPSR NELLORE',
    'SRIKAKULAM',
    'VISAKHAPATANAM',
    'VIZIANAGARAM',
    'WEST GODAVARI',
    'ANJAW',
    'CHANGLANG',
    'DIBANG VALLEY',
    'EAST KAMENG',
    'EAST SIANG',
    'KURUNG KUMEY',
    'LOHIT',
    'LONGDING',
    'LOWER DIBANG VALLEY',
    'LOWER SUBANSIRI',
    'NAMSAI',
    'PAPUM PARE',
    'TAWANG',
    'TIRAP',
    'UPPER SIANG',
    'UPPER SUBANSIRI',
    'WEST KAMENG',
    'WEST SIANG',
    'BAKSA',
    'BARPETA',
    'BONGAIGAON',
    'CACHAR',
    'CHIRANG',
    'DARRANG',
    'DHEMAJI',
    'DHUBRI',
    'DIBRUGARH',
    'DIMA HASAO',
    'GOALPARA',
    'GOLAGHAT',
    'HAILAKANDI',
    'JORHAT',
    'KAMRUP',
    'KAMRUP METRO',
    'KARBI ANGLONG',
    'KARIMGANJ',
    'KOKRAJHAR',
    'LAKHIMPUR',
    'MARIGAON',
    'NAGAON',
    'NALBARI',
    'SIVASAGAR',
    'SONITPUR',
    'TINSUKIA',
    'UDALGURI',
    'ARARIA',
    'ARWAL',
    'AURANGABAD',
    'BANKA',
    'BEGUSARAI',
    'BHAGALPUR',
    'BHOJPUR',
    'BUXAR',
    'DARBHANGA',
    'GAYA',
    'GOPALGANJ',
    'JAMUI',
    'JEHANABAD',
    'KAIMUR (BHABUA)',
    'KATIHAR',
    'KHAGARIA',
    'KISHANGANJ',
    'LAKHISARAI',
    'MADHEPURA',
    'MADHUBANI',
    'MUNGER',
    'MUZAFFARPUR',
    'NALANDA',
    'NAWADA',
    'PASHCHIM CHAMPARAN',
    'PATNA',
    'PURBI CHAMPARAN',
    'PURNIA',
    'ROHTAS',
    'SAHARSA',
    'SAMASTIPUR',
    'SARAN',
    'SHEIKHPURA',
    'SHEOHAR',
    'SITAMARHI',
    'SIWAN',
    'SUPAUL',
    'VAISHALI',
    'CHANDIGARH',
    'BALOD',
    'BALODA BAZAR',
    'BALRAMPUR',
    'BASTAR',
    'BEMETARA',
    'BIJAPUR',
    'BILASPUR',
    'DANTEWADA',
    'DHAMTARI',
    'DURG',
    'GARIYABAND',
    'JANJGIR-CHAMPA',
    'JASHPUR',
    'KABIRDHAM',
    'KANKER',
    'KONDAGAON',
    'KORBA',
    'KOREA',
    'MAHASAMUND',
    'MUNGELI',
    'NARAYANPUR',
    'RAIGARH',
    'RAIPUR',
    'RAJNANDGAON',
    'SUKMA',
    'SURAJPUR',
    'SURGUJA',
    'DADRA AND NAGAR HAVELI',
    'NORTH GOA',
    'SOUTH GOA',
    'AHMADABAD',
    'AMRELI',
    'ANAND',
    'BANAS KANTHA',
    'BHARUCH',
    'BHAVNAGAR',
    'DANG',
    'DOHAD',
    'GANDHINAGAR',
    'JAMNAGAR',
    'JUNAGADH',
    'KACHCHH',
    'KHEDA',
    'MAHESANA',
    'NARMADA',
    'NAVSARI',
    'PANCH MAHALS',
    'PATAN',
    'PORBANDAR',
    'RAJKOT',
    'SABAR KANTHA',
    'SURAT',
    'SURENDRANAGAR',
    'TAPI',
    'VADODARA',
    'VALSAD',
    'AMBALA',
    'BHIWANI',
    'FARIDABAD',
    'FATEHABAD',
    'GURGAON',
    'HISAR',
    'JHAJJAR',
    'JIND',
    'KAITHAL',
    'KARNAL',
    'KURUKSHETRA',
    'MAHENDRAGARH',
    'MEWAT',
    'PALWAL',
    'PANCHKULA',
    'PANIPAT',
    'REWARI',
    'ROHTAK',
    'SIRSA',
    'SONIPAT',
    'YAMUNANAGAR',
    'CHAMBA',
    'HAMIRPUR',
    'KANGRA',
    'KINNAUR',
    'KULLU',
    'LAHUL AND SPITI',
    'MANDI',
    'SHIMLA',
    'SIRMAUR',
    'SOLAN',
    'UNA',
    'ANANTNAG',
    'BADGAM',
    'BANDIPORA',
    'BARAMULLA',
    'DODA',
    'GANDERBAL',
    'JAMMU',
    'KARGIL',
    'KATHUA',
    'KISHTWAR',
    'KULGAM',
    'KUPWARA',
    'LEH LADAKH',
    'POONCH',
    'PULWAMA',
    'RAJAURI',
    'RAMBAN',
    'REASI',
    'SAMBA',
    'SHOPIAN',
    'SRINAGAR',
    'UDHAMPUR',
    'BOKARO',
    'CHATRA',
    'DEOGHAR',
    'DHANBAD',
    'DUMKA',
    'EAST SINGHBUM',
    'GARHWA',
    'GIRIDIH',
    'GODDA',
    'GUMLA',
    'HAZARIBAGH',
    'JAMTARA',
    'KHUNTI',
    'KODERMA',
    'LATEHAR',
    'LOHARDAGA',
    'PAKUR',
    'PALAMU',
    'RAMGARH',
    'RANCHI',
    'SAHEBGANJ',
    'SARAIKELA KHARSAWAN',
    'SIMDEGA',
    'WEST SINGHBHUM',
    'BAGALKOT',
    'BANGALORE RURAL',
    'BELGAUM',
    'BELLARY',
    'BENGALURU URBAN',
    'BIDAR',
    'CHAMARAJANAGAR',
    'CHIKBALLAPUR',
    'CHIKMAGALUR',
    'CHITRADURGA',
    'DAKSHIN KANNAD',
    'DAVANGERE',
    'DHARWAD',
    'GADAG',
    'GULBARGA',
    'HASSAN',
    'HAVERI',
    'KODAGU',
    'KOLAR',
    'KOPPAL',
    'MANDYA',
    'MYSORE',
    'RAICHUR',
    'RAMANAGARA',
    'SHIMOGA',
    'TUMKUR',
    'UDUPI',
    'UTTAR KANNAD',
    'YADGIR',
    'ALAPPUZHA',
    'ERNAKULAM',
    'IDUKKI',
    'KANNUR',
    'KASARAGOD',
    'KOLLAM',
    'KOTTAYAM'
  ];
  final List<String> season = [
    'Kharif',
    // 'Whole Year',
    'Autumn',
    'Rabi',
    'Summer',
    'Winter'
  ];

  final List<String> crops = [
    'Arecanut',
    'Other Kharif pulses',
    'Rice',
    'Banana',
    'Cashewnut',
    'Coconut ',
    'Dry ginger',
    'Sugarcane',
    'Sweet potato',
    'Tapioca',
    'Black pepper',
    'Dry chillies',
    'other oilseeds',
    'Turmeric',
    'Maize',
    'Moong(Green Gram)',
    'Urad',
    'Arhar/Tur',
    'Groundnut',
    'Sunflower',
    'Bajra',
    'Castor seed',
    'Cotton(lint)',
    'Horse-gram',
    'Jowar',
    'Korra',
    'Ragi',
    'Tobacco',
    'Gram',
    'Wheat',
    'Masoor',
    'Sesamum',
    'Linseed',
    'Safflower',
    'Onion',
    'other misc. pulses',
    'Samai',
    'Small millets',
    'Coriander',
    'Potato',
    'Other  Rabi pulses',
    'Soyabean',
    'Beans & Mutter(Vegetable)',
    'Bhindi',
    'Brinjal',
    'Citrus Fruit',
    'Cucumber',
    'Grapes',
    'Mango',
    'Orange',
    'other fibres',
    'Other Fresh Fruits',
    'Other Vegetables',
    'Papaya',
    'Pome Fruit',
    'Tomato',
    'Rapeseed &Mustard',
    'Mesta',
    'Cowpea(Lobia)',
    'Lemon',
    'Pome Granet',
    'Sapota',
    'Cabbage',
    'Peas  (vegetable)',
    'Niger seed',
    'Bottle Gourd',
    'Sannhamp',
    'Varagu',
    'Garlic',
    'Ginger',
    'Oilseeds total',
    'Pulses total',
    'Pineapple',
    'Barley',
    'Khesari',
    'Guar seed',
    'Moth',
    'Other Cereals & Millets',
    'Cond-spcs other',
    'Turnip',
    'Carrot',
    'Redish',
    'Arcanut (Processed)',
    'Atcanut (Raw)',
    'Cashewnut Processed',
    'Cashewnut Raw',
    'Cardamom',
    'Rubber',
    'Bitter Gourd',
    'Drum Stick',
    'Jack Fruit',
    'Snak Guard',
    'Pump Kin',
    'Tea',
    'Coffee',
    'Cauliflower',
    'Other Citrus Fruit',
    'Water Melon',
    'Total foodgrain',
    'Kapas',
    'Colocosia',
    'Lentil',
    'Bean',
    'Jobster',
    'Perilla',
    'Rajmash Kholar',
    'Ricebean (nagadal)',
    'Ash Gourd',
    'Beet Root',
    'Lab-Lab',
    'Ribed Guard',
    'Yam',
    'Apple',
    'Peach',
    'Pear',
    'Plums',
    'Litchi',
    'Ber',
    'Other Dry Fruit',
    'Jute & mesta'
  ];
  void showlogoutdialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 185, 246, 213),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Container(
            height: 185.0, // Set your desired height here
            width: 300.0, // Set your desired width here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    district.clear();
                    seasons.clear();
                    crop.clear();
                    landarea.clear();
                  },
                  icon: const Icon(Icons.close),
                ),
                Center(
                  child: Text(
                    'The estimated crop yield for these conditions is $res tons/year',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "popR",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     TextButton(
                //       onPressed: () {
                //         Navigator.of(context).pop();
                //       },
                //       child: Text(
                //         'Cancel',
                //         style: TextStyle(
                //           fontSize: 20,
                //           fontFamily: "popR",
                //           color: AppColors.black,
                //         ),
                //       ),
                //     ),
                //     TextButton(
                //       onPressed: () {
                //         // SharedPreferencesHelper.setIsLoggedIn(status: false);
                //         // SharedPreferencesHelper.setToken(apiKey: "");
                //         // Navigator.push(
                //         //     context,
                //         //     MaterialPageRoute(
                //         //         builder: (context) => const LoginPage()));
                //         // Navigator.of(context).pop();
                //       },
                //       child: Text(
                //         'Logout',
                //         style: TextStyle(
                //           color: AppColors.red,
                //           fontSize: 20,
                //           fontFamily: "popR",
                //         ),
                //       ),.
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  var res;
  void cropyield() async {
    print("into the crop func");

    // Convert landarea.text to a double (if it can be a decimal)
    int area;
    try {
      area = int.parse(landarea.text);
    } catch (e) {
      debugPrint("Error parsing area: $e");
      return; // Exit the function if parsing fails
    }

    Map<String, dynamic> bodydata = {
      "Area": area, // Ensure Area is a double
      "District": district.text,
      "Crop": crop.text,
      "Season": seasons.text,
    };

    print(bodydata);

    try {
      var response = await http.post(
        Uri.parse("https://nfc-api-l2z3.onrender.com/crop_yield"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(bodydata),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        debugPrint("success");
        print(responseData);
        setState(() {
          // Handle the successful response here
          // Assuming res is a double or a number
          double predictedYield = responseData["Predicted Crop Yield"];
          res = predictedYield.toStringAsFixed(2);
          showlogoutdialog(context);
          print(res);
        });
      } else {
        debugPrint(
            "Failed to get crop prediction. Status code: ${response.statusCode}");
        debugPrint("Response body: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error making request: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Crop Yield Prediction',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.greenn,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              vSize(10),
              Text(
                "Select Appropriate Fields",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              vSize(10),
              Row(
                children: [
                  hSize(20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Select District :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              vSize(10),
              Center(
                child: SizedBox(
                  width: w * 0.8,
                  child: FlutterDropdownSearch(
                    textFieldBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greenn),
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Select Districts",
                    textController: district,
                    items: items,
                    dropdownHeight: 300,
                  ),
                ),
              ),
              vSize(20),
              Row(
                children: [
                  hSize(20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Select Season :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              vSize(10),
              Center(
                child: SizedBox(
                  width: w * 0.8,
                  child: FlutterDropdownSearch(
                    textFieldBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greenn),
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Select Season",
                    textController: seasons,
                    items: season,
                    dropdownHeight: 250,
                  ),
                ),
              ),
              vSize(20),
              Row(
                children: [
                  hSize(20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Select Crop :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              vSize(10),
              Center(
                child: SizedBox(
                  width: w * 0.8,
                  child: FlutterDropdownSearch(
                    textFieldBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greenn),
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Select Crop",
                    textController: crop,
                    items: crops,
                    dropdownHeight: 250,
                  ),
                ),
              ),
              vSize(20),
              Row(
                children: [
                  hSize(20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Enter Your Land Area(in acre) :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.078,
                width: 0.85 * w,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: landarea,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Enter Your Land Area",
                      // labelText: "Email",
                      // errortext: "Pls enter your registegreen email-id",
                    ),
                  ),
                ),
              ),
              // vSize(10),
              // Center(
              //   child: SizedBox(
              //     width: w * 0.8,
              //     child: FlutterDropdownSearch(
              //       textFieldBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: AppColors.greenn),
              //           borderRadius: BorderRadius.circular(10)),
              //       contentPadding: EdgeInsets.all(10),
              //       hintText: "Select Season",
              //       textController: seasons,
              //       items: season,
              //       dropdownHeight: 250,
              //     ),
              //   ),
              // ),
              vSize(20),
              SizedBox(
                height: h * 0.06,
                width: w * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    cropyield();

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Login_Page()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: AppColors.green,
                    foregroundColor: AppColors.white,
                    shadowColor: Colors.grey.withOpacity(0.5),
                  ),
                  child: const Text(
                    "Predict Crop Yield",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "popR",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
