class DashboardState {
  final bool isExpanded;
  final double panelWidth;

  DashboardState({required this.isExpanded, required this.panelWidth});

  DashboardState copyWith({bool? isExpanded, double? panelWidth}) {
    return DashboardState(
      isExpanded: isExpanded ?? this.isExpanded,
      panelWidth: panelWidth ?? this.panelWidth,
    );
  }
}
