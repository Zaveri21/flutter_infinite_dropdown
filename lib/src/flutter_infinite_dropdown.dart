import 'package:flutter/material.dart';

class InfiniteDropdownController {
  InfiniteDropdownState? _dropdownState;

  void attach(InfiniteDropdownState dropdownState) {
    _dropdownState = dropdownState;
  }

  /// Stop the dropdown loading indicator after an API call.
  void stopLoading() {
    _dropdownState?.endBottomRefresh();
  }
}

class InfiniteDropdown<T> extends StatefulWidget {
  /// Controller to stop the loader after an API call completes.
  final InfiniteDropdownController? controller;

  /// The widget that triggers the dropdown when tapped.
  final Widget sourceWidget;

  /// Custom widget reserved for future dropdown header use.
  final Widget dropdownWidget;

  /// The list of items to display in the dropdown.
  final List<T> data;

  /// Builder for each dropdown list item.
  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  /// Spacing between the source widget and the dropdown overlay. Defaults to 8.0.
  final double? spacing;

  /// Height of the dropdown overlay. Defaults to 120.
  final double? dropdownHeight;

  /// Callback invoked when the user scrolls to the bottom of the list.
  final Future<void> Function()? onBottomRefresh;

  /// Whether to display a [Divider] between each list item. Defaults to false.
  final bool isSeparator;

  /// Color of the default [CircularProgressIndicator] shown while loading.
  final Color? progressIndicatorColor;

  /// Custom loading widget shown at the bottom while fetching more data.
  final Widget? customIndicator;

  const InfiniteDropdown({
    super.key,
    this.controller,
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
  State<InfiniteDropdown<T>> createState() => InfiniteDropdownState<T>();
}

class InfiniteDropdownState<T> extends State<InfiniteDropdown<T>> {
  OverlayEntry? _overlayEntry;
  final ScrollController scrollController = ScrollController();
  late ValueNotifier<bool> _loadingMoreNotifier;

  @override
  void initState() {
    super.initState();
    _loadingMoreNotifier = ValueNotifier<bool>(false);
    scrollController.addListener(_onScroll);
    widget.controller?.attach(this);
  }

  @override
  void dispose() {
    // Remove the overlay before disposing to prevent memory leaks.
    _overlayEntry?.remove();
    _overlayEntry = null;
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    _loadingMoreNotifier.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_loadingMoreNotifier.value &&
        scrollController.hasClients &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
      _loadingMoreNotifier.value = true;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
        await widget.onBottomRefresh?.call();
      });
    }
  }

  void endBottomRefresh() {
    _loadingMoreNotifier.value = false;
  }

  void _openDropdown() {
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
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    itemCount: isLoading
                        ? widget.data.length + 1
                        : widget.data.length,
                    itemBuilder: (context, index) {
                      if (index == widget.data.length && isLoading) {
                        return widget.customIndicator ??
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: widget.progressIndicatorColor,
                                ),
                              ),
                            );
                      }
                      return widget.itemBuilder(
                        context,
                        index,
                        widget.data[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return widget.isSeparator
                          ? const Divider()
                          : const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_overlayEntry != null) {
          _closeDropdown();
        } else {
          _openDropdown();
        }
      },
      child: widget.sourceWidget,
    );
  }
}
