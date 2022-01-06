import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/cache/cache_constant.dart';
import '../viewmodels/facilities_view_model.dart';
import '../viewmodels/login_view_model.dart';
import 'base_view.dart';
import '../../product/cache/facilities.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/init/language/locale_keys.g.dart';
import '../../product/widgets/text/locale_text.dart';
import '../../core/extensions/string_extension.dart';
import 'package:provider/src/provider.dart';

//Tesisler Sayfası
class FacilitiesView extends StatelessWidget {
  const FacilitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<FacilitiesViewModel>(
      onModelReady: (model) async {},
      model: FacilitiesViewModel(),
      builder: (context, model, child) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    final isGuest = Provider.of<LoginViewModel>(context);
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildFacilitiesListView(context, isGuest),
    );
  }

  Padding _buildFacilitiesListView(BuildContext context, LoginViewModel isGuest) {
    return Padding(
      padding: context.paddingLow,
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Visibility(visible: !isGuest.isGuest, child: _buildFavoritedTitle(context))),
          Visibility(
            visible: !isGuest.isGuest,
            child: Expanded(
              flex: 2,
              child: ValueListenableBuilder<Box<Facilities>>(
                  valueListenable: Hive.box<Facilities>(CacheConstants.FAVORITED_BOX).listenable(),
                  builder: (context, box, widget) {
                    return box.values.isNotEmpty
                        ? GridView.count(crossAxisCount: 3, children: [
                            for (Facilities facilities in box.values)
                              Card(
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                )),
                                child: Stack(
                                  children: [
                                    const Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.black,
                                        )),
                                    Center(
                                        child: Text(
                                      facilities.title,
                                      textAlign: TextAlign.center,
                                    )),
                                  ],
                                ),
                              )
                          ])
                        : const Center(
                            child: Text("Favori Tesis Bulunmamaktadır."),
                          );
                  }),
            ),
          ),
          ValueListenableBuilder<Box<Facilities>>(
            valueListenable: Hive.box<Facilities>(CacheConstants.FACILITIES_BOX).listenable(),
            builder: (context, box, child) {
              return Align(
                  alignment: Alignment.centerLeft,
                  child: LocaleText(
                    text: LocaleKeys.facilities_all_facilities,
                    style: context.textTheme.headline4?.copyWith(color: Colors.blue),
                  ));
            },
          ),
          Expanded(
            flex: 3,
            child: ValueListenableBuilder<Box<Facilities>>(
              valueListenable: Hive.box<Facilities>(CacheConstants.FACILITIES_BOX).listenable(),
              builder: (context, box, widget) {
                return box.values.isNotEmpty
                    ? ListView(
                        children: <Widget>[
                          for (Facilities facilities in box.values)
                            Card(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                width: 1,
                                color: Colors.black,
                              )),
                              child: ListTile(
                                title: Text(facilities.title),
                                trailing: Visibility(
                                  visible: !isGuest.isGuest,
                                  child: IconButton(
                                    onPressed: () {
                                      var boxFavorited = Hive.box<Facilities>(CacheConstants.FAVORITED_BOX);
                                      if (facilities.isFavorited == true) {
                                        boxFavorited.delete(facilities.id);
                                      } else {
                                        boxFavorited.put(
                                          facilities.id,
                                          Facilities(
                                            id: facilities.id,
                                            title: facilities.title,
                                            isFavorited: facilities.isFavorited,
                                          ),
                                        );
                                      }
                                      facilities.isFavorited = !facilities.isFavorited;
                                      box.put(facilities.id, facilities);
                                    },
                                    icon: facilities.isFavorited != false
                                        ? Icon(Icons.favorite)
                                        : Icon(Icons.favorite_border_outlined),
                                  ),
                                ),
                              ),
                            )
                        ],
                      )
                    : Container(
                        margin: context.paddingHighVertical,
                        child: const Align(alignment: Alignment.center, child: Text('Tesisler Bulunmamaktadır.')),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  LocaleText _buildFavoritedTitle(BuildContext context) => LocaleText(
        text: LocaleKeys.facilities_favorited_facilities,
        style: context.textTheme.headline4?.copyWith(color: Colors.blue),
      );

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      title: LocaleText(
        text: LocaleKeys.facilities_facilities,
        style: context.textTheme.headline1?.copyWith(color: Colors.white),
      ),
      actions: [
        Center(
          child: Padding(
            padding: context.paddingLowHorizontal,
            child: Text(
              context.read<LoginViewModel>().userName?.capitalize() ?? '',
              style: context.textTheme.headline5?.copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
