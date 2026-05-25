import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("تم النسخ بنجاح! ✅"),
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── Premium SliverAppBar with gradient ───
          SliverAppBar(
            expandedHeight: 320,
            floating: false,
            pinned: true,
            backgroundColor: isDark ? const Color(0xFF0A0C14) : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            const Color(0xFF0D0F1A),
                            const Color(0xFF1A0A2E),
                            const Color(0xFF0A0C14),
                          ]
                        : [
                            const Color(0xFFF8F0FF),
                            const Color(0xFFFFF0E5),
                            const Color(0xFFF3F4F6),
                          ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar with glow
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3 + _pulseController.value * 0.3),
                                  blurRadius: 30 + _pulseController.value * 20,
                                  spreadRadius: 5 + _pulseController.value * 5,
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [primaryColor, const Color(0xFF00C6FF)],
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: isDark ? const Color(0xFF0A0C14) : Colors.white,
                              backgroundImage: const AssetImage('assets/images/profile.png'),
                            ),
                          );
                        },
                      ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
                      const SizedBox(height: 16),
                      // Name
                      Text(
                        "ENG / IBRAHIM FATHY",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: [primaryColor, const Color(0xFF00C6FF)],
                            ).createShader(const Rect.fromLTWH(0, 0, 300, 30)),
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),
                      const SizedBox(height: 8),
                      // Title
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primaryColor.withOpacity(0.3)),
                        ),
                        child: Text(
                          "🚀 الخبير التقني المتقدم",
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white70 : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.8, 0.8)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ─── Description Section ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bio Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF0F1128), const Color(0xFF1A0A2E)]
                            : [Colors.white, const Color(0xFFFFF5EE)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: primaryColor.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.quoteRight, color: primaryColor, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              "نبذة عني",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "لست مجرد مبرمج، أنا مهندس للحلول الرقمية الآمنة. أدمج بين جمال التصميم، قوة الذكاء الاصطناعي (AI)، وصلابة الأمن السيبراني لأبني لك أنظمة تسبق عصرها.",
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.8,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ).animate()
                      .fade(duration: 700.ms, delay: 200.ms)
                      .blurXY(begin: 10, end: 0, duration: 700.ms, curve: Curves.easeOutCubic)
                      .slideX(begin: -0.1, duration: 700.ms, curve: Curves.easeOutCubic),

                  const SizedBox(height: 25),

                  // Stats Grid
                  Text(
                    "📊 الإحصائيات",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: _buildStatCard("🔥", "+50", "مشروع منجز", const Color(0xFFFF6600), isDark, 400)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatCard("⭐", "+5", "سنوات خبرة", const Color(0xFF00C6FF), isDark, 500)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatCard("🛡️", "+30", "عميل سعيد", const Color(0xFF7C3AED), isDark, 600)),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Skills Section
                  Text(
                    "⚡ ترسانة التقنيات",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 15),
                  _buildSkillsWrap(isDark),

                  const SizedBox(height: 25),

                  // Quick Contact
                  Text(
                    "📱 التواصل السريع",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ).animate().fadeIn(delay: 700.ms),
                  const SizedBox(height: 15),
                  _buildContactCard(
                    icon: FontAwesomeIcons.whatsapp,
                    label: "واتساب",
                    value: "01202060839",
                    color: const Color(0xFF25D366),
                    isDark: isDark,
                    onTap: () => _launchUrl("https://wa.me/201202060839"),
                    onLongPress: () => _copyToClipboard("01202060839"),
                    delay: 750,
                  ),
                  const SizedBox(height: 10),
                  _buildContactCard(
                    icon: FontAwesomeIcons.phone,
                    label: "هاتف مباشر",
                    value: "01093922945",
                    color: const Color(0xFF00C6FF),
                    isDark: isDark,
                    onTap: () => _launchUrl("tel:01093922945"),
                    onLongPress: () => _copyToClipboard("01093922945"),
                    delay: 800,
                  ),
                  const SizedBox(height: 10),
                  _buildContactCard(
                    icon: FontAwesomeIcons.envelope,
                    label: "البريد الإلكتروني",
                    value: "ibrahimfathyibrahim39@gmail.com",
                    color: const Color(0xFFFF6600),
                    isDark: isDark,
                    onTap: () => _launchUrl("mailto:ibrahimfathyibrahim39@gmail.com"),
                    onLongPress: () => _copyToClipboard("ibrahimfathyibrahim39@gmail.com"),
                    delay: 850,
                  ),
                  const SizedBox(height: 10),
                  _buildContactCard(
                    icon: FontAwesomeIcons.telegram,
                    label: "تيليجرام",
                    value: "@w1Hema",
                    color: const Color(0xFF0088CC),
                    isDark: isDark,
                    onTap: () => _launchUrl("https://t.me/w1Hema"),
                    onLongPress: () => _copyToClipboard("@w1Hema"),
                    delay: 900,
                  ),
                  const SizedBox(height: 10),
                  _buildContactCard(
                    icon: FontAwesomeIcons.facebook,
                    label: "فيسبوك",
                    value: "w1Hema",
                    color: const Color(0xFF1877F2),
                    isDark: isDark,
                    onTap: () => _launchUrl("https://facebook.com/w1Hema"),
                    onLongPress: () => _copyToClipboard("w1Hema"),
                    delay: 950,
                  ),
                  const SizedBox(height: 10),
                  _buildContactCard(
                    icon: FontAwesomeIcons.locationDot,
                    label: "الموقع الشخصي",
                    value: "البحيره / كفر الدوار",
                    color: const Color(0xFFE91E63),
                    isDark: isDark,
                    onTap: () => _launchUrl("https://maps.google.com/?q=Kafr+El+Dawwar"),
                    onLongPress: () => _copyToClipboard("البحيره / كفر الدوار"),
                    delay: 1000,
                  ),
                  const SizedBox(height: 10),
                  _buildContactCard(
                    icon: FontAwesomeIcons.discord,
                    label: "ديسكورد",
                    value: "w1Hema",
                    color: const Color(0xFF5865F2),
                    isDark: isDark,
                    onTap: () => _launchUrl("https://discord.gg/w1Hema"),
                    onLongPress: () => _copyToClipboard("w1Hema"),
                    delay: 1000,
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String emoji, String value, String label, Color color, bool isDark, int delay) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(isDark ? 0.15 : 0.1),
            color.withOpacity(isDark ? 0.05 : 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate()
        .fade(duration: 600.ms, delay: delay.ms)
        .scale(begin: const Offset(0.7, 0.7), duration: 600.ms, curve: Curves.easeOutBack)
        .shimmer(duration: 1200.ms, delay: (delay + 600).ms, color: Colors.white24);
  }

  Widget _buildSkillsWrap(bool isDark) {
    final skills = [
      {"name": "Flutter", "icon": FontAwesomeIcons.mobile, "color": const Color(0xFF02569B)},
      {"name": "Dart", "icon": FontAwesomeIcons.code, "color": const Color(0xFF0175C2)},
      {"name": "Python", "icon": FontAwesomeIcons.python, "color": const Color(0xFF3776AB)},
      {"name": "JavaScript", "icon": FontAwesomeIcons.js, "color": const Color(0xFFF7DF1E)},
      {"name": "C#", "icon": FontAwesomeIcons.microsoft, "color": const Color(0xFF68217A)},
      {"name": "Cyber Security", "icon": FontAwesomeIcons.shieldHalved, "color": const Color(0xFFFF0000)},
      {"name": "AI / ML", "icon": FontAwesomeIcons.brain, "color": const Color(0xFF7C3AED)},
      {"name": "HTML/CSS", "icon": FontAwesomeIcons.html5, "color": const Color(0xFFE34F26)},
      {"name": "React", "icon": FontAwesomeIcons.react, "color": const Color(0xFF61DAFB)},
      {"name": "TypeScript", "icon": FontAwesomeIcons.code, "color": const Color(0xFF3178C6)},
      {"name": "Excel / HR", "icon": FontAwesomeIcons.fileExcel, "color": const Color(0xFF217346)},
      {"name": "ADB / Android", "icon": FontAwesomeIcons.android, "color": const Color(0xFF3DDC84)},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: skills.asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: (skill["color"] as Color).withOpacity(isDark ? 0.15 : 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: (skill["color"] as Color).withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(skill["icon"] as IconData, size: 16, color: skill["color"] as Color),
              const SizedBox(width: 6),
              Text(
                skill["name"] as String,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: (550 + index * 50).ms).slideX(begin: 0.2);
      }).toList(),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isDark,
    required VoidCallback onTap,
    required VoidCallback onLongPress,
    required int delay,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(isDark ? 0.08 : 0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(FontAwesomeIcons.arrowUpRightFromSquare, size: 14, color: color),
            ],
          ),
        ),
      ),
    ).animate()
        .fade(duration: 500.ms, delay: delay.ms)
        .slideX(begin: 0.2, duration: 500.ms, curve: Curves.easeOutBack);
  }
}
