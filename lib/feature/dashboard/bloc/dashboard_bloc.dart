import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/feature/dashboard/bloc/dashboard_state.dart';

extension DaboardExtension on BuildContext {
  DashboardCubit get dashboardCubit => read<DashboardCubit>();
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState(isExpanded: false, panelWidth: 72));

  static const double collapsedWidth = 72;
  static const double expandedWidth = 200;

  void togglePanel() {
    emit(
      state.copyWith(
        isExpanded: !state.isExpanded,
        panelWidth: state.isExpanded ? collapsedWidth : expandedWidth,
      ),
    );
  }

  static BlocProvider<DashboardCubit> provider() {
    return BlocProvider(create: (context) => DashboardCubit());
  }
}
