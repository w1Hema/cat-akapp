@echo off
setlocal enabledelayedexpansion
color 0b
echo ========================================================
echo       🚀 Cyber-CV GitHub Auto-Uploader 🚀
echo ========================================================
echo.

cd /d "C:\Users\Hema\Desktop\my-site\flutter_portfolio\cyber_cv_app"

:: إعداد هوية وهمية أو سريعة لبرنامج Git حتى لا يعترض
git config user.email "eng.ibrahim@cybercv.com"
git config user.name "Ibrahim Fathy"

IF EXIST ".git" goto :AskUrlIfMissing

echo [!] المشروع غير مرتبط بـ GitHub حالياً. جاري إعداده لأول مرة...
git init
git branch -M main

:AskUrlIfMissing
:: التحقق مما إذا كان الرابط موجوداً بالفعل
git remote -v | find "origin" >nul
if %errorlevel% equ 0 goto :DoPush

:AskUrl
echo.
echo الرجاء الذهاب إلى موقع GitHub ونسخ رابط المستودع الخاص بك (Repository URL)
echo (الرابط يكون بهذا الشكل: https://github.com/YourName/cyber_cv.git)
echo.
set /p REPO_URL="ألصق الرابط هنا واضغط Enter: "

if "!REPO_URL!"=="" (
    echo [خطأ] لم تقم بإدخال الرابط! حاول مرة أخرى...
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
echo ✅ إذا لم يظهر لك أخطاء باللون الأحمر، فقد تمت عملية الرفع بنجاح!
echo يمكنك الآن الذهاب إلى Codemagic للبدء
echo ========================================================
pause
