import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:kaban_frontend/feature/dashboard/bloc/dashboard_state.dart';
import 'package:kaban_frontend/feature/dashboard/ui/widget/icon_button_widget.dart';
import 'package:kaban_frontend/feature/dashboard/ui/widget/sidebar_button.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colorScheme.surface,
          body: Row(
            children: [
              SizedBox(
                width: state.panelWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSize.p16,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSize.p12,
                            ),
                            child: Column(
                              children: [
                                SidebarButton(
                                  onPressed:
                                      () =>
                                          context.dashboardCubit.togglePanel(),
                                  assetPath: AppAssets.sideBar,
                                  isExpanded: state.isExpanded,
                                  color: context.colorScheme.onSurface,
                                ),
                                const SizedBox(height: AppSize.p12),
                                Container(
                                  width:
                                      state.isExpanded
                                          ? state.panelWidth
                                          : AppSize.p32,
                                  height: 1,
                                  color: context.colorScheme.onSurface
                                      .withOpacity(0.2),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 0),
                          IconButtonWidget(
                            assetPath: AppAssets.columns,
                            onPressed: () => navigationShell.goBranch(0),
                            color: context.colorScheme.onSurface,
                            text: Text('My Tasks'),
                            showText: state.isExpanded,
                            expandedAlignment: MainAxisAlignment.start,
                            collapsedAlignment: MainAxisAlignment.center,
                          ),

                          SizedBox(height: AppSize.p12),

                          IconButtonWidget(
                            assetPath: AppAssets.briefcase,
                            onPressed: () => navigationShell.goBranch(1),
                            color: context.colorScheme.onSurface,
                            text: Text('My Boards'),
                            showText: state.isExpanded,
                            expandedAlignment: MainAxisAlignment.start,
                            collapsedAlignment: MainAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSize.p16),
                      child: Column(
                        children: [
                          Container(
                            width:
                                state.isExpanded
                                    ? state.panelWidth
                                    : AppSize.p32,
                            height: 1,
                            color: context.colorScheme.onSurface.withOpacity(
                              0.2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSize.p8,
                            ),
                            child: IconButtonWidget(
                              assetPath: AppAssets.settings,
                              onPressed: () => navigationShell.goBranch(2),
                              color: context.colorScheme.onSurface,
                              text: Text('Settings'),
                              showText: state.isExpanded,
                              expandedAlignment: MainAxisAlignment.start,
                              collapsedAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: context.colorScheme.onSurface.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
              ),

              Expanded(child: navigationShell),
            ],
          ),
        );
      },
    );
  }
}
