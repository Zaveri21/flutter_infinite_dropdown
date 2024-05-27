import 'package:flutter/material.dart';

class InfiniteDropdownController {
  InfiniteDropdownState? _dropdownState;

  void attach(InfiniteDropdownState dropdownState) {
    _dropdownState = dropdownState;
  }

  void stopLoading() {
    _dropdownState?.endBottomRefresh();
  }
}

class InfiniteDropdown<T> extends StatefulWidget {
  final InfiniteDropdownController? controller;
  final Widget sourceWidget;
  final Widget dropdownWidget;
  final List<T> data;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final double? spacing;
  final double? dropdownHeight;
  final Future<void> Function()? onBottomRefresh;
  final bool isSeparator;
  final Color? progressIndicatorColor;
  final Widget? customIndicator;

  InfiniteDropdown({
    required this.controller,
    required this.sourceWidget,
    required this.dropdownWidget,
    required this.data,
    required this.itemBuilder,
    this.spacing = 8.0,
    this.dropdownHeight = 120,
    this.onBottomRefresh,
    this.isSeparator = false,
    this.progressIndicatorColor,
    this.customIndicator,
  });

  @override
  State<InfiniteDropdown> createState() => InfiniteDropdownState<T>();
}

class InfiniteDropdownState<T> extends State<InfiniteDropdown<T>> {
  OverlayEntry? _overlayEntry;
  ScrollController scrollController = ScrollController();
  late ValueNotifier<bool> _loadingMoreNotifier;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
    _loadingMoreNotifier = ValueNotifier<bool>(false);
    widget.controller?.attach(this);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    _loadingMoreNotifier.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_loadingMoreNotifier.value && scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      // Load more items
      setState(() {
        _loadingMoreNotifier.value = true;
      });

      // Scroll to the bottom
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
        await widget.onBottomRefresh?.call();
      });
    }
  }

  void endBottomRefresh() {
    _loadingMoreNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_overlayEntry != null) {
          _overlayEntry?.remove();
          _overlayEntry = null;
        } else {
          final renderBox = context.findRenderObject() as RenderBox;
          final size = renderBox.size;

          final overlayPosition = renderBox.localToGlobal(Offset.zero);

          _overlayEntry = OverlayEntry(
            builder: (context) => Positioned(
              left: overlayPosition.dx,
              top: overlayPosition.dy + size.height + (widget.spacing ?? 0),
              width: size.width,
              child: Material(
                elevation: 4.0,
                child: SizedBox(
                  height: widget.dropdownHeight,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _loadingMoreNotifier,
                      builder: (context, isLoading, _) {
                        return ListView.separated(
                          physics: BouncingScrollPhysics(),
                          controller: scrollController,
                          itemCount: isLoading ? widget.data.length + 1 : widget.data.length,
                          itemBuilder: (context, index) {
                            if (index == widget.data.length && isLoading) {
                              return widget.customIndicator ??
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Center(
                                      child: CircularProgressIndicator(color: widget.progressIndicatorColor),
                                    ),
                                  );
                            } else {
                              return widget.itemBuilder(context, widget.data[index]);
                            }
                          },
                          separatorBuilder: (context, index) {
                            return widget.isSeparator ? Divider() : Container();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );

          Overlay.of(context)!.insert(_overlayEntry!);
        }
      },
      child: widget.sourceWidget,
    );
  }
}
