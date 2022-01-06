import 'package:flutter/material.dart';
import '../viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

//T dynamic baseview oluşturuldu. parent sayfaların türemesi için.
class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext, T, Widget?) builder;
  final T? model;
  final Widget? child;
  final Function(T)? onModelReady;

  const BaseView({Key? key, this.model, required this.builder, this.child, this.onModelReady}) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model!;
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
      create: (BuildContext context) {
        return model;
      },
    );
  }
}
