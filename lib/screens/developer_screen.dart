import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({super.key});

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> with SingleTickerProviderStateMixin {
  late AnimationController _matrixController;

  @override
  void initState() {
    super.initState();
    _matrixController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _matrixController.dispose();
    super.dispose();
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── App Bar ───
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: isDark ? const Color(0xFF040508) : Colors.white,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF0D0F1A), const Color(0xFF00C6FF).withOpacity(0.15), const Color(0xFF040508)]
                        : [const Color(0xFFE3F2FD), const Color(0xFFF3F4F6)],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00C6FF).withOpacity(0.4),
                              blurRadius: 25,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(FontAwesomeIcons.terminal, color: Colors.white, size: 36),
                      ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                      const SizedBox(height: 16),
                      const Text(
                        "Developer Console",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Developer Info Card ───
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF00C6FF).withOpacity(0.08), const Color(0xFF0072FF).withOpacity(0.03)]
                            : [const Color(0xFFE3F2FD), Colors.white],
                      ),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFF00C6FF).withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00C6FF).withOpacity(0.3),
                                    blurRadius: 15,
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/profile.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ENG / IBRAHIM FATHY",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: isDark ? Colors.white : Colors.black87,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00C6FF).withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      "Full-Stack Developer & AI Specialist",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF00C6FF),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "منذ سنوات وأنا أغوص في أعماق الأكواد وتأمين السيرفرات. لا أصمم المواقع لتكون مجرد واجهة، بل أبنيها كحصون منيعة مزودة بعقول ذكية قادرة على أتمتة الأعمال ورفع الكفاءة إلى أقصى حد ممكن.",
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.7,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.15),

                  const SizedBox(height: 25),

                  // ─── App Technical Details ───
                  Text(
                    "⚙️ تفاصيل التطبيق التقنية",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 15),

                  _buildTechRow(isDark, "المنصة", "Flutter (Dart)", FontAwesomeIcons.flutter, const Color(0xFF02569B), 400),
                  _buildTechRow(isDark, "الإصدار", "1.0.0+1", FontAwesomeIcons.codeBranch, const Color(0xFF25D366), 450),
                  _buildTechRow(isDark, "SDK", "Flutter 3.11+", FontAwesomeIcons.cubes, const Color(0xFF00C6FF), 500),
                  _buildTechRow(isDark, "حالة البناء", "مستقر ✅", FontAwesomeIcons.circleCheck, const Color(0xFF4CAF50), 550),
                  _buildTechRow(isDark, "المظهر", "Material Design 3", FontAwesomeIcons.palette, const Color(0xFF7C3AED), 600),
                  _buildTechRow(isDark, "الخطوط", "Cairo (Arabic)", FontAwesomeIcons.font, const Color(0xFFFF6600), 650),
                  _buildTechRow(isDark, "الأنيميشن", "flutter_animate", FontAwesomeIcons.wandMagicSparkles, const Color(0xFFFF6B6B), 700),
                  _buildTechRow(isDark, "الأيقونات", "FontAwesome Flutter", FontAwesomeIcons.icons, const Color(0xFF0088CC), 750),

                  const SizedBox(height: 25),

                  // ─── Packages Used ───
                  Text(
                    "📦 الحزم المستخدمة",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ).animate().fadeIn(delay: 800.ms),
                  const SizedBox(height: 15),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildPackageChip("flutter_animate", const Color(0xFFFF6600), isDark, 850),
                      _buildPackageChip("font_awesome_flutter", const Color(0xFF00C6FF), isDark, 870),
                      _buildPackageChip("google_fonts", const Color(0xFF7C3AED), isDark, 890),
                      _buildPackageChip("url_launcher", const Color(0xFF25D366), isDark, 910),
                      _buildPackageChip("shared_preferences", const Color(0xFF0072FF), isDark, 930),
                      _buildPackageChip("animated_text_kit", const Color(0xFFFF6B6B), isDark, 950),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ─── Quick Contact ───
                  Text(
                    "📱 تواصل مع المطور",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ).animate().fadeIn(delay: 1000.ms),
                  const SizedBox(height: 15),

                  // WhatsApp Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchUrl("https://wa.me/201202060839"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 8,
                        shadowColor: const Color(0xFF25D366).withOpacity(0.4),
                      ),
                      icon: const Icon(FontAwesomeIcons.whatsapp),
                      label: const Text("تواصل عبر واتساب", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ).animate().fadeIn(delay: 1050.ms).slideY(begin: 0.2),
                  const SizedBox(height: 10),

                  // Email Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton.icon(
                      onPressed: () => _launchUrl("mailto:ibrahimfathyibrahim39@gmail.com"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: BorderSide(color: primaryColor.withOpacity(0.5), width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      icon: const Icon(FontAwesomeIcons.envelope),
                      label: const Text("إرسال بريد إلكتروني", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ).animate().fadeIn(delay: 1100.ms).slideY(begin: 0.2),

                  const SizedBox(height: 30),

                  // ─── Debug Info ───
                  AnimatedBuilder(
                    animation: _matrixController,
                    builder: (_, __) => Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black : const Color(0xFF1A1A2E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF00C6FF).withOpacity(0.1 + _matrixController.value * 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.greenAccent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.greenAccent.withOpacity(0.5),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "SYSTEM TERMINAL",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _terminalLine("> app.name: Cyber CV Portfolio"),
                          _terminalLine("> app.version: 1.0.0"),
                          _terminalLine("> developer: Ibrahim Fathy Ibrahim"),
                          _terminalLine("> platform: Flutter/Dart"),
                          _terminalLine("> status: PRODUCTION ✅"),
                          _terminalLine("> build_date: 2026-05-25"),
                          _terminalLine("> security: ENCRYPTED 🔒"),
                          _terminalLine("> ai_module: ACTIVE 🤖"),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.2),

                  const SizedBox(height: 30),

                  Center(
                    child: Text(
                      "© 2026 Ibrahim Fathy - All Rights Reserved",
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white24 : Colors.black12,
                        letterSpacing: 1,
                      ),
                    ),
                  ).animate().fadeIn(delay: 1400.ms),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _terminalLine(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF00FF41),
          fontFamily: "monospace",
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildTechRow(bool isDark, String label, String value, IconData icon, Color color, int delay) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.06 : 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1);
  }

  Widget _buildPackageChip(String name, Color color, bool isDark, int delay) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FontAwesomeIcons.cube, size: 12, color: color),
          const SizedBox(width: 6),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).scale(begin: const Offset(0.8, 0.8));
  }
}
