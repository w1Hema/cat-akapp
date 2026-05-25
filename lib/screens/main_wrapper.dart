import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/globals.dart';
import 'home_tab.dart';
import 'services_tab.dart';
import 'ai_center_tab.dart';
import 'settings_tab.dart';
import '../widgets/animated_background.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 3;

  final List<Widget> _pages = [
    const SettingsTab(),
    const AICenterTab(),
    const ServicesTab(),
    const HomeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        final isDark = currentMode == ThemeMode.dark;
        final primaryColor = Theme.of(context).primaryColor;

        return Scaffold(
          extendBody: true, // Allows body to scroll under the floating bar
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBackground(isDark: isDark),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _pages[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F111A).withOpacity(0.95) : Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.4 : 0.05),
                blurRadius: 15,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                index: 0,
                icon: FontAwesomeIcons.gear,
                activeIcon: FontAwesomeIcons.gears,
                label: "الإعدادات",
                color: const Color(0xFF25D366),
                isDark: isDark,
              ),
              _buildNavItem(
                index: 1,
                icon: FontAwesomeIcons.brain,
                activeIcon: FontAwesomeIcons.brain,
                label: "الذكاء",
                color: const Color(0xFF00C6FF),
                isDark: isDark,
                isSpecial: true,
              ),
              _buildNavItem(
                index: 2,
                icon: FontAwesomeIcons.briefcase,
                activeIcon: FontAwesomeIcons.briefcase,
                label: "الخدمات",
                color: const Color(0xFF7C3AED),
                isDark: isDark,
              ),
              _buildNavItem(
                index: 3,
                icon: FontAwesomeIcons.house,
                activeIcon: FontAwesomeIcons.houseUser,
                label: "الرئيسية",
                color: primaryColor,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
      },
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required Color color,
    required bool isDark,
    bool isSpecial = false,
  }) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? color.withOpacity(isDark ? 0.15 : 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isActive
              ? Border.all(color: color.withOpacity(0.3))
              : null,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSpecial && isActive
                  ? Container(
                      key: const ValueKey('special_active'),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, const Color(0xFF7C3AED)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(activeIcon, color: Colors.white, size: 18),
                    )
                  : Icon(
                      isActive ? activeIcon : icon,
                      key: ValueKey('icon_$index\_$isActive'),
                      color: isActive
                          ? color
                          : (isDark ? Colors.white38 : Colors.black38),
                      size: isActive ? 22 : 20,
                    ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: isActive ? 11 : 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive
                    ? color
                    : (isDark ? Colors.white38 : Colors.black38),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
