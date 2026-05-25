@echo off
setlocal enabledelayedexpansion
color 0b
echo ========================================================
echo       🚀 Cyber-CV GitHub Auto-Uploader 🚀
echo ========================================================
echo.

cd /d "C:\Users\Hema\Desktop\my-site\flutter_portfolio\cyber_cv_app"

git config user.email "eng.ibrahim@cybercv.com"
git config user.name "Ibrahim Fathy"

:: تنظيف الرابط الخاطئ الذي تم إدخاله في المرة السابقة
git remote remove origin 2>nul

:AskUrl
echo.
echo [!] تنبيه: لقد قمت بإدخال اسمك (w1Hemaa) فقط في المرة السابقة وهذا خطأ.
echo الرجاء نسخ الرابط الكاااااامل للمستودع من شريط المتصفح من الأعلى.
echo يجب أن يبدأ الرابط بـ https://github.com
echo مثال صحيح: https://github.com/w1Hemaa/cyber_cv_app.git
echo.
set /p REPO_URL="ألصق الرابط الكاااامل هنا واضغط Enter: "

if "!REPO_URL!"=="" (
    echo [خطأ] لم تقم بإدخال شيء! حاول مرة أخرى...
    goto :AskUrl
)

echo !REPO_URL! | findstr /i "https://github.com" >nul
if errorlevel 1 (
    echo [خطأ] الرابط غير صحيح! يجب أن يبدأ بـ https://github.com
    goto :AskUrl
)

git remote add origin "!REPO_URL!"

:DoPush
echo.
echo [1] جاري فحص الملفات (git add)...
git add .

echo.
echo [2] جاري حفظ التعديلات (git commit)...
git commit -m "Auto-Update: Complete Flutter App with Codemagic config"

echo.
echo [3] جاري الرفع إلى GitHub السحابة (git push)...
git push -u origin main --force

echo.
echo ========================================================
echo ✅ تمت عملية الرفع بنجاح! يمكنك الآن الذهاب إلى Codemagic
echo ========================================================
pause
