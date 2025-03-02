part of './../../index.dart';

class AppTabView extends StatefulWidget {
  final List<String> tabs;
  final bool isFullWidthTab;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final List<Widget> children;
  final List<int?>? count;
  final Color? backgroundColor;

  const AppTabView(
      {super.key,
      this.isFullWidthTab = false,
      this.backgroundColor,
      this.padding,
      this.contentPadding,
      this.count,
      required this.tabs,
      required this.children});

  @override
  State<AppTabView> createState() => _AppTabViewState();
}

class _AppTabViewState extends State<AppTabView> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: widget.tabs.length,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            tabTab(),
            SizedBox(height: AppSizes.primaryGapHeight),
            Expanded(
                child: Padding(
                    padding: widget.contentPadding ?? EdgeInsets.zero,
                    child: TabBarView(children: widget.children)))
          ]));

  Widget tabTab() => TabBar(
      padding: widget.padding ?? EdgeInsets.zero,
      dividerHeight: 0,
      isScrollable: !widget.isFullWidthTab,
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: EdgeInsets.zero,
      tabAlignment:
          widget.isFullWidthTab ? TabAlignment.fill : TabAlignment.start,
      onTap: (index) => setState(() => activeIndex = index),
      indicatorColor: AppColors.primary,
      tabs: List.generate(
          widget.tabs.length,
          (index) => _tab(
              text: widget.tabs[index],
              count: widget.count != null ? widget.count![index] : null,
              tabIndex: index)).toList());

  Widget _tab({required int tabIndex, int? count, required String text}) {
    bool isActive = activeIndex == tabIndex;

    return Tab(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium),
              SizedBox(height: AppSizes.primaryGapHeight),
              if (count != null && count > 0)
                Badge.count(
                    backgroundColor: AppColors.offWhite,
                    textColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    smallSize: 20,
                    largeSize: 20,
                    count: count)
            ])));
  }
}
