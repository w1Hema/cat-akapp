import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentBottomSheet extends StatelessWidget {
  final String serviceName;
  final String priceUsd;
  final String priceEgp;

  const PaymentBottomSheet({
    super.key,
    required this.serviceName,
    required this.priceUsd,
    required this.priceEgp,
  });

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("تم النسخ بنجاح!"),
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openWhatsApp() async {
    const phone = "201202060839";
    final message = Uri.encodeComponent("مرحباً مهندس إبراهيم، أرسل لك إيصال دفع لخدمة: $serviceName");
    final url = Uri.parse("https://wa.me/$phone?text=$message");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 20),
          Text(
            "تأكيد طلب الخدمة",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 10),
          Text(serviceName, style: const TextStyle(fontSize: 18, color: Colors.white)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                const Text("المبلغ المطلوب للدفع", style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 5),
                Text(priceEgp, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                Text("ما يعادل $priceUsd", style: const TextStyle(fontSize: 14, color: Colors.white54)),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms).scale(),
          const SizedBox(height: 25),
          const Text("يُرجى التحويل عبر فودافون كاش للرقم التالي:", style: TextStyle(fontSize: 14, color: Colors.white70)),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => _copyToClipboard(context, "01093922945"),
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent.withOpacity(0.5), width: 2),
                borderRadius: BorderRadius.circular(15),
                color: Colors.redAccent.withOpacity(0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("01093922945", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
                  Icon(Icons.copy, color: Colors.redAccent),
                ],
              ),
            ),
          ).animate().slideX(delay: 400.ms),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: _openWhatsApp,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 10,
              ),
              icon: const Icon(Icons.send),
              label: const Text("إرسال سكرين شوت الدفع (واتساب)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ).animate().slideY(begin: 1, end: 0, delay: 600.ms),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
