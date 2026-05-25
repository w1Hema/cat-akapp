import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/globals.dart';
import 'about_screen.dart';
import 'developer_screen.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String _selectedLanguage = "العربية";
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        final isDark = currentMode == ThemeMode.dark;
        final primaryColor = Theme.of(context).primaryColor;

        return Scaffold(
          backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── Header ───
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [primaryColor, const Color(0xFF7C3AED)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(FontAwesomeIcons.gear, color: Colors.white, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          "الإعدادات",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ).animate().fadeIn().slideX(),
                    const SizedBox(height: 8),
                    Text(
                      "تخصيص التطبيق حسب تفضيلاتك",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ).animate().fadeIn(delay: 200.ms),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ─── Appearance Section ───
                _buildSectionTitle("🎨 المظهر والعرض", isDark, 300),
                const SizedBox(height: 12),

                // Dark/Light Mode Toggle
                _buildSettingsCard(
                  isDark: isDark,
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [const Color(0xFF1A0A2E), const Color(0xFF7C3AED)]
                                : [const Color(0xFFFFF0E5), const Color(0xFFFF6600)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الوضع الداكن",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              isDark ? "مفعل - لراحة العينين" : "معطل - الوضع الفاتح",
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white54 : Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.scale(
                        scale: 1.1,
                        child: Switch.adaptive(
                          value: isDark,
                          onChanged: (val) {
                            themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                          },
                          activeColor: const Color(0xFF7C3AED),
                          activeTrackColor: const Color(0xFF7C3AED).withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                  delay: 400,
                ),
                const SizedBox(height: 12),

                // Language Selection
                _buildSettingsCard(
                  isDark: isDark,
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(FontAwesomeIcons.language, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "اللغة",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              "اختر لغة التطبيق",
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white54 : Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00C6FF).withOpacity(isDark ? 0.15 : 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF00C6FF).withOpacity(0.3)),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedLanguage,
                          underline: const SizedBox(),
                          isDense: true,
                          dropdownColor: isDark ? const Color(0xFF0F1128) : Colors.white,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          items: const [
                            DropdownMenuItem(value: "العربية", child: Text("🇪🇬 العربية")),
                            DropdownMenuItem(value: "English", child: Text("🇺🇸 English")),
                            DropdownMenuItem(value: "Français", child: Text("🇫🇷 Français")),
                          ],
                          onChanged: (val) {
                            setState(() => _selectedLanguage = val!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("تم اختيار اللغة: $val"),
                                backgroundColor: const Color(0xFF00C6FF),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  delay: 500,
                ),

                const SizedBox(height: 25),

                // ─── Notifications Section ───
                _buildSectionTitle("🔔 الإشعارات", isDark, 550),
                const SizedBox(height: 12),
                _buildSettingsCard(
                  isDark: isDark,
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6600), Color(0xFFFFB347)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(FontAwesomeIcons.bell, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الإشعارات",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              _notificationsEnabled ? "مفعلة" : "معطلة",
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white54 : Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch.adaptive(
                        value: _notificationsEnabled,
                        onChanged: (val) => setState(() => _notificationsEnabled = val),
                        activeColor: const Color(0xFFFF6600),
                        activeTrackColor: const Color(0xFFFF6600).withOpacity(0.3),
                      ),
                    ],
                  ),
                  delay: 600,
                ),

                const SizedBox(height: 25),

                // ─── Navigation Section ───
                _buildSectionTitle("📋 المزيد", isDark, 650),
                const SizedBox(height: 12),

                // About Page
                _buildNavigationCard(
                  isDark: isDark,
                  icon: FontAwesomeIcons.circleInfo,
                  label: "عن التطبيق",
                  subtitle: "معلومات ونبذة احترافية",
                  gradient: [const Color(0xFF7C3AED), const Color(0xFFC084FC)],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutScreen()),
                  ),
                  delay: 700,
                ),
                const SizedBox(height: 10),

                // Developer Page
                _buildNavigationCard(
                  isDark: isDark,
                  icon: FontAwesomeIcons.code,
                  label: "صفحة المطور",
                  subtitle: "معلومات المطور والتقنيات",
                  gradient: [const Color(0xFF00C6FF), const Color(0xFF0072FF)],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DeveloperScreen()),
                  ),
                  delay: 750,
                ),
                const SizedBox(height: 10),

                // Rate App
                _buildNavigationCard(
                  isDark: isDark,
                  icon: FontAwesomeIcons.star,
                  label: "تقييم التطبيق",
                  subtitle: "ساعدنا بتقييمك على المتجر",
                  gradient: [const Color(0xFFFFD700), const Color(0xFFFF8C00)],
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("شكراً لك! ⭐ سيتم فتح المتجر قريباً"),
                        backgroundColor: const Color(0xFFFFD700),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                  delay: 800,
                ),
                const SizedBox(height: 10),

                // Share App
                _buildNavigationCard(
                  isDark: isDark,
                  icon: FontAwesomeIcons.shareNodes,
                  label: "مشاركة التطبيق",
                  subtitle: "شارك التطبيق مع أصدقائك",
                  gradient: [const Color(0xFF25D366), const Color(0xFF4CAF50)],
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("جاري فتح نافذة المشاركة... 🔗"),
                        backgroundColor: const Color(0xFF25D366),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                  delay: 850,
                ),
                const SizedBox(height: 10),

                // Privacy Policy
                _buildNavigationCard(
                  isDark: isDark,
                  icon: FontAwesomeIcons.shieldHalved,
                  label: "سياسة الخصوصية",
                  subtitle: "حماية بياناتك أولوية",
                  gradient: [const Color(0xFFFF0000), const Color(0xFFFF6B6B)],
                  onTap: () {},
                  delay: 900,
                ),

                const SizedBox(height: 30),

                // App Version
                Center(
                  child: Column(
                    children: [
                      Text(
                        "ENG / IBRAHIM FATHY",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor.withOpacity(0.7),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "الإصدار 1.0.0",
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white38 : Colors.black26,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "© 2026 جميع الحقوق محفوظة",
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.white24 : Colors.black12,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 1000.ms),

                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
      },
    );
  }

  Widget _buildSectionTitle(String title, bool isDark, int delay) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black87,
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.1);
  }

  Widget _buildSettingsCard({required bool isDark, required Widget child, required int delay}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.03) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: (isDark ? Colors.white : Colors.black).withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1);
  }

  Widget _buildNavigationCard({
    required bool isDark,
    required IconData icon,
    required String label,
    required String subtitle,
    required List<Color> gradient,
    required VoidCallback onTap,
    required int delay,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.03) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: gradient[0].withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                color: gradient[0].withOpacity(isDark ? 0.08 : 0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: gradient[0].withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                FontAwesomeIcons.chevronLeft,
                size: 14,
                color: isDark ? Colors.white38 : Colors.black26,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1);
  }
}
