import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gyan_jyoti/shared/widgets/bottom_nav_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import 'dashboard_page.dart';
import '../../profile/pages/profile_page.dart';

class MainTabPage extends ConsumerStatefulWidget {
  const MainTabPage({super.key});

  @override
  ConsumerState<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends ConsumerState<MainTabPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Scaffold(
      extendBody: false,
      // Matches background so no yellow flashes during slide
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Stack(
            children: [
              _buildTab(0, DashboardPage(
                onProfileTap: () => setState(() => _currentIndex = 1),
              )),
              _buildTab(1, const ProfilePage()),
            ],
          ),
          if (!isMobile)
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: SizedBox(
                  height: 44,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Text(
                          AppStrings.appName,
                          style: AppTextStyles.headlineLarge.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _WebNavChip(
                              label: AppStrings.navHome,
                              isActive: _currentIndex == 0,
                              onTap: () => setState(() => _currentIndex = 0),
                            ),
                            const SizedBox(width: 8),
                            _WebNavChip(
                              label: AppStrings.navProfile,
                              isActive: _currentIndex == 1,
                              onTap: () => setState(() => _currentIndex = 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: SafeArea(
                top: false,
                child: AppBottomNavBar(
                  currentIndex: _currentIndex,
                  onTap: (index) => setState(() => _currentIndex = index),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildTab(int index, Widget child) {
    final isActive = _currentIndex == index;
    // Determine direction of the slide based on the tab order
    final offset = isActive 
        ? Offset.zero 
        : (index < _currentIndex ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0));

    return IgnorePointer(
      ignoring: !isActive,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 700), // Slow motion effect
        curve: Curves.fastOutSlowIn,
        offset: offset,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 700),
          opacity: isActive ? 1.0 : 0.0,
          child: child,
        ),
      ),
    );
  }
}

/// Web/desktop: pill-style nav link in app bar
class _WebNavChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _WebNavChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white.withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.textPrimary.withValues(
                alpha: isActive ? 1.0 : 0.85,
              ),
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

