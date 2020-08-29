import 'package:flutter/material.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/services/callback_types.dart';

import 'my_card.dart';

class CardGrid extends StatelessWidget{
  final List<dynamic> list;
  final VoidCallback addButtonCallback;
  final String emptyText;
  final TapCardCallback tapCardCallback;

  final List<String> gridTexts;
  final List<String> gridSubTexts;
  final List<String> gridPicturesUrls;

  const CardGrid({Key key, this.list, this.addButtonCallback, this.emptyText, this.tapCardCallback, this.gridTexts, this.gridSubTexts, this.gridPicturesUrls}) : super(key: key);

  List<String> getSubtexts(int index){
    List<String> res = List<String>();
    if (list[index] is CommunityModel){
      res.add(list[index].isAdmin ? 'admin' : 'member');
    }

    if(res.length > 0) return res;
    if (gridSubTexts != null) return [gridSubTexts[index],];
    return null;
  }

  List<String> getTexts(int index){
    List<String> res = List<String>();
    if (list[index] is CommunityModel || list[index] is FeatureModel){
      res.add(list[index].name);
    }

    if(res.length > 0) return res;
    if (gridTexts != null) return [gridTexts[index],];
    return null;
  }

  String getPictureUrl(int index){
    if (list[index] is CommunityModel || list[index] is FeatureModel){
      return list[index].picture;
    }

    if (gridPicturesUrls != null) {
      try {
        return gridPicturesUrls[index];
      } on RangeError {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          ...List.generate(
            addButtonCallback != null ? list.length + 1 : list.length,
                (int index) => index == list.length && addButtonCallback != null  ? Container(
              child: IconButton(
                icon: Icon(Icons.add_circle_outline),
                iconSize: 50,
                onPressed: addButtonCallback,
              ),
            ) : Container(
              child: GestureDetector(
                  onTap: tapCardCallback != null ? ()=>tapCardCallback(context, list[index]) : (){},
                  child: MyCard(
                    texts: getTexts(index),
                    subTexts: getSubtexts(index),
                    imageUrl: getPictureUrl(index),
                  )
              ),
            ),
          ),
        ]
      )
    );
  }
}