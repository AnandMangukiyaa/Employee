
import 'package:employee/main.dart';
import 'package:flutter/material.dart';
import 'package:employee/core/constants/constants.dart';
import 'package:employee/presentation/widgets/primary_text_field.dart';

class PrimaryDropDownField extends StatefulWidget {
  final IconData? icon;
  final String labelText;
  final Color? labelColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final String? hintText;
  final String? preFilled;
  final bool? isRequired;
  final String valueKey;
  final EdgeInsetsGeometry? margin;
  final Widget? suffix;
  final Widget? prefix;
  final List<dynamic> items;
  final ValueChanged<dynamic> onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final GlobalKey<FormFieldState>? dropDownKey;
  final double? width;
  final bool? isSearchable;
  final bool? readOnly;
  final double? radius;
  final double? textSize;
  final double? labelSize;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;

  const PrimaryDropDownField(
      {Key? key,
      this.icon,
      required this.labelText,
      this.hintText,
      this.labelColor,
      this.suffix,
      this.prefix,
      required this.onChanged,
      this.onTap,
      this.validator,
        this.textColor,
      required this.valueKey,
      required this.items,
      this.margin,
      this.dropDownKey,
      this.width,
      this.isRequired,
      this.preFilled,
      this.isSearchable,
      this.radius,
      this.textSize,
      this.labelSize,
      this.backgroundColor,
      this.readOnly,
      this.padding,
      this.borderColor,
      this.focusNode})
      : super(key: key);

  @override
  State<PrimaryDropDownField> createState() => _PrimaryDropDownFieldState();
}

class _PrimaryDropDownFieldState extends State<PrimaryDropDownField> {
  final TextEditingController _controller = TextEditingController();
  // final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final GlobalKey _widgetKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  ScrollController scrollController = ScrollController();
  List data = [];
  Function(void Function())? set;

  @override
  void initState() {
    if (widget.preFilled != null && widget.preFilled!.isNotEmpty) {
      _controller.text = widget.preFilled!;
    }

    widget.focusNode?.addListener(() {
      print("focus : ${widget.readOnly}");
      if ( widget.readOnly == null ? true : !widget.readOnly!) {
        if(widget.focusNode!.hasFocus) {
          _overlayEntry = _createOverlayEntry();
          if (_overlayEntry != null) {
            Overlay.of(context).insert(_overlayEntry!);
          }
        }else{
          if (_overlayEntry != null) {
            _overlayEntry!.remove();
          }
        }
      } else {
        if (_overlayEntry != null) {
          _overlayEntry!.remove();
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {

    if (widget.preFilled != null) {
      _controller.text = widget.preFilled!;
    }
  }

  final GlobalKey key = GlobalKey();

  OverlayEntry _createOverlayEntry() {
    Size fieldSize = (context.findRenderObject() as RenderBox).size;
    double positionW =
        (_widgetKey.currentContext!.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero)
            .dy;
    double screenH = MediaQuery.of(context).size.height;
    double boxSize = 0;
    return OverlayEntry(
      builder: (context) {
        return StatefulBuilder(
          builder: (context, se) {
            set = se;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (key.currentContext != null) {
                final RenderBox renderBox =
                    key.currentContext!.findRenderObject() as RenderBox;
                if (boxSize != renderBox.size.height) {
                  boxSize = renderBox.size.height;
                  if (set != null) {
                    set!(() {});
                  }
                }
              }
            });
            bool tob = screenH - (positionW + fieldSize.height) > boxSize;
            return Positioned(
              width: fieldSize.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, tob ? fieldSize.height - 30 : -boxSize),
                child: Material(
                  key: key,
                  color: Colors.transparent,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: (screenH / 2) - fieldSize.height - 30,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          bottom: tob
                              ? const Radius.circular(20)
                              : const Radius.circular(0),
                          top: !tob
                              ? const Radius.circular(20)
                              : const Radius.circular(0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset:
                              tob ? const Offset(3, 3) : const Offset(-3, -3),
                        ),
                      ],
                    ),
                    child: ScrollbarTheme(
                      data: ScrollbarThemeData(
                          thumbColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                          thickness: MaterialStateProperty.all<double>(2),
                          radius: const Radius.circular(8),
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
                          mainAxisMargin: 20),
                      child: Scrollbar(
                        controller: scrollController,
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          reverse: !tob,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            print("i : ${data[index]}");
                            return childrenWidget(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    data = widget.items;
    print("data : $data");
    return PrimaryTextField(
      link: _layerLink,
      controller: _controller,
      isRequired: widget.isRequired,
      fieldKey: _widgetKey,
      readOnly: widget.readOnly ??
          (widget.isSearchable == null ? true : widget.isSearchable! ? false:true),
      labelText: widget.labelText,
      labelColor: widget.labelColor,
      labelSize: widget.labelSize,
      validator: widget.validator,
      hintText: widget.hintText,
      padding: widget.padding,
      textSize: widget.textSize,
      radius: widget.radius,
      textColor: Colors.black,
      borderColor: widget.borderColor,
      backgroundColor: widget.backgroundColor,
      onChanged: !(widget.readOnly ?? false) &&
              !(widget.isSearchable == null ? true : !widget.isSearchable!)
          ? (value) {
              if (value.isEmpty) {
                data = widget.items;
                widget.onChanged(null);
              }
              if (value.isNotEmpty) {
                data = [];
                for (var i in widget.items) {
                  String j = (i is String) ? i : (i as Map)[widget.valueKey];
                  if (j.toString().replaceAll(" ", "").toLowerCase().contains(
                      value.replaceAll(" ", "").toLowerCase().toString())) {
                    data.add(i);
                  }
                }
              }
              if (set != null) {
                set!(() {});
              }
            }
          : null,
      suffix: widget.suffix ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(! widget.focusNode!.hasFocus
                  ? Icons.arrow_drop_down
                  : Icons.arrow_drop_up,color: AppColors.primary,),
              SizedBox(
                width: Sizes.s10.w,
              )
            ],
          ),
      icon: widget.icon,
      focusNode: widget.focusNode,
      onTap: () {
        if ( widget.focusNode!.hasFocus) {
           widget.focusNode?.unfocus();
        }
      },
    );
  }

  Widget childrenWidget(int index) {
    String? i = (data[index] is String)
        ? data[index]
        : (data[index] as Map)[widget.valueKey].toString();

    return ListTile(
      title: Text('${i}',style: TextStyle(color: Colors.black),),
      onTap: () {
         widget.focusNode?.unfocus();
        _controller.text = i ?? "Null";
        widget.onChanged(data[index]);
      },
    );
  }
}
