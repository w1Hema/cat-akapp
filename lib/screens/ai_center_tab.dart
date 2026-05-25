import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AICenterTab extends StatefulWidget {
  const AICenterTab({super.key});

  @override
  State<AICenterTab> createState() => _AICenterTabState();
}

class _AICenterTabState extends State<AICenterTab> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isTyping = false;
  late AnimationController _brainPulse;

  // AI Knowledge Base - from the website data
  final Map<String, String> _aiResponses = {
    "مرحبا": "أهلاً وسهلاً بك! 🤖 أنا مساعد المهندس إبراهيم فتحي الذكي. كيف يمكنني مساعدتك اليوم؟",
    "من هو": "المهندس إبراهيم فتحي هو خبير تقني متقدم ومهندس للحلول الرقمية الآمنة. يدمج بين جمال التصميم، قوة الذكاء الاصطناعي، وصلابة الأمن السيبراني. 🚀",
    "خدمات": "يقدم المهندس خدمات متعددة منها:\n🔹 برمجة تطبيقات الهاتف (Flutter/Kotlin)\n🔹 تطوير أنظمة الويب (SaaS)\n🔹 اختبار اختراق وأمن سيبراني\n🔹 أتمتة الأعمال وبناء AI Bots\n🔹 تصميم مواقع CV احترافية\n🔹 أنظمة HR و Excel متقدمة",
    "مهارات": "يتقن المهندس إبراهيم:\n⚡ Flutter & Dart\n⚡ Python & JavaScript\n⚡ C# & TypeScript\n⚡ Cyber Security\n⚡ AI / Machine Learning\n⚡ React & HTML/CSS\n⚡ Android ADB",
    "تواصل": "يمكنك التواصل مع المهندس عبر:\n📱 واتساب: 01202060839\n📞 هاتف: 01093922945\n📧 بريد: ibrahimfathyibrahim39@gmail.com\n💬 تيليجرام: @w1Hema\n📘 فيسبوك: w1Hema",
    "اسعار": "تبدأ الأسعار من:\n💰 تطبيقات الهاتف: \$349 (16,500 ج.م)\n💰 أنظمة ويب SaaS: \$499 (24,000 ج.م)\n💰 أمن سيبراني: \$699 (33,500 ج.م)\n💰 AI Bots: \$299 (14,000 ج.م)\n💰 مواقع CV: \$149 (7,000 ج.م)\n🔥 عروض حصرية تصل إلى 40%!",
    "خبرة": "المهندس إبراهيم لديه:\n🔥 +50 مشروع منجز\n⭐ +5 سنوات خبرة\n🛡️ +30 عميل سعيد\nمتخصص في بناء أنظمة تسبق عصرها!",
  };

  @override
  void initState() {
    super.initState();
    _brainPulse = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Welcome message
    _messages.add({
      "role": "bot",
      "text": "أهلاً بك! أنا المساعد الذكي الخاص بالمهندس إبراهيم فتحي 🤖\nاسألني عن مهاراته، خدماته، أسعاره، أو كيفية التواصل معه!",
    });
  }

  @override
  void dispose() {
    _brainPulse.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": text});
      _isTyping = true;
    });
    _messageController.clear();

    // Simulate AI thinking
    Future.delayed(const Duration(milliseconds: 1200), () {
      String response = _getAIResponse(text);
      setState(() {
        _messages.add({"role": "bot", "text": response});
        _isTyping = false;
      });
    });
  }

  String _getAIResponse(String query) {
    final q = query.toLowerCase();
    if (q.contains("مرحب") || q.contains("اهلا") || q.contains("سلام") || q.contains("هلا")) {
      return _aiResponses["مرحبا"]!;
    } else if (q.contains("من هو") || q.contains("ابراهيم") || q.contains("عنه") || q.contains("نبذ")) {
      return _aiResponses["من هو"]!;
    } else if (q.contains("خدم") || q.contains("يعمل") || q.contains("يقدم") || q.contains("شغل")) {
      return _aiResponses["خدمات"]!;
    } else if (q.contains("مهار") || q.contains("يتقن") || q.contains("تقني") || q.contains("لغات")) {
      return _aiResponses["مهارات"]!;
    } else if (q.contains("تواصل") || q.contains("رقم") || q.contains("واتس") || q.contains("هاتف") || q.contains("اتصال")) {
      return _aiResponses["تواصل"]!;
    } else if (q.contains("سعر") || q.contains("كم") || q.contains("تكلف") || q.contains("ثمن") || q.contains("فلوس")) {
      return _aiResponses["اسعار"]!;
    } else if (q.contains("خبر") || q.contains("مشروع") || q.contains("سنوات") || q.contains("عميل")) {
      return _aiResponses["خبرة"]!;
    }
    return "🤔 سؤال ممتاز! للحصول على إجابة دقيقة، يمكنك التواصل مباشرة مع المهندس إبراهيم عبر واتساب: 01202060839\n\nيمكنك سؤالي عن:\n• خدماته\n• مهاراته\n• أسعاره\n• طرق التواصل\n• خبراته";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // ─── Header ───
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF0D0F1A), const Color(0xFF1A0A2E)]
                      : [Colors.white, const Color(0xFFF8F0FF)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  AnimatedBuilder(
                    animation: _brainPulse,
                    builder: (_, __) => Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF7C3AED).withOpacity(0.8 + _brainPulse.value * 0.2),
                            primaryColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF7C3AED).withOpacity(0.3 + _brainPulse.value * 0.2),
                            blurRadius: 15 + _brainPulse.value * 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(FontAwesomeIcons.brain, color: Colors.white, size: 22),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "مركز الذكاء الاصطناعي",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.greenAccent,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Hema-AI متصل الآن ✨",
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark ? Colors.greenAccent : Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().slideY(begin: -0.3),

            // ─── Quick Suggestions ───
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 56,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildSuggestionChip("خدماته", "💼", primaryColor, isDark),
                  _buildSuggestionChip("الأسعار", "💰", const Color(0xFF25D366), isDark),
                  _buildSuggestionChip("مهاراته", "⚡", const Color(0xFF00C6FF), isDark),
                  _buildSuggestionChip("تواصل", "📱", const Color(0xFF7C3AED), isDark),
                  _buildSuggestionChip("خبراته", "🔥", const Color(0xFFFF0000), isDark),
                ],
              ),
            ),

            // ─── Chat Messages ───
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isTyping) {
                    return _buildTypingIndicator(isDark);
                  }
                  final msg = _messages[index];
                  final isBot = msg["role"] == "bot";
                  return _buildMessageBubble(msg["text"]!, isBot, isDark, primaryColor, index);
                },
              ),
            ),

            // ─── Input Bar ───
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0A0C14) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.2),
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "اكتب سؤالك هنا...",
                          hintStyle: TextStyle(
                            color: isDark ? Colors.white38 : Colors.black38,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                        onSubmitted: _sendMessage,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, const Color(0xFF7C3AED)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => _sendMessage(_messageController.text),
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String label, String emoji, Color color, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _sendMessage("ما هي $label؟"),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(isDark ? 0.15 : 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isBot, bool isDark, Color primaryColor, int index) {
    return Align(
      alignment: isBot ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          gradient: isBot
              ? LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF0F1128), const Color(0xFF1A0A2E)]
                      : [Colors.white, const Color(0xFFF8F0FF)],
                )
              : LinearGradient(
                  colors: [primaryColor.withOpacity(0.9), const Color(0xFF7C3AED)],
                ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isBot ? const Radius.circular(4) : const Radius.circular(20),
            bottomRight: isBot ? const Radius.circular(20) : const Radius.circular(4),
          ),
          border: isBot
              ? Border.all(color: const Color(0xFF7C3AED).withOpacity(0.2))
              : null,
          boxShadow: [
            BoxShadow(
              color: (isBot ? const Color(0xFF7C3AED) : primaryColor).withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isBot) ...[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(FontAwesomeIcons.robot, size: 14, color: Color(0xFF7C3AED)),
              ),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: isBot
                      ? (isDark ? Colors.white : Colors.black87)
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate()
        .fade(duration: 400.ms, delay: 100.ms)
        .scale(begin: const Offset(0.9, 0.9), duration: 400.ms, curve: Curves.easeOutBack)
        .slideX(begin: isBot ? 0.1 : -0.1, duration: 400.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildTypingIndicator(bool isDark) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F1128) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF7C3AED).withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FontAwesomeIcons.robot, size: 14, color: Color(0xFF7C3AED)),
            const SizedBox(width: 10),
            Text(
              "يفكر...",
              style: TextStyle(
                color: isDark ? Colors.white54 : Colors.black45,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (i) {
                  return Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF7C3AED),
                    ),
                  ).animate(onPlay: (c) => c.repeat())
                      .fadeIn(delay: (i * 200).ms)
                      .then()
                      .fadeOut(delay: 400.ms);
                }),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(),
    );
  }
}
