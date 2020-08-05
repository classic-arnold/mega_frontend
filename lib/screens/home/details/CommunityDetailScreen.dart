import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/bars/MyBottomNav.dart';
import 'package:mega/components/cards/CardGrid.dart';
import 'package:mega/components/inputs/SearchInput.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/models/CommunityModel.dart';
import 'package:mega/models/FeatureModel.dart';
import 'package:mega/screens/home/add/AddFeatureScreen.dart';
import 'package:mega/screens/home/details/FeatureDetailScreen.dart';
import 'package:mega/services/api/FeatureAPI.dart';

class CommunityDetailScreen extends StatefulWidget{
  final CommunityModel community;

  const CommunityDetailScreen({Key key, this.community}) : super(key: key);

  @override
  _CommunityDetailScreenState createState()=>_CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen>{
  Future<List<FeatureModel>> features;
  String searchVal;

  void onSearch(String val){
    setState(() {
      searchVal = val;
    });
  }

  void tapCardCallback(BuildContext context, dynamic item){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeatureDetailScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (searchVal == null) features = FeatureAPI.getFeatures(context, widget.community.id);
    return Scaffold(
      appBar: MyAppBars.myAppBar4(context),
      body: Padding(
        child: Column(
          children: <Widget>[
            BigText(this.widget.community.name),
            Align(
              child: Text(
                this.widget.community.isAdmin ? 'admin' : 'member',
                textAlign: TextAlign.left,
              ),
              alignment: Alignment.bottomLeft,
            ),
            Padding(
              child: SearchInput(
                onChangeCallback: onSearch,
              ),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            ),
            FutureBuilder<List<FeatureModel>>(
              future: features,
              builder: (BuildContext context, AsyncSnapshot<List<FeatureModel>> snapshot) {
                Widget _widget;
                if(snapshot.hasData){
                  _widget = CardGrid(
                    list: searchVal == null ?
                    snapshot.data : snapshot.data.where((element) => element.name.toLowerCase().contains(searchVal)).toList(),
                    addButtonCallback: this.widget.community.isAdmin ? (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFeatureScreen(
                            community: this.widget.community,
                          )
                        ),
                      );
                    } : null,
                    emptyText: 'No features',
                    tapCardCallback: tapCardCallback,
                  );
                } else if (snapshot.hasError){
                  _widget = Text('Error');
                } else {
                  _widget = CircularProgressIndicator();
                }
                return _widget;
              },
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      ),
    );
  }
}