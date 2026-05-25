import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/payment_bottom_sheet.dart';

class ServicesTab extends StatefulWidget {
  const ServicesTab({super.key});

  @override
  State<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allServices = [
    {
      "title": "برمجة تطبيقات أندرويد وآيفون",
      "desc": "تطبيقات سريعة واحترافية (Flutter/Kotlin) لجميع الهواتف.",
      "oldPrice": "\$150",
      "newPrice": "\$59",
      "egpPrice": "2,950 ج.م",
      "icon": FontAwesomeIcons.mobileScreen,
      "gradient": const [Color(0xFF00C6FF), Color(0xFF0072FF)],
    },
    {
      "title": "تصميم وبرمجة المواقع",
      "desc": "مواقع تعريفية للشركات والأفراد، متجاوبة مع كافة الشاشات.",
      "oldPrice": "\$100",
      "newPrice": "\$39",
      "egpPrice": "1,950 ج.م",
      "icon": FontAwesomeIcons.globe,
      "gradient": const [Color(0xFF7C3AED), Color(0xFFC084FC)],
    },
    {
      "title": "تطوير أنظمة (SaaS) و Dashboards",
      "desc": "لوحات تحكم متطورة لتنظيم إدارة أعمالك بكل احترافية.",
      "oldPrice": "\$250",
      "newPrice": "\$99",
      "egpPrice": "4,950 ج.م",
      "icon": FontAwesomeIcons.server,
      "gradient": const [Color(0xFFFF0000), Color(0xFFFF6B6B)],
    },
    {
      "title": "تصميم المتاجر الإلكترونية",
      "desc": "متاجر متكاملة لبيع المنتجات مع بوابات الدفع الإلكتروني.",
      "oldPrice": "\$200",
      "newPrice": "\$69",
      "egpPrice": "3,450 ج.م",
      "icon": FontAwesomeIcons.cartShopping,
      "gradient": const [Color(0xFF00D2FF), Color(0xFF3A7BD5)],
    },
    {
      "title": "مواقع السيرة الذاتية (Portfolio)",
      "desc": "مواقع تفاعلية لعرض أعمالك ومهاراتك بشكل يبهر الشركات.",
      "oldPrice": "\$60",
      "newPrice": "\$19",
      "egpPrice": "950 ج.م",
      "icon": FontAwesomeIcons.idCard,
      "gradient": const [Color(0xFFFF6600), Color(0xFFFFB347)],
    },
    {
      "title": "بناء روبوتات الذكاء الاصطناعي",
      "desc": "روبوتات (AI Bots) للرد التلقائي وخدمة العملاء 24/7.",
      "oldPrice": "\$180",
      "newPrice": "\$49",
      "egpPrice": "2,450 ج.م",
      "icon": FontAwesomeIcons.robot,
      "gradient": const [Color(0xFF217346), Color(0xFF4CAF50)],
    },
    {
      "title": "أتمتة العمليات (Automation)",
      "desc": "برمجة سكربتات ذكية تقوم بالمهام الروتينية نيابة عنك.",
      "oldPrice": "\$120",
      "newPrice": "\$39",
      "egpPrice": "1,950 ج.م",
      "icon": FontAwesomeIcons.gears,
      "gradient": const [Color(0xFFF2994A), Color(0xFFF2C94C)],
    },
    {
      "title": "الأمن السيبراني وحماية الخوادم",
      "desc": "فحص الثغرات وتأمين الأنظمة وقواعد البيانات من الاختراق.",
      "oldPrice": "\$300",
      "newPrice": "\$89",
      "egpPrice": "4,450 ج.م",
      "icon": FontAwesomeIcons.shieldHalved,
      "gradient": const [Color(0xFF1CB5E0), Color(0xFF000851)],
    },
    {
      "title": "أنظمة الـ HR وإكسل",
      "desc": "ملفات Excel ذكية وأنظمة مبسطة لإدارة شؤون موظفيك.",
      "oldPrice": "\$80",
      "newPrice": "\$29",
      "egpPrice": "1,450 ج.م",
      "icon": FontAwesomeIcons.fileExcel,
      "gradient": const [Color(0xFF11998E), Color(0xFF38EF7D)],
    },
    {
      "title": "تحسين محركات البحث (SEO)",
      "desc": "رفع سرعة موقعك وتصدر نتائج جوجل لزيادة المبيعات.",
      "oldPrice": "\$90",
      "newPrice": "\$29",
      "egpPrice": "1,450 ج.م",
      "icon": FontAwesomeIcons.magnifyingGlassChart,
      "gradient": const [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
    },
    {
      "title": "صيانة وتحديث البرمجيات",
      "desc": "حل المشاكل التقنية (Bugs) وتطوير كفاءة الأنظمة القديمة.",
      "oldPrice": "\$100",
      "newPrice": "\$29",
      "egpPrice": "1,450 ج.م",
      "icon": FontAwesomeIcons.wrench,
      "gradient": const [Color(0xFFED213A), Color(0xFF93291E)],
    },
    {
      "title": "استشارات برمجية وتقنية",
      "desc": "جلسات لتخطيط مشروعك التقني واختيار أفضل الحلول.",
      "oldPrice": "\$50",
      "newPrice": "\$9",
      "egpPrice": "450 ج.م",
      "icon": FontAwesomeIcons.comments,
      "gradient": const [Color(0xFF00B4DB), Color(0xFF0083B0)],
    },
    {
      "title": "تصميم واجهات المستخدم (UI/UX)",
      "desc": "تصميم شاشات عصرية وجذابة لتطبيقاتك ومواقعك (Figma/Adobe).",
      "oldPrice": "\$120",
      "newPrice": "\$49",
      "egpPrice": "2,450 ج.م",
      "icon": FontAwesomeIcons.penNib,
      "gradient": const [Color(0xFFFC466B), Color(0xFF3F5EFB)],
    },
    {
      "title": "بوتات تيليجرام وديسكورد",
      "desc": "برمجة بوتات للرد التلقائي، إدارة المجموعات، واستقبال الطلبات.",
      "oldPrice": "\$80",
      "newPrice": "\$25",
      "egpPrice": "1,250 ج.م",
      "icon": FontAwesomeIcons.telegram,
      "gradient": const [Color(0xFF0088CC), Color(0xFF005580)],
    },
    {
      "title": "إعداد سيرفرات واستضافة (Cloud)",
      "desc": "تجهيز خوادم AWS/DigitalOcean وربط الدومين بشكل آمن.",
      "oldPrice": "\$150",
      "newPrice": "\$49",
      "egpPrice": "2,450 ج.م",
      "icon": FontAwesomeIcons.cloud,
      "gradient": const [Color(0xFF00B4DB), Color(0xFF000851)],
    },
    {
      "title": "برمجة أنظمة الكاشير (POS)",
      "desc": "برنامج مبيعات ومخازن متكامل لعيادتك أو متجرك.",
      "oldPrice": "\$200",
      "newPrice": "\$79",
      "egpPrice": "3,950 ج.م",
      "icon": FontAwesomeIcons.cashRegister,
      "gradient": const [Color(0xFF11998E), Color(0xFF000851)],
    },
    {
      "title": "برمجة وتطوير الواجهات (API)",
      "desc": "بناء واجهات برمجية سريعة وآمنة (Node.js/Python).",
      "oldPrice": "\$150",
      "newPrice": "\$59",
      "egpPrice": "2,950 ج.م",
      "icon": FontAwesomeIcons.code,
      "gradient": const [Color(0xFF8E2DE2), Color(0xFF000851)],
    },
    {
      "title": "تحليل البيانات واستخراجها (Scraping)",
      "desc": "سحب الداتا من المواقع وتحليلها وتنظيمها في جداول.",
      "oldPrice": "\$120",
      "newPrice": "\$39",
      "egpPrice": "1,950 ج.م",
      "icon": FontAwesomeIcons.database,
      "gradient": const [Color(0xFFF2994A), Color(0xFFED213A)],
    },
    {
      "title": "تصميم هويات وشعارات",
      "desc": "لوجوهات وهوية بصرية كاملة تميز علامتك التجارية.",
      "oldPrice": "\$90",
      "newPrice": "\$25",
      "egpPrice": "1,250 ج.م",
      "icon": FontAwesomeIcons.bezierCurve,
      "gradient": const [Color(0xFFFF0000), Color(0xFF8E2DE2)],
    },
    {
      "title": "ربط بوابات الدفع الإلكتروني",
      "desc": "تفعيل الدفع بالفيزا والماستركارد، PayPal، أو Stripe محلياً وعالمياً.",
      "oldPrice": "\$100",
      "newPrice": "\$35",
      "egpPrice": "1,750 ج.م",
      "icon": FontAwesomeIcons.creditCard,
      "gradient": const [Color(0xFF00C6FF), Color(0xFF11998E)],
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    final filteredServices = _allServices.where((s) {
      return s["title"].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
             s["desc"].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── Header ───
          SliverToBoxAdapter(
            child: SafeArea(
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
                              colors: [primaryColor, const Color(0xFF00C6FF)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(FontAwesomeIcons.briefcase, color: Colors.white, size: 24),
                        ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.05, duration: 1000.ms),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "خدمات المهندس",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              Text(
                                "عروض استثنائية وبأسعار خيالية! 🔥",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 600.ms).slideX(curve: Curves.easeOutBack),
                    
                    const SizedBox(height: 15),
                    
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: primaryColor.withOpacity(0.3), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        decoration: InputDecoration(
                          hintText: "ابحث عن الخدمة التي تريدها...",
                          hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black45),
                          border: InputBorder.none,
                          icon: Icon(FontAwesomeIcons.magnifyingGlass, color: primaryColor, size: 18),
                          suffixIcon: _searchQuery.isNotEmpty 
                            ? IconButton(
                                icon: Icon(Icons.clear, color: isDark ? Colors.white54 : Colors.black45),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = "");
                                },
                              )
                            : null,
                        ),
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val;
                          });
                        },
                      ),
                    ).animate().fade(duration: 800.ms).slideY(begin: -0.2, curve: Curves.easeOutBack),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // ─── Services List ───
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: filteredServices.isEmpty 
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(FontAwesomeIcons.ghost, size: 50, color: isDark ? Colors.white24 : Colors.black26),
                          const SizedBox(height: 15),
                          Text(
                            "لم يتم العثور على أي خدمة مطابقة!",
                            style: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == filteredServices.length) {
                        return const SizedBox(height: 100);
                      }
                      final s = filteredServices[index];
                      // Calculate dynamic delay based on index for staggered animation
                      final delay = 300 + (index * 100);
                      
                      return _buildServiceCard(
                        context,
                        title: s["title"],
                        desc: s["desc"],
                        oldPrice: s["oldPrice"],
                        newPrice: s["newPrice"],
                        egpPrice: s["egpPrice"],
                        icon: s["icon"],
                        gradient: s["gradient"],
                        delay: delay,
                      );
                    },
                    childCount: filteredServices.length + 1,
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String desc,
    required String oldPrice,
    required String newPrice,
    required String egpPrice,
    required IconData icon,
    required List<Color> gradient,
    required int delay,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF151828).withOpacity(0.8) : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: gradient[0].withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(isDark ? 0.2 : 0.1),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (ctx) => PaymentBottomSheet(
                serviceName: title,
                priceUsd: newPrice,
                priceEgp: egpPrice,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradient),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: gradient[0].withOpacity(0.5),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(icon, color: Colors.white, size: 24),
                    ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 2000.ms, color: Colors.white54),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            desc,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white60 : Colors.black54,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: gradient[0].withOpacity(isDark ? 0.1 : 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.greenAccent.withOpacity(0.5)),
                            ),
                            child: Text(
                              newPrice,
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.05, duration: 800.ms),
                          const SizedBox(width: 10),
                          Text(
                            oldPrice,
                            style: TextStyle(
                              color: Colors.redAccent.withOpacity(0.7),
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        egpPrice,
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate()
        .fade(duration: 800.ms, delay: (delay > 1500 ? 200 : delay).ms) // cap initial delay for performance
        .scale(begin: const Offset(0.7, 0.7), duration: 800.ms, curve: Curves.easeOutBack)
        .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOutCubic)
        .blurXY(begin: 10, end: 0, duration: 800.ms)
        .shimmer(duration: 1500.ms, delay: (delay + 800).ms, color: Colors.white38);
  }
}
