import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with TickerProviderStateMixin {
  late AnimationController _orbitController;
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _glowController.dispose();
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
          // ─── Animated Hero App Bar ───
          SliverAppBar(
            expandedHeight: 380,
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
              background: Stack(
                children: [
                  // Gradient Background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isDark
                            ? [
                                const Color(0xFF1A0A2E),
                                const Color(0xFF0D0F1A),
                                const Color(0xFF040508),
                              ]
                            : [
                                const Color(0xFF7C3AED).withOpacity(0.2),
                                const Color(0xFFF8F0FF),
                                Colors.white,
                              ],
                      ),
                    ),
                  ),

                  // Orbiting particles
                  Center(
                    child: AnimatedBuilder(
                      animation: _orbitController,
                      builder: (_, __) {
                        return Stack(
                          alignment: Alignment.center,
                          children: List.generate(6, (i) {
                            final angle = (_orbitController.value * 2 * 3.14159) + (i * 3.14159 / 3);
                            final radius = 120.0 + (i % 2 == 0 ? 0 : 20);
                            return Transform.translate(
                              offset: Offset(
                                radius * _cos(angle),
                                radius * _sin(angle) * 0.5,
                              ),
                              child: Container(
                                width: 8 + (i % 3) * 4.0,
                                height: 8 + (i % 3) * 4.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: [
                                    primaryColor,
                                    const Color(0xFF7C3AED),
                                    const Color(0xFF00C6FF),
                                    Colors.greenAccent,
                                    const Color(0xFFFF6B6B),
                                    const Color(0xFFFFD700),
                                  ][i].withOpacity(0.7),
                                  boxShadow: [
                                    BoxShadow(
                                      color: [
                                        primaryColor,
                                        const Color(0xFF7C3AED),
                                        const Color(0xFF00C6FF),
                                        Colors.greenAccent,
                                        const Color(0xFFFF6B6B),
                                        const Color(0xFFFFD700),
                                      ][i].withOpacity(0.5),
                                      blurRadius: 15,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),

                  // Center avatar & title
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        // Animated avatar
                        AnimatedBuilder(
                          animation: _glowController,
                          builder: (_, __) => Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  primaryColor,
                                  const Color(0xFF7C3AED),
                                  const Color(0xFF00C6FF),
                                  primaryColor,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3 + _glowController.value * 0.3),
                                  blurRadius: 30 + _glowController.value * 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: isDark ? const Color(0xFF0A0C14) : Colors.white,
                              backgroundImage: const AssetImage('assets/images/profile.png'),
                            ),
                          ),
                        ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),

                        const SizedBox(height: 20),

                        Text(
                          "ENG / IBRAHIM FATHY",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [primaryColor, const Color(0xFF00C6FF)],
                              ).createShader(const Rect.fromLTWH(0, 0, 300, 30)),
                          ),
                        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),

                        const SizedBox(height: 8),

                        Text(
                          "الخبير التقني المتقدم",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ).animate().fadeIn(delay: 600.ms),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Vision Card ───
                  _buildAnimatedCard(
                    isDark: isDark,
                    icon: FontAwesomeIcons.eye,
                    title: "الرؤية",
                    content: "بناء حلول رقمية آمنة ومبتكرة تسبق عصرها، تدمج بين جمال التصميم وقوة الذكاء الاصطناعي وصلابة الأمن السيبراني.",
                    gradient: [primaryColor, const Color(0xFFFFB347)],
                    delay: 200,
                  ),
                  const SizedBox(height: 16),

                  // ─── Mission Card ───
                  _buildAnimatedCard(
                    isDark: isDark,
                    icon: FontAwesomeIcons.rocket,
                    title: "الرسالة",
                    content: "تحويل الأفكار إلى واقع تقني مذهل ومحصن. تقديم منتجات نهائية تتميز بالفخامة والانسيابية والاحترافية الفنية.",
                    gradient: [const Color(0xFF7C3AED), const Color(0xFFC084FC)],
                    delay: 350,
                  ),
                  const SizedBox(height: 16),

                  // ─── Philosophy Card ───
                  _buildAnimatedCard(
                    isDark: isDark,
                    icon: FontAwesomeIcons.lightbulb,
                    title: "الفلسفة",
                    content: "لست مجرد مبرمج، أنا مهندس للحلول الرقمية الآمنة. كل سطر كود أكتبه هو حصن منيع مزود بعقل ذكي.",
                    gradient: [const Color(0xFF00C6FF), const Color(0xFF0072FF)],
                    delay: 500,
                  ),

                  const SizedBox(height: 30),

                  // ─── Timeline / Journey ───
                  Text(
                    "🚀 رحلة النجاح",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ).animate().fadeIn(delay: 600.ms),
                  const SizedBox(height: 20),

                  _buildTimelineItem(
                    isDark: isDark,
                    year: "2022",
                    title: "البداية",
                    desc: "بدأ مشوار التعلم والغوص في أعماق الأكواد والبرمجة",
                    color: const Color(0xFF25D366),
                    delay: 700,
                  ),
                  _buildTimelineItem(
                    isDark: isDark,
                    year: "2023",
                    title: "التخصص",
                    desc: "التعمق في الأمن السيبراني والذكاء الاصطناعي",
                    color: const Color(0xFF00C6FF),
                    delay: 800,
                  ),
                  _buildTimelineItem(
                    isDark: isDark,
                    year: "2024",
                    title: "الاحتراف",
                    desc: "بناء مشاريع احترافية وتطوير أنظمة SaaS متكاملة",
                    color: const Color(0xFF7C3AED),
                    delay: 900,
                  ),
                  _buildTimelineItem(
                    isDark: isDark,
                    year: "2025",
                    title: "الإبداع",
                    desc: "دمج AI مع الأمن السيبراني وأتمتة الأعمال",
                    color: primaryColor,
                    delay: 1000,
                  ),
                  _buildTimelineItem(
                    isDark: isDark,
                    year: "2026",
                    title: "المستقبل",
                    desc: "توسع في تطبيقات الهاتف وأنظمة الأتمتة الذكية",
                    color: const Color(0xFFFFD700),
                    delay: 1100,
                    isLast: true,
                  ),

                  const SizedBox(height: 30),

                  // ─── Social Links Row ───
                  Text(
                    "🌐 تواصل معي",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ).animate().fadeIn(delay: 1100.ms),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialCircle(FontAwesomeIcons.whatsapp, const Color(0xFF25D366), "https://wa.me/201202060839", 1200),
                      _buildSocialCircle(FontAwesomeIcons.facebook, const Color(0xFF1877F2), "https://facebook.com/w1Hema", 1250),
                      _buildSocialCircle(FontAwesomeIcons.telegram, const Color(0xFF0088CC), "https://t.me/w1Hema", 1300),
                      _buildSocialCircle(FontAwesomeIcons.discord, const Color(0xFF5865F2), "https://discord.gg/w1Hema", 1350),
                      _buildSocialCircle(FontAwesomeIcons.envelope, const Color(0xFFFF6600), "mailto:ibrahimfathyibrahim39@gmail.com", 1400),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Footer
                  Center(
                    child: Text(
                      "صُنع بـ ❤️ بواسطة المهندس إبراهيم فتحي",
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white38 : Colors.black26,
                      ),
                    ),
                  ).animate().fadeIn(delay: 1500.ms),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _cos(double angle) => math.cos(angle);
  double _sin(double angle) => math.sin(angle);

  Widget _buildAnimatedCard({
    required bool isDark,
    required IconData icon,
    required String title,
    required String content,
    required List<Color> gradient,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradient[0].withOpacity(isDark ? 0.12 : 0.08),
            gradient[1].withOpacity(isDark ? 0.05 : 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: gradient[0].withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradient),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: gradient[0].withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: gradient[0],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.7,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
        .fade(duration: 600.ms, delay: delay.ms)
        .slideX(begin: 0.15, duration: 600.ms, curve: Curves.easeOutCubic)
        .shimmer(duration: 2000.ms, delay: (delay + 600).ms, color: Colors.white24);
  }

  Widget _buildTimelineItem({
    required bool isDark,
    required String year,
    required String title,
    required String desc,
    required Color color,
    required int delay,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [color, color.withOpacity(0.1)],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      year,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white54 : Colors.black45,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate()
        .fade(duration: 500.ms, delay: delay.ms)
        .scale(begin: const Offset(0.9, 0.9), duration: 500.ms, curve: Curves.easeOutBack)
        .slideX(begin: 0.2, duration: 500.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildSocialCircle(IconData icon, Color color, String url, int delay) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    ).animate().fadeIn(delay: delay.ms).scale(begin: const Offset(0.5, 0.5), curve: Curves.easeOutBack);
  }
}
