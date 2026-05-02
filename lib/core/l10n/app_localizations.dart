import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  bool get _ar => locale.languageCode == 'ar';

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    _AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [Locale('ar'), Locale('en')];

  // ── Splash ──────────────────────────────────────────────────────────────────
  String get appName => 'Brain Flow';
  String get splashTagline =>
      _ar ? 'التركيز.  الراحة.  الازدهار.' : 'FOCUS.  REST.  THRIVE.';
  String get inhaleExhale => _ar ? 'شهيق.  زفير.' : 'INHALE.  EXHALE.';
  String get exhaleInhale => _ar ? 'زفير.  شهيق.' : 'EXHALE.  INHALE.';

  // ── Onboarding ──────────────────────────────────────────────────────────────
  String get onboardTitle1 => _ar ? 'احتضن عقلك' : 'Embrace Your Mind';
  String get onboardBody1 => _ar
      ? 'مصمم للإيقاعات الفريدة لاضطراب قصور الانتباه. نساعدك على العمل مع دماغك لا ضده.'
      : 'Designed for the unique rhythms of ADHD. We help you work with your brain, not against it.';
  String get onboardTitle2 => _ar ? 'اعثر على تركيزك' : 'Find Your Focus';
  String get onboardBody2 => _ar
      ? 'دفعات لطيفة وتقنيات مدعومة علمياً لتثبيت انتباهك حين يشرد.'
      : 'Gentle nudges and science-backed techniques to anchor your attention when it wanders.';
  String get onboardTitle3 => _ar ? 'استرح بعمق' : 'Rest Deeply';
  String get onboardBody3 => _ar
      ? 'أطفئ ضجة المساء بروتين يهدئ عقلك الدائم الإيقاظ لنوم أفضل.'
      : "Switch off the evening buzz with routines that calm the 'always-on' mind for better sleep.";
  String get getStarted => _ar ? 'ابدأ الآن' : 'Get Started';
  String get continueBtn => _ar ? 'متابعة' : 'Continue';

  // ── Sign-up ──────────────────────────────────────────────────────────────────
  String get createProfile => _ar ? 'إنشاء الملف الشخصي' : 'Create Profile';
  String get joinJourney =>
      _ar ? 'انضم إلينا لبدء رحلتك' : 'Join us to start your journey';
  String get fullName => _ar ? 'الاسم الكامل' : 'FULL NAME';
  String get fullNameHint => _ar ? 'مثال: محمد أحمد' : 'e.g. John Doe';
  String get emailAddress => _ar ? 'البريد الإلكتروني' : 'EMAIL ADDRESS';
  String get emailHint =>
      _ar ? 'مثال: name@example.com' : 'e.g. name@example.com';
  String get region => _ar ? 'المنطقة' : 'REGION';
  String get phoneNumber => _ar ? 'رقم الهاتف' : 'PHONE NUMBER';
  String get phoneHint => _ar ? 'مثال: 123456789' : 'e.g. 123456789';
  String get selectGender => _ar ? 'اختر الجنس' : 'SELECT GENDER';
  String get male => _ar ? 'ذكر' : 'Male';
  String get female => _ar ? 'أنثى' : 'Female';
  String get password => _ar ? 'كلمة المرور' : 'PASSWORD';
  String get passwordHint => _ar ? '٨ أحرف على الأقل' : 'Min. 8 characters';
  String get req8Chars => _ar ? '٨ أحرف على الأقل' : 'At least 8 characters';
  String get reqUppercase => _ar ? 'حرف كبير واحد' : 'One upper case letter';
  String get reqDigit =>
      _ar ? 'رقم واحد على الأقل' : 'At least 1 digital number';
  String get confirmPassword => _ar ? 'تأكيد كلمة المرور' : 'CONFIRM PASSWORD';
  String get confirmPasswordHint =>
      _ar ? 'أعد إدخال كلمة المرور' : 'Confirm your password';
  String get createAccount => _ar ? 'إنشاء حساب' : 'Create Account';

  // ── Login ────────────────────────────────────────────────────────────────────
  String get welcomeBack => _ar ? 'مرحباً بعودتك' : 'Welcome Back';
  String get signInToContinue =>
      _ar ? 'سجّل دخولك لمتابعة رحلتك' : 'Sign in to continue your journey';
  String get signIn => _ar ? 'تسجيل الدخول' : 'Sign In';
  String get noAccount => _ar ? 'ليس لديك حساب؟' : "Don't have an account?";
  String get signUp => _ar ? 'إنشاء حساب' : 'Sign Up';
  String get forgotPassword => _ar ? 'نسيت كلمة المرور؟' : 'Forgot Password?';
  String get fillAllFields =>
      _ar ? 'يرجى ملء جميع الحقول' : 'Please fill in all fields';

  // ── Select Interests ─────────────────────────────────────────────────────────
  String get selectInterests => _ar ? 'اختر اهتماماتك' : 'Select Interests';
  String get pickUpTo3 =>
      _ar ? 'اختر حتى ٣ مواضيع تهمك' : 'Pick up to 3 topics you care about';
  String get selectAtLeastOne => _ar
      ? 'يرجى اختيار اهتمام واحد على الأقل'
      : 'Please select at least one interest';
  String get interestFashion => _ar ? 'الأزياء' : 'Fashion';
  String get interestBeauty => _ar ? 'الجمال' : 'Beauty';
  String get interestTech => _ar ? 'التكنولوجيا' : 'Technology';
  String get interestFood => _ar ? 'الطعام' : 'Food';
  String get interestHealth => _ar ? 'الصحة' : 'Health';
  String get interestAdventure => _ar ? 'المغامرة' : 'Adventure';
  String get interestGaming => _ar ? 'الألعاب' : 'Gaming';
  String get interestHomeDecor => _ar ? 'المنزل والديكور' : 'Home & Decor';
  String get interestCrafts => _ar ? 'الحرف اليدوية' : 'Crafts';
  String get interestMusic => _ar ? 'الموسيقى' : 'Music';
  String get interestPets => _ar ? 'الحيوانات الأليفة' : 'Pets & Animals';
  String get interestArt => _ar ? 'الفن' : 'Art';
  String get interestAutomotive => _ar ? 'السيارات' : 'Automotive';

  // ── Bottom Nav ───────────────────────────────────────────────────────────────
  String get navExercise => _ar ? 'التمارين' : 'EXERCISE';
  String get navGames => _ar ? 'الألعاب' : 'GAMES';
  String get navTutorials => _ar ? 'الدروس' : 'TUTORIALS';
  String get navMore => _ar ? 'المزيد' : 'MORE';

  // ── Exercise Screen ───────────────────────────────────────────────────────────
  String get exercise => _ar ? 'التمارين' : 'Exercise';
  String get exerciseSubtitle =>
      _ar ? 'حرّك جسمك، صفِّ ذهنك' : 'Move your body, sharpen your mind';
  String get breathingTitle => _ar ? 'تمرين التنفس' : 'Breathing Exercise';
  String get dur1Min => _ar ? '١ دقيقة' : '1 MIN';
  String get breathingDesc => _ar
      ? 'تنفس صندوقي موجّه لتثبيت الجهاز العصبي وإزالة ضبابية الذهن.'
      : 'Guided box breathing to stabilize the nervous system and clear mental fog.';
  String get breathingH1 =>
      _ar ? 'تحفيز العصب المبهم' : 'Vagus nerve stimulation';
  String get breathingH2 => _ar ? 'تخفيف التوتر' : 'Stress reduction';
  String get breathingH3 => _ar ? 'تحمل ثاني أكسيد الكربون' : 'CO2 tolerance';
  String get emotionsDiaryTitle => _ar ? 'مذكرة المشاعر' : 'Emotions Diary';
  String get dur5to20Min => _ar ? '٥ - ٢٠ دقيقة' : '5 - 20 MIN';
  String get emotionsDiaryDesc => _ar
      ? 'تتبع مشاعرك وتأمل فيها لبناء الوعي الذاتي.'
      : 'Track and reflect on your emotions to build self-awareness over time.';
  String get emotionsH1 => _ar ? 'الوعي العاطفي' : 'Emotional awareness';
  String get emotionsH2 => _ar ? 'التعرف على الأنماط' : 'Pattern recognition';
  String get emotionsH3 => _ar ? 'تتبع المزاج' : 'Mood tracking';
  String get todosTitle => _ar ? 'مهامي' : 'My TODOS';
  String get tasksDuration => _ar ? 'مهام' : 'TASKS';
  String get todosDesc => _ar
      ? 'نظّم يومك في مهام مركّزة وتابع تقدمك خطوة بخطوة.'
      : 'Organizes your day into focused tasks and track your progress step by step.';
  String get todosH1 => _ar ? 'تقسيم المهام' : 'Task breakdown';
  String get todosH2 => _ar ? 'تتبع الخطوات' : 'Step tracking';
  String get todosH3 => _ar ? 'التخطيط اليومي' : 'Daily planning';

  // ── Exercise / Game Detail ───────────────────────────────────────────────────
  String get exerciseSession => _ar ? 'جلسة التمرين' : 'EXERCISE SESSION';
  String get gameSession => _ar ? 'جلسة اللعبة' : 'GAME SESSION';
  String get sessionHighlights => _ar ? 'أبرز الجلسة' : 'SESSION HIGHLIGHTS';
  String get startSession => _ar ? 'ابدأ الجلسة' : 'START SESSION';

  // ── Breathing Exercise ───────────────────────────────────────────────────────
  String get breatheReady => _ar ? 'استعد' : 'Ready';
  String get breatheIn => _ar ? 'شهيق' : 'Breathe In';
  String get breatheHold => _ar ? 'احتفظ' : 'Hold';
  String get breatheOut => _ar ? 'زفير' : 'Breathe Out';
  String get breatheRepeat => _ar ? 'تكرار' : 'REPEAT';
  String get rateSession => _ar ? 'قيّم جلستك' : 'Rate Your Session';
  String get rateSessionSub =>
      _ar ? 'كيف كانت تجربة التنفس؟' : 'How was your breathing experience?';
  String get submitRating => _ar ? 'إرسال' : 'SUBMIT';
  String get thankYou => _ar ? 'شكراً لك!' : 'Thank you!';

  // ── Emotions Diary ───────────────────────────────────────────────────────────
  String get chooseFeeling => _ar ? 'اختر مشاعرك' : 'Choose your feeling';
  String get feelingToday =>
      _ar ? 'ما الذي تشعر به اليوم؟' : 'What are you feeling today?';
  String get selectFeelingFirst =>
      _ar ? 'اختر مشاعرك أولاً' : 'Select a feeling first';
  String get writeWhatYouFeel =>
      _ar ? 'اكتب ما تشعر به' : 'Write what you feel';
  String get entrySaved => _ar ? 'تم حفظ الإدخال' : 'Entry saved';
  String get savedEntries => _ar ? 'الإدخالات المحفوظة' : 'SAVED ENTRIES';
  String get noEntriesYet => _ar
      ? 'لا توجد إدخالات بعد — اكتب أولى إدخالاتك أعلاه.'
      : 'No entries yet — write your first one above.';
  String get saveEntry => _ar ? 'حفظ الإدخال' : 'Save Entry';

  // Emotion names (diary picker)
  String get emotionHappy => _ar ? 'سعيد' : 'Happy';
  String get emotionCalm => _ar ? 'هادئ' : 'Calm';
  String get emotionAnxious => _ar ? 'قلق' : 'Anxious';
  String get emotionSad => _ar ? 'حزين' : 'Sad';
  String get emotionAngry => _ar ? 'غاضب' : 'Angry';
  String get emotionScared => _ar ? 'خائف' : 'Scared';
  String get emotionBored => _ar ? 'ملول' : 'Bored';
  String get emotionExcited => _ar ? 'متحمس' : 'Excited';
  String get emotionOverthinking => _ar ? 'تفكير مفرط' : 'Overthinking';
  String get emotionTense => _ar ? 'متوتر' : 'Tense';
  String get emotionOverwhelmed => _ar ? 'مرهق' : 'Overwhelmed';
  String get emotionGrateful => _ar ? 'ممتن' : 'Grateful';

  // ── Games Screen ─────────────────────────────────────────────────────────────
  String get cognitiveGames => _ar ? 'الألعاب المعرفية' : 'Cognitive Games';
  String get gamesSubtitle =>
      _ar ? 'درّب عقلك وأنت تستمتع' : 'Train your brain while having fun';
  String get followTheDot => _ar ? 'تابع النقطة' : 'Follow the Dot';
  String get tagFocus => _ar ? 'التركيز' : 'FOCUS';
  String get tagMemory => _ar ? 'الذاكرة' : 'MEMORY';
  String get dur5to20M => _ar ? '٥ - ٢٠ د' : '5 - 20 M';
  String get dur5to10M => _ar ? '٥ - ١٠ د' : '5 - 10 M';
  String get followDotDesc => _ar
      ? 'عزز انتباهك المستمر بتتبع نقطة متحركة إيقاعية.'
      : 'Enhance your sustained attention by tracking a rhythmic moving point through a shifting landscape.';
  String get followDotH1 => _ar ? 'تدريب حركة العين' : 'Saccadic eye training';
  String get followDotH2 => _ar ? 'الوعي المحيطي' : 'Peripheral awareness';
  String get followDotH3 => _ar ? 'بناء الصبر' : 'Patience building';
  String get flippingCard => _ar ? 'بطاقة الذاكرة' : 'Flipping Card';
  String get flippingCardDesc => _ar
      ? 'تجربة مطابقة للذاكرة لتعزيز الاسترجاع قصير الأمد.'
      : 'A memory-matching experience designed to strengthen short-term recall and visual processing speed.';
  String get flippingH1 => _ar ? 'حفظ الأنماط' : 'Pattern memorization';
  String get flippingH2 => _ar ? 'دقة الاسترجاع' : 'Recall accuracy';
  String get flippingH3 => _ar ? 'السرعة المعرفية' : 'Cognitive speed';

  // ── Follow Dot Game ───────────────────────────────────────────────────────────
  String get ready => _ar ? 'استعد' : 'READY';
  String get go => _ar ? 'انطلق' : 'GO';

  // ── Flipping Card Game ────────────────────────────────────────────────────────
  String get timeLabel => _ar ? 'الوقت' : 'TIME';
  String get scoreLabel => _ar ? 'النتيجة' : 'SCORE';
  String get sessionComplete => _ar ? 'اكتملت الجلسة' : 'Session Complete';
  String get timeLabelColon => _ar ? 'الوقت: ' : 'Time: ';
  String get scoreLabelColon => _ar ? 'النتيجة: ' : 'Score: ';
  String get playAgain => _ar ? 'العب مجدداً' : 'PLAY AGAIN';
  String get levelLabel => _ar ? 'المستوى' : 'Level';
  String get levelEasy => _ar ? 'سهل' : 'Easy';
  String get levelMedium => _ar ? 'متوسط' : 'Medium';
  String get levelHard => _ar ? 'صعب' : 'Hard';
  String get nextLevel => _ar ? 'المستوى التالي' : 'NEXT LEVEL';
  String get stopSession => _ar ? 'إيقاف' : 'STOP';
  String get allLevelsDone => _ar ? 'أتقنت جميع المستويات!' : 'All Levels Mastered!';
  String get rateGameSub => _ar ? 'كيف كانت تجربة اللعب؟' : 'How was your gaming session?';
  String get exitGame => _ar ? 'خروج' : 'EXIT';
  String get rateFocusTitle => _ar ? 'قيّم تركيزك الآن' : 'Rate Your Focus';
  String get rateFocusSub => _ar
      ? 'ما مستوى تركيزك في هذه اللحظة؟\nاختر من ١ إلى ١٠'
      : 'How focused are you right now?\nRate from 1 to 10';
  String get continuePlaying => _ar ? 'متابعة الفيديو' : 'CONTINUE WATCHING';

  // ── Tutorials ────────────────────────────────────────────────────────────────
  String get latestTutorials => _ar ? 'أحدث الدروس' : 'Latest Tutorials';
  String get filterAll => _ar ? 'الكل' : 'ALL';
  String get filterVideo => _ar ? 'فيديو' : 'VIDEO';
  String get filterAudio => _ar ? 'صوت' : 'AUDIO';
  String get tagCognitive => _ar ? 'معرفي' : 'COGNITIVE';
  String get tagRest => _ar ? 'الراحة' : 'REST';
  String get videoCourse => _ar ? 'دورة فيديو' : 'VIDEO COURSE';
  String get audioCourse => _ar ? 'دورة صوتية' : 'AUDIO COURSE';
  String get tutUnderstandRhythm =>
      _ar ? 'افهم إيقاعك' : 'Understanding Your Rhythm';
  String get tutSleepHygiene => _ar ? 'نظافة النوم ١٠١' : 'Sleep Hygiene 101';
  String get tutDopamine => _ar ? 'الدوبامين وأنت' : 'Dopamine & You';
  String get tutBreathing => _ar ? 'التنفس للوضوح' : 'Breathing for Clarity';
  String get tutHabits => _ar ? 'بناء عادات أفضل' : 'Building Better Habits';
  String get tutEveningWindDown => _ar ? 'هدوء المساء' : 'Evening Wind-Down';
  String get tutMorningBrain =>
      _ar ? 'تفعيل الدماغ صباحاً' : 'Morning Brain Activation';
  String get tutDeepFocus =>
      _ar ? 'مشهد صوتي للتركيز العميق' : 'Deep Focus Soundscape';

  // ── More Screen ───────────────────────────────────────────────────────────────
  String get brainFlowMember => _ar ? 'عضو برين فلو' : 'Brain Flow Member';
  String get fillForms => _ar ? 'ملء نماذج التقييم' : 'Fill Evaluation Forms';
  String get sectionAccount => _ar ? 'الحساب' : 'ACCOUNT';
  String get tileProfile => _ar ? 'الملف الشخصي' : 'Profile';
  String get tileNotifications => _ar ? 'الإشعارات' : 'Notifications';
  String get tilePrivacy => _ar ? 'الخصوصية' : 'Privacy';
  String get sectionPrefs => _ar ? 'التفضيلات' : 'PREFERENCES';
  String get tileAppearance => _ar ? 'المظهر' : 'Appearance';
  String get tileLanguage => _ar ? 'اللغة' : 'Language';
  String get tileAccessibility => _ar ? 'إمكانية الوصول' : 'Accessibility';
  String get sectionSupport => _ar ? 'الدعم' : 'SUPPORT';
  String get tileHelpFaq => _ar ? 'المساعدة والأسئلة الشائعة' : 'Help & FAQ';
  String get tileRateApp => _ar ? 'قيّم التطبيق' : 'Rate the App';
  String get tileSignOut => _ar ? 'تسجيل الخروج' : 'Sign Out';

  // ── Language Sheet ────────────────────────────────────────────────────────────
  String get chooseLanguage => _ar ? 'اختر اللغة' : 'Choose Language';
  String get langArabic => 'العربية';
  String get langEnglish => 'English';

  // ── Form Home Page ────────────────────────────────────────────────────────────
  String get evaluations => _ar ? 'التقييمات' : 'Evaluations';
  String get assessmentLibrary =>
      _ar ? 'مكتبة التقييمات' : 'Assessment Library';
  String get assessmentSubtitle => _ar
      ? 'افهم عقلك من خلال نماذج موجّهة'
      : 'Understand your mind through guided forms';
  String get focusAssessment => _ar ? 'تقييم التركيز' : 'Focus Assessment';
  String get tagClinical => _ar ? 'سريري' : 'CLINICAL';
  String get focusAssessDesc => _ar
      ? 'قيّم استدامة الانتباه والقدرة المعرفية.'
      : 'Assess attention sustainability and cognitive stamina.';
  String get mentalDistractionTitle =>
      _ar ? 'تقييم الشرود الذهني' : 'Mental Distraction Assessment';
  String get tagMentalDistraction =>
      _ar ? 'الشرود الذهني' : 'Mental Distraction';
  String get mentalDistractionDesc => _ar
      ? 'قيّم مدى تأثرك بالشرود الذهني وأثره على تركيزك.'
      : 'Evaluate your susceptibility to common mental distractions and their impact on focus.';
  String get helpOnFocusTitle => _ar ? 'المساعدة على التركيز' : 'Help On Focus';
  String get helpOnFocusDesc => _ar
      ? 'احصل على إرشادات لتحسين تركيزك.'
      : 'Get guidance on improving your focus and concentration.';

  // ── Assessment Focus Form ─────────────────────────────────────────────────────
  String get afIntroTitle => _ar
      ? 'ما الذي ساعدني على\nالتركيز اليوم؟'
      : 'WHAT HELPED ME TO\nFOCUS TODAY?';
  String get afIntroBody => _ar
      ? 'حدد ما أشعل حالة التدفق لديك اليوم\nكي تعيد إنتاجها غداً.'
      : 'Pinpoint exactly what triggered your flow\nstate today so you can replicate it tomorrow.';
  String get afSessionLabel => _ar ? 'عوامل التركيز' : 'FOCUS FACTORS';
  String get badgeQuickNote => _ar ? 'ملاحظة سريعة' : 'QUICK NOTE';
  String get badgeMultiChoice => _ar ? 'اختيار متعدد' : 'MULTIPLE CHOICE';
  String get badgeCheckIn => _ar ? 'تسجيل الحالة' : 'CHECK-IN';
  String get chooseAsMany =>
      _ar ? 'اختر كل ما ينطبق' : 'CHOOSE AS MANY AS APPLY';
  String get chooseOne => _ar ? 'اختر واحدًا فقط' : 'CHOOSE ONE';
  String get doneForNow => _ar ? 'انتهيت في الوقت الحالي' : 'DONE FOR NOW';
  String get continueUpper => _ar ? 'متابعة' : 'CONTINUE';
  String get chars => _ar ? 'حرف' : 'CHARS';
  String get focusLogged => _ar ? 'تم تسجيل التركيز!' : 'Focus Logged!';
  String get focusLoggedBody => _ar
      ? 'رائع! تأملك الذاتي هو الخطوة الأولى\nنحو إتقان تركيزك.'
      : 'Awesome! Your self-reflection is the first\nstep to mastering your focus.';
  String get finishReflection => _ar ? 'أنهِ التأمل' : 'Finish Reflection';
  String get finishReflectionUpper => _ar ? 'أنهِ التأمل' : 'FINISH REFLECTION';
  String get afQ1 => _ar
      ? 'اللحظة التي شعرت فيها بأعلى تركيز اليوم:'
      : 'The moment I felt most focused today:';
  String get afQ1Hint =>
      _ar ? 'صف لحظة تركيزك الأعلى...' : 'Describe your most focused moment...';
  String get afQ2 => _ar
      ? 'ما الذي ساعدني على الوصول لهذه اللحظة؟'
      : 'What helped me reach this moment?';
  String get afQ2OptA => _ar ? 'مكان هادئ' : 'A QUIET PLACE';
  String get afQ2OptB => _ar ? 'إيقاف الهاتف' : 'TURN OFF YOUR PHONE';
  String get afQ2OptC => _ar ? 'ترتيب الطاولة' : 'TIDY YOUR TABLE';
  String get afQ2OptD => _ar ? 'تحديد هدف صغير' : 'SET A SMALL GOAL';
  String get afQ2OptE => _ar ? 'ضبط مؤقت' : 'SET A TIMER';
  String get afQ2OptF =>
      _ar ? 'الاستماع لموسيقى هادئة' : 'LISTEN TO CALMING MUSIC';
  String get afQ2OptG => _ar ? 'أخذ أنفاس عميقة' : 'TAKE DEEP BREATHS';
  String get afQ2OptH => _ar ? 'النوم الكافي' : 'GET ENOUGH SLEEP';
  String get optSomethingElse => _ar ? 'شيء آخر' : 'SOMETHING ELSE';
  String get afQ3 => _ar
      ? 'الأشخاص الذين ساعدوني على التركيز (إن وجدوا):'
      : 'People who helped me focus (if any):';
  String get afQ3OptA => _ar ? 'لا أحد' : 'NO ONE';
  String get afQ3OptB => _ar ? 'صديق' : 'FRIEND';
  String get afQ3OptC => _ar ? 'فرد من الأسرة' : 'FAMILY MEMBER';
  String get afQ3OptD => _ar ? 'مدرب / معلم' : 'COACH/TEACHER';
  String get optOther => _ar ? 'آخر' : 'OTHER';
  String get afQ4 => _ar
      ? 'ما قلته لنفسي لتشجيعها على التركيز:'
      : 'Things I said to myself that encouraged me to focus:';
  String get afQ4Hint =>
      _ar ? 'ماذا قلت لنفسك؟' : 'What did you tell yourself?';
  String get afQ5 => _ar
      ? 'شيء سأكرره غداً لأنه أفادني اليوم:'
      : 'One thing I will repeat tomorrow because it helped me today:';
  String get afQ5Hint => _ar ? 'أكرر هذا...' : 'Repeat this...';
  String get afQ6 => _ar
      ? 'شيء سأتجنبه لأنه يضعف تركيزي:'
      : 'One thing I will try to avoid because it weakens my concentration:';
  String get afQ6Hint => _ar ? 'أتجنب هذا...' : 'Avoid this...';
  String get afQ7 =>
      _ar ? 'كلماتي عن تركيزي اليوم:' : 'My words about my focus today:';
  String get afQ7Hint => _ar
      ? 'مثال: جيد – متوسط – أفضل – منتظم – أقوى من أمس'
      : 'Example: Good – Average – Better – Consistent – Stronger than yesterday';
  String get afReminder => _ar ? 'تذكير لنفسي:' : 'A reminder to myself:';
  String get afReminderQuote => _ar
      ? '"أستطيع التركيز حين أهيئ الظروف المناسبة لنفسي."'
      : '"I can concentrate when I create the right conditions for myself."';

  // ── Help on Focus Form ────────────────────────────────────────────────────────
  String get hofIntroTitle => _ar ? 'تقييم التركيز' : 'FOCUS ASSESSMENT';
  String get hofIntroBody => _ar
      ? 'تسجيل شامل لجودة انتباهك\nخلال أنشطة يومك.'
      : 'A comprehensive check-in on your attention\nquality throughout today\'s activities.';
  String get hofSessionLabel => _ar ? 'فحص التركيز' : 'FOCUS CHECK';
  String get hofQ1 => _ar
      ? 'كيف تُقيّم مستوى انتباهك العام اليوم؟'
      : 'How would you rate your overall attention level today?';
  String get hofQ1O1 => _ar ? '١  ضعيف جداً' : '1  Very poor';
  String get hofQ1O2 => _ar ? '٢  ضعيف' : '2  Poor';
  String get hofQ1O3 => _ar ? '٣  متوسط' : '3  Average';
  String get hofQ1O4 => _ar ? '٤  جيد' : '4  Good';
  String get hofQ1O5 => _ar ? '٥  ممتاز' : '5  Excellent';
  String get hofQ2 => _ar
      ? 'أثناء أداء المهمة المطلوبة، كنت:'
      : 'While performing the required task, I was:';
  String get hofQ2O1 => _ar ? 'أركز جيداً' : 'Concentrating well';
  String get hofQ2O2 => _ar ? 'أشرد أحياناً' : 'Sometimes distracted';
  String get hofQ2O3 => _ar ? 'أشرد كثيراً' : 'Often distracted';
  String get hofQ2O4 =>
      _ar ? 'غير قادر على الاستمرار' : 'Unable to continue the task';
  String get hofQ3 => _ar
      ? 'عدد مرات الشرود أثناء المهمة:'
      : 'Number of times distracted during the task:';
  String get hofQ3O1 => _ar ? 'لا شرود' : 'No distractions';
  String get hofQ3O2 => _ar ? 'مرة واحدة' : 'Once';
  String get hofQ3O3 => _ar ? '٢-٣ مرات' : '2–3 times';
  String get hofQ3O4 => _ar ? 'أكثر من ٣ مرات' : 'More than 3 times';
  String get hofQ4 => _ar
      ? 'أكثر ما شتّت انتباهي اليوم كان:'
      : 'What distracted me most today was:';
  String get hofQ4O1 => _ar ? 'هاتفي' : 'MY PHONE';
  String get hofQ4O2 => _ar ? 'الضوضاء' : 'NOISE';
  String get hofQ4O3 => _ar ? 'المحيطون بي' : 'PEOPLE AROUND ME';
  String get hofQ4O4 => _ar ? 'الأفكار الداخلية' : 'INTERNAL THOUGHTS';
  String get hofQ4O5 => _ar ? 'الملل' : 'BOREDOM';
  String get hofQ4O6 => _ar ? 'التعب' : 'FATIGUE';
  String get hofQ5 => _ar
      ? 'هل استطعت استعادة تركيزك بعد الشرود؟'
      : 'Were you able to regain your focus after being distracted?';
  String get hofQ5O1 => _ar ? 'نعم، بسهولة' : 'Yes, easily';
  String get hofQ5O2 => _ar ? 'نعم، بصعوبة' : 'Yes, with difficulty';
  String get hofQ5O3 => _ar ? 'حاولت لكن لم أستطع' : "I tried but couldn't";
  String get hofQ5O4 => _ar ? 'لم أحاول' : "I didn't try";
  String get hofQ6 => _ar
      ? 'ما الذي ساعدك على استعادة انتباهك؟'
      : 'What helped you regain your attention?';
  String get hofQ6O1 => _ar ? 'التنفس العميق' : 'Deep breathing';
  String get hofQ6O2 => _ar ? 'إيقاف مصادر الشرود' : 'Turning off distractions';
  String get hofQ6O3 =>
      _ar ? 'تغيير وضعية الجلوس' : 'Changing your sitting position';
  String get hofQ6O4 => _ar ? 'أخذ استراحة قصيرة' : 'Taking a short break';
  String get hofQ6O5 => _ar ? 'لا شيء أفاد' : 'Nothing helped';
  String get hofQ6O6 => _ar ? 'أخرى' : 'Other';
  String get hofQ7 => _ar
      ? 'صف انتباهي اليوم بكلمة واحدة:'
      : 'Describe my attention today in one word:';
  String get hofQ7Hint => _ar ? 'كلمة واحدة عن تركيزك...' : 'One word focus...';
  String get hofQ8 => _ar
      ? 'ما الذي سأفعله غداً لتحسين انتباهي؟'
      : 'What will I do tomorrow to improve my attention?';
  String get hofQ8Hint => _ar ? 'خطة تحسيني...' : 'My improvement plan...';

  // ── Mental Distraction Form ───────────────────────────────────────────────────
  String get mdIntroTitle =>
      _ar ? 'تقييم\nالشرود الذهني' : 'MENTAL DISTRACTION\nASSESSMENT';
  String get mdIntroBody => _ar
      ? 'تتبع الشرود الذهني وحلله\nلبناء جدران تركيز أقوى.'
      : 'Track and analyze mental distractions to\nbuild stronger concentration walls.';
  String get mdSessionLabel => _ar ? 'نبض الشرود' : 'DISTRACTION PULSE';
  String get mdRateQuestion => _ar
      ? '⭐ قيّم مستوى شرودك اليوم:'
      : '⭐ Rate your distraction level today:';
  String get mdRateHint => _ar
      ? 'اضغط رقماً من ١ (تركيز عالٍ) إلى ٥ (شرود تام)'
      : 'Tap a number from 1 (very focused) to 5 (totally scattered)';
  String get mdR1Label => _ar ? 'تركيز\nعالٍ' : 'Very\nFocused';
  String get mdR2Label => _ar ? 'شرود\nبسيط' : 'Minimal\nDistraction';
  String get mdR3Label => _ar ? 'متوسط' : 'Moderate';
  String get mdR4Label => _ar ? 'كثير\nمن الشرود' : 'Many\nDistractions';
  String get mdR5Label => _ar ? 'شرود تام' : 'Scattered';
  String get mdFeedback1 => _ar
      ? 'رائع! كنت في منطقة التركيز اليوم. لنكتشف ما أبقاك مركزاً.'
      : 'Great! You were in the zone today. Let\'s find out what kept you focused.';
  String get mdFeedback2 => _ar
      ? 'جيد. شرود بسيط لكنك بقيت على المسار.'
      : 'Pretty good. Minor distractions but you mostly stayed on track.';
  String get mdFeedback3 => _ar
      ? 'يوم مختلط — بعض التركيز وبعض الشرود. لنعرف ما الذي أبعدك.'
      : 'A mixed day — some focus, some drift. Let\'s figure out what pulled you away.';
  String get mdFeedback4 => _ar
      ? 'كان الشرود متكرراً اليوم. تحديده هو الخطوة الأولى للإصلاح.'
      : 'Distractions were frequent today. Identifying them is the first step to fixing it.';
  String get mdFeedback5 => _ar
      ? 'كان ذهنك منشغلاً. لا بأس — هذا التقييم سيساعدك على الفهم.'
      : "Your mind was all over the place. That's okay — this assessment will help you understand why.";
  String get mdQ1 =>
      _ar ? 'ما الأشياء التي تشتت انتباهي؟' : 'What things distract me?';
  String get mdQ1Hint =>
      _ar ? 'اذكر أبرز مصادر شرودك...' : 'List your main distractions...';
  String get mdQ2 =>
      _ar ? 'في أي أوقات يكون شرودي أكثر؟' : 'What times am I most distracted?';
  String get mdQ2Hint =>
      _ar ? 'الصباح؟ المساء؟ بعد الغداء؟' : 'Morning? Evening? After lunch?';
  String get mdQ3 => _ar
      ? 'من هم الأشخاص الذين يشتتون انتباهي؟'
      : 'Who are the people who distract me?';
  String get mdQ3Hint =>
      _ar ? 'الأصدقاء؟ الأسرة؟ الزملاء؟' : 'Friends? Family? Colleagues?';
  String get mdQ4 => _ar
      ? 'ما الأفكار التي تتكرر في ذهني حين أشرد؟'
      : 'What thoughts most often recur in my mind when I am distracted?';
  String get mdQ4Hint =>
      _ar ? 'صف أفكارك المتكررة...' : 'Describe your recurring thoughts...';
  String get mdQ5 => _ar
      ? 'ما الذي أردت التركيز عليه لكنني لم أستطع؟'
      : 'What did I want to focus on but couldn\'t?';
  String get mdQ5Hint => _ar ? 'ما كان هدفك؟' : 'What was your goal?';
  String get mdQ6 => _ar
      ? 'ما المشاعر التي عشتها حين كنت شارداً؟'
      : 'What feelings did I experience when I was distracted?';
  String get mdQ6Hint => _ar
      ? 'مثال: قلق، ملل، انزعاج، توتر، إثارة مفاجئة، خوف، تفكير مفرط'
      : 'Example: anxiety, boredom, annoyance, tension, sudden excitement, fear, overthinking';
  String get mdQ7 => _ar
      ? 'ما السلوك الذي أظهرته بسبب الشرود؟'
      : 'What behavior did I exhibit because of the distraction?';
  String get mdQ7Hint => _ar
      ? 'مثال: أمسكت هاتفي، توقفت عن الدراسة، حلمت يقظاً، غيّرت مهمتي فجأة'
      : 'Example: I picked up my phone, stopped studying, daydreamed, suddenly changed my task';
  String get mdQ8 =>
      _ar ? 'ما الذي ساعدني على استعادة التركيز؟' : 'What helped me refocus?';
  String get mdQ8Hint =>
      _ar ? 'كيف عدت إلى منطقة التركيز؟' : 'How did you get back in the zone?';
  String get mdQ9 => _ar
      ? 'خطتي لتحسين التركيز في اليوم التالي:'
      : 'My plan to improve focus for the next day:';
  String get mdQ9Hint =>
      _ar ? 'ما الذي ستغيره غداً؟' : 'What will you change tomorrow?';
  String get mdQ10 => _ar
      ? 'جملة أكتبها لتشجيع نفسي على التركيز:'
      : 'A sentence I write to encourage myself to focus:';
  String get mdQ10Hint =>
      _ar ? 'اكتب جملتك القوية...' : 'Write your power sentence...';

  // ── Post-Meditation Attention Assessment ──────────────────────────────────────
  String get maaFormTitle => _ar ? 'تقييم الانتباه بعد التأمل' : 'Post-Meditation Attention';
  String get maaFormTag => _ar ? 'تأمل' : 'MEDITATION';
  String get maaFormDesc => _ar
      ? 'قيّم مستوى انتباهك وجودة تركيزك بعد جلسة التأمل.'
      : 'Assess your attention level and focus quality after a meditation session.';
  String get maaIntroTitle => _ar ? 'تقييم الانتباه\nبعد التأمل' : 'POST-MEDITATION\nATTENTION ASSESSMENT';
  String get maaIntroBody => _ar
      ? 'قيّم جودة انتباهك وتركيزك\nعقب جلستك التأملية.'
      : 'Assess the quality of your attention\nand focus after your meditation session.';
  String get maaSessionLabel => _ar ? 'بعد التأمل' : 'POST-MEDITATION';

  // Q1 rating
  String get maaQ1 => _ar ? '⭐ 1. مستوى انتباهي بعد التمرين:' : '⭐ 1. My attention level after the session:';
  String get maaQ1Hint => _ar ? 'اختر رقمًا من 1 إلى 5' : 'Tap a number from 1 to 5';
  String get maaR1Label => _ar ? 'منخفض\nجدًا' : 'Very\nLow';
  String get maaR2Label => _ar ? 'منخفض' : 'Low';
  String get maaR3Label => _ar ? 'متوسط' : 'Moderate';
  String get maaR4Label => _ar ? 'جيد' : 'Good';
  String get maaR5Label => _ar ? 'ممتاز' : 'Excellent';
  String get maaFeedback1 => _ar
      ? 'انتباهك كان منخفضاً جداً. جرّب جلسات أقصر مع تقليل المشتتات.'
      : 'Your attention was very low. Try shorter sessions with fewer distractions.';
  String get maaFeedback2 => _ar
      ? 'انتباهك كان منخفضاً. هيّئ بيئة أكثر هدوءاً في المرة القادمة.'
      : 'Your attention was low. Try creating a quieter environment next time.';
  String get maaFeedback3 => _ar
      ? 'انتباهك في المستوى المتوسط. الاستمرار في الممارسة سيحسّن النتائج.'
      : 'Your attention is at a moderate level. Continued practice will improve results.';
  String get maaFeedback4 => _ar
      ? 'انتباهك جيد بعد التأمل. أحسنت!'
      : 'Your attention is good after meditation. Well done!';
  String get maaFeedback5 => _ar
      ? 'رائع! تأملك أثمر عن مستوى انتباه ممتاز. استمر!'
      : 'Great! Your meditation produced an excellent attention level. Keep it up!';

  // Q2
  String get maaQ2 => _ar
      ? 'كيف أشعر الآن مقارنة بما قبل الجلسة؟'
      : 'How do I feel now compared to before the session?';
  String get maaQ2O1 => _ar ? 'أكثر هدوءًا' : 'More calm';
  String get maaQ2O2 => _ar ? 'أكثر تركيزًا' : 'More focused';
  String get maaQ2O3 => _ar ? 'أقل توترًا' : 'Less tense';
  String get maaQ2O4 => _ar ? 'أكثر وعيًا بما حولي' : 'More aware of surroundings';
  String get maaQ2O5 => _ar ? 'بدون فرق كبير' : 'No significant difference';
  String get maaQ2O6 => _ar ? 'أشعر بتشتت أكبر' : 'Feeling more distracted';

  // Q3
  String get maaQ3 => _ar
      ? 'هل لاحظت أفكارًا مشتتة أثناء التأمل؟'
      : 'Did I notice distracting thoughts during meditation?';
  String get maaQ3O1 => _ar ? 'لا، كان ذهني واضحًا' : 'No, my mind was clear';
  String get maaQ3O2 => _ar ? 'نعم، قليل من الأفكار' : 'Yes, a few thoughts';
  String get maaQ3O3 => _ar ? 'نعم، أفكار متكررة' : 'Yes, recurring thoughts';
  String get maaQ3O4 => _ar ? 'نعم، أفكار كثيرة أعاقتني' : 'Yes, many thoughts that blocked me';

  // Q4
  String get maaQ4 => _ar ? 'كيف تعاملتُ مع هذه الأفكار؟' : 'How did I handle these thoughts?';
  String get maaQ4O1 => _ar ? 'تجاهلتها بلطف وعدتُ للتركيز' : 'Gently ignored them and refocused';
  String get maaQ4O2 => _ar ? 'احتجت وقتًا للعودة' : 'Needed time to return to focus';
  String get maaQ4O3 => _ar ? 'لم أستطع العودة' : "Couldn't return to focus";
  String get maaQ4O4 => _ar ? 'لم تكن هناك أفكار مشتتة' : 'There were no distracting thoughts';

  // Q5
  String get maaQ5 => _ar
      ? 'مستوى وعيي بجسدي أثناء التمرين:'
      : 'My level of body awareness during the session:';
  String get maaQ5O1 => _ar ? 'منخفض' : 'Low';
  String get maaQ5O2 => _ar ? 'متوسط' : 'Moderate';
  String get maaQ5O3 => _ar ? 'جيد' : 'Good';
  String get maaQ5O4 => _ar ? 'عالٍ' : 'High';
  String get maaQ5O5 => _ar ? 'عالٍ جدًا' : 'Very High';

  // Q6
  String get maaQ6 => _ar
      ? 'ما أكثر شيء ساعدني خلال جلسة التأمل؟'
      : 'What helped me most during the meditation session?';
  String get maaQ6O1 => _ar ? 'التنفس العميق' : 'DEEP BREATHING';
  String get maaQ6O2 => _ar ? 'وضع الجلوس المريح' : 'COMFORTABLE POSITION';
  String get maaQ6O3 => _ar ? 'الهدوء من حولي' : 'QUIET SURROUNDINGS';
  String get maaQ6O4 => _ar ? 'صوت المرشد' : "INSTRUCTOR'S VOICE";
  String get maaQ6O5 => _ar ? 'التركيز على نقطة واحدة' : 'SINGLE POINT FOCUS';
  String get maaQ6Other => _ar ? 'شيء آخر' : 'SOMETHING ELSE';

  // Q7
  String get maaQ7 => _ar ? 'كيف أشعر تجاه نفسي بعد التأمل؟' : 'How do I feel about myself after meditation?';
  String get maaQ7O1 => _ar ? 'أشعر بالإنجاز' : 'I feel accomplished';
  String get maaQ7O2 => _ar ? 'أشعر براحة' : 'I feel at ease';
  String get maaQ7O3 => _ar ? 'أشعر بخفة' : 'I feel lighter';
  String get maaQ7O4 => _ar ? 'لا أشعر بتغيير' : "I don't feel a change";
  String get maaQ7O5 => _ar ? 'أشعر بإرهاق بسيط' : 'I feel slightly tired';

  // Q8 & Q9
  String get maaQ8 => _ar ? 'نواياي للتمرين القادم:' : 'My intentions for the next session:';
  String get maaQ8Hint => _ar
      ? 'شيء واحد سأركز عليه المرة القادمة...'
      : 'One thing I will focus on next time...';
  String get maaQ9 => _ar ? 'ملاحظة قصيرة لنفسي:' : 'A short note to myself:';
  String get maaQ9Hint => _ar ? 'ملاحظتي...' : 'My note...';

  // Completion
  String get maaCompleteTitle => _ar ? 'تقييمك مكتمل!' : 'Assessment Complete!';
  String get maaCompleteBody => _ar
      ? 'أحسنت! الوعي بتجربتك التأملية\nيساعدك على التعمق أكثر في كل جلسة.'
      : 'Well done! Awareness of your meditation experience\nhelps you deepen each future session.';

  // ── I Notice Activity Form ────────────────────────────────────────────────────
  String get inaFormTitle => _ar ? 'أنا ألاحظ' : 'I Notice';
  String get inaFormTag => _ar ? 'وعي ذاتي' : 'AWARENESS';
  String get inaFormDesc => _ar
      ? 'استكشف لحظتك الحالية عبر بطاقات وعي ذاتي موجّهة.'
      : 'Explore your current moment through guided self-awareness cards.';
  String get inaIntroTitle => _ar ? 'أنا ألاحظ' : 'I NOTICE';
  String get inaIntroBody => _ar
      ? 'استكشف لحظتك الحالية\nعبر ثماني بطاقات من الوعي الذاتي.'
      : 'Explore your current moment\nthrough eight self-awareness cards.';
  String get inaSessionLabel => _ar ? 'الوعي الذاتي' : 'SELF-AWARENESS';
  String get inaCompleteTitle => _ar ? 'تمت اللحظة!' : 'Moment Complete!';
  String get inaCompleteBody => _ar
      ? 'أحسنت! الوعي بلحظتك هو\nأول خطوة نحو التوازن الداخلي.'
      : 'Well done! Awareness of your moment\nis the first step toward inner balance.';

  // Card titles
  String get inaCard1Title => _ar ? 'أنا الآن…' : 'I Am Now…';
  String get inaCard2Title => _ar ? 'لحظة وعي' : 'Moment of Awareness';
  String get inaCard3Title => _ar ? 'توقف – تنفس – لاحظ' : 'Stop – Breathe – Notice';
  String get inaCard4Title => _ar ? 'أفكاري في اللحظة' : 'My Thoughts in This Moment';
  String get inaCard5Title => _ar ? 'لحظة تشتت' : 'A Moment of Distraction';
  String get inaCard6Title => _ar ? 'ما الذي أحتاجه الآن؟' : 'What Do I Need Now?';
  String get inaCard7Title => _ar ? 'إعادة ضبط سريعة' : 'Quick Reset';
  String get inaCard8Title => _ar ? 'مكسب اللحظة' : 'The Gain of the Moment';

  // Card 1
  String get inaC1Q1 => _ar ? 'الوضع الحالي:' : 'Current situation:';
  String get inaC1Q2 => _ar ? 'أشعر بـ:' : 'I feel:';
  String get inaC1Q3 => _ar ? 'الفكرة التي تدور في رأسي الآن:' : 'The thought in my mind right now:';
  String get inaC1Q4 => _ar ? 'ما الذي أحتاجه في هذه اللحظة؟' : 'What do I need in this moment?';

  // Card 2
  String get inaC2Q1 => _ar ? 'ماذا يحدث حولي الآن؟' : 'What is happening around me now?';
  String get inaC2Q2 => _ar
      ? 'ماذا يحدث داخلي؟ (مشاعر – أفكار – إحساس جسدي)'
      : 'What is happening inside me? (feelings – thoughts – physical sensation)';
  String get inaC2Q3 => _ar ? 'هل هذا يساعدني أم يشتتني؟' : 'Is this helping me or distracting me?';

  // Card 3
  String get inaC3Q1 => _ar ? 'شيء واحد أراه:' : 'One thing I see:';
  String get inaC3Q2 => _ar ? 'شيء واحد أسمعه:' : 'One thing I hear:';
  String get inaC3Q3 => _ar ? 'شيء واحد أشعر به جسديًا:' : 'One thing I feel physically:';
  String get inaC3Q4 => _ar ? 'النقطة التي أرغب بالتركيز عليها الآن:' : 'The point I want to focus on now:';

  // Card 4
  String get inaC4Q1 => _ar ? 'الفكرة القوية الآن:' : 'The strong thought right now:';
  String get inaC4Q2 => _ar ? 'هل هي واقعية أم مبالغ فيها؟' : 'Is it realistic or exaggerated?';
  String get inaC4Q3 => _ar ? 'ماذا يمكنني فعله بدل الاستسلام لها؟' : 'What can I do instead of surrendering to it?';

  // Card 5
  String get inaC5Q1 => _ar ? 'ما الذي شتتني الآن؟' : 'What distracted me just now?';
  String get inaC5Q2 => _ar ? 'كيف أثّر عليّ؟' : 'How did it affect me?';
  String get inaC5Q3 => _ar
      ? 'خيط واحد يمكنني الرجوع إليه لاستعادة تركيزي:'
      : 'One thread I can return to in order to regain my focus:';

  // Card 6
  String get inaC6OptEnergy => _ar ? 'طاقة' : 'ENERGY';
  String get inaC6OptCalm => _ar ? 'هدوء' : 'CALM';
  String get inaC6OptSpace => _ar ? 'مساحة' : 'SPACE';
  String get inaC6OptSupport => _ar ? 'دعم' : 'SUPPORT';
  String get inaC6OptFocus => _ar ? 'تركيز' : 'FOCUS';
  String get inaC6OptRest => _ar ? 'راحة' : 'REST';
  String get inaC6Next => _ar ? 'خطوتي التالية:' : 'My next step:';
  String get inaC6NextHint => _ar ? 'خطوتي التالية...' : 'My next step...';

  // Card 7
  String get inaC7Q1 => _ar ? 'حالتي العاطفية:' : 'My emotional state:';
  String get inaC7Q2 => _ar ? 'حالتي الذهنية:' : 'My mental state:';
  String get inaC7Q3 => _ar
      ? 'شيء صغير يمكنني فعله خلال دقيقة ليجعلني أفضل:'
      : 'One small thing I can do in a minute to feel better:';

  // Card 8
  String get inaC8Q1 => _ar
      ? 'ما الشيء الجيد، حتى لو كان صغيرًا، في هذه اللحظة؟'
      : 'What is good, even if small, in this moment?';
  String get inaC8Q2 => _ar ? 'كيف يمكنني الاستفادة منه؟' : 'How can I benefit from it?';

  // ── Todo List ─────────────────────────────────────────────────────────────────
  String get dailyFlow => _ar ? 'التدفق اليومي' : 'Daily Flow';
  String get dailyFlowSubtitle =>
      _ar ? 'صمّم يومك، اعثر على تركيزك' : 'Design your day, find your focus';
  String get noTasksYet => _ar
      ? 'لا مهام بعد.\nاضغط + لإضافة أول مهمة.'
      : 'No tasks yet.\nTap + to add your first flow.';
  String get deleteTask => _ar ? 'حذف المهمة؟' : 'Delete Task?';
  String get deletedMsg =>
      _ar ? 'ستُحذف نهائياً.' : 'will be permanently removed.';
  String get cancel => _ar ? 'إلغاء' : 'Cancel';
  String get delete => _ar ? 'حذف' : 'Delete';
  String get stepHint => _ar ? 'وصف الخطوة...' : 'Step description...';
  String get addStep => _ar ? 'إضافة وصف / خطوة' : 'ADD DESCRIPTION/STEP';
  String get newFlowTask => _ar ? 'مهمة تدفق جديدة' : 'New Flow Task';
  String get mainTaskTitle => _ar ? 'عنوان المهمة الرئيسي' : 'MAIN TASK TITLE';
  String get taskTitleHint =>
      _ar ? 'مثال: التركيز على المشروع المهم' : 'e.g., Critical Project Focus';
  String get targetTime => _ar ? 'الوقت المستهدف' : 'TARGET TIME';
  String get addToFlow => _ar ? 'أضف للتدفق' : 'Add to Flow';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension AppLocalizationsExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
