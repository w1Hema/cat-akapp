import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/payment_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("خدمات المهندس", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.robot, color: Color(0xFFFF6600)),
            onPressed: () {},
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 1.seconds),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("اكتشف الخدمات", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white))
                      .animate().fadeIn().slideX(),
                  const SizedBox(height: 5),
                  Text("برمجيات احترافية بأسعار تنافسية", style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor))
                      .animate().fadeIn(delay: 200.ms).slideX(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildServiceCard(
                  context,
                  title: "برمجة تطبيقات الهاتف المدمجة",
                  desc: "تطبيقات Android و iOS سريعة واحترافية بتصميم حديث",
                  oldPrice: "\$600",
                  newPrice: "\$349",
                  egpPrice: "16,500 ج.م",
                  icon: FontAwesomeIcons.mobileScreen,
                  delay: 300,
                ),
                _buildServiceCard(
                  context,
                  title: "تطوير أنظمة الويب (SaaS)",
                  desc: "لوحات تحكم وأنظمة إدارية متكاملة للشركات",
                  oldPrice: "\$850",
                  newPrice: "\$499",
                  egpPrice: "24,000 ج.م",
                  icon: FontAwesomeIcons.globe,
                  delay: 450,
                ),
                _buildServiceCard(
                  context,
                  title: "اختبار اختراق وأمن سيبراني",
                  desc: "حماية سيرفراتك واكتشاف الثغرات وتأمين البيانات",
                  oldPrice: "\$1,200",
                  newPrice: "\$699",
                  egpPrice: "33,500 ج.م",
                  icon: FontAwesomeIcons.shieldHalved,
                  delay: 600,
                ),
                _buildServiceCard(
                  context,
                  title: "أتمتة الأعمال وبناء AI Bots",
                  desc: "روبوتات ذكية وتقنيات AI لتسريع أعمال شركتك",
                  oldPrice: "\$500",
                  newPrice: "\$299",
                  egpPrice: "14,000 ج.م",
                  icon: FontAwesomeIcons.microchip,
                  delay: 750,
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, {required String title, required String desc, required String oldPrice, required String newPrice, required String egpPrice, required IconData icon, required int delay}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (ctx) => PaymentBottomSheet(serviceName: title, priceUsd: newPrice, priceEgp: egpPrice),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.5)),
                  ),
                  child: Icon(icon, color: Theme.of(context).primaryColor, size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 5),
                      Text(desc, style: const TextStyle(fontSize: 13, color: Colors.white54)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: Colors.greenAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                            child: Text(newPrice, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          const SizedBox(width: 10),
                          Text(oldPrice, style: const TextStyle(color: Colors.redAccent, decoration: TextDecoration.lineThrough, fontSize: 14)),
                          const Spacer(),
                          Text(egpPrice, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.2, end: 0, duration: 500.ms, curve: Curves.easeOutQuad);
  }
}
