import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/cache/cache_constant.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/init/language/locale_keys.g.dart';
import '../viewmodels/announcements_view_model.dart';
import '../viewmodels/login_view_model.dart';
import 'base_view.dart';
import '../../product/cache/announcements.dart';
import '../../product/widgets/text/locale_text.dart';
import '../../core/extensions/string_extension.dart';
import 'package:provider/src/provider.dart';

//Duyurular Sayfası
class AnnouncementsView extends StatelessWidget {
  const AnnouncementsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AnnouncementsViewModel>(
      onModelReady: (model) async {},
      model: AnnouncementsViewModel(),
      builder: (context, model, child) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    final isGuest = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: _buildAppbar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingMedium,
          child: Column(
            children: [
              ValueListenableBuilder<Box<Announcements>>(
                valueListenable: Hive.box<Announcements>(CacheConstants.ANNOUNCEMENT_BOX).listenable(),
                builder: (context, box, widget) {
                  return box.values.isNotEmpty
                      ? ListView(
                          shrinkWrap: true,
                          reverse: true,
                          children: <Widget>[
                            for (Announcements announcements in box.values)
                              Padding(
                                padding: context.paddingLowVertical,
                                child: Card(
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                    width: 1,
                                    color: Colors.black,
                                  )),
                                  child: ListTile(
                                    title: Text(
                                      announcements.title,
                                      style: context.textTheme.headline4?.copyWith(color: Colors.blue),
                                    ),
                                    subtitle: Text(announcements.description),
                                    trailing: Visibility(
                                      visible: !isGuest.isGuest,
                                      child: IconButton(
                                        onPressed: () async {
                                          box.delete(announcements.id);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      : const Center(
                          child: Text("Duyuru Bulunmamaktadır"),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      title: LocaleText(
        text: LocaleKeys.announcements_announcements,
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
