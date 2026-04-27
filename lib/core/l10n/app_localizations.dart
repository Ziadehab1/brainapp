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

  static const List<Locale> supportedLocales = [
    Locale('ar'),
    Locale('en'),
  ];

  // ── Splash ──────────────────────────────────────────────────────────────────
  String get appName         => 'Brain Flow';
  String get splashTagline   => _ar ? 'التركيز.  الراحة.  الازدهار.' : 'FOCUS.  REST.  THRIVE.';
  String get inhaleExhale    => _ar ? 'شهيق.  زفير.'  : 'INHALE.  EXHALE.';
  String get exhaleInhale    => _ar ? 'زفير.  شهيق.'  : 'EXHALE.  INHALE.';

  // ── Onboarding ──────────────────────────────────────────────────────────────
  String get onboardTitle1   => _ar ? 'احتضن عقلك'     : 'Embrace Your Mind';
  String get onboardBody1    => _ar
      ? 'مصمم للإيقاعات الفريدة لاضطراب فرط الحركة. نساعدك على العمل مع دماغك لا ضده.'
      : 'Designed for the unique rhythms of ADHD. We help you work with your brain, not against it.';
  String get onboardTitle2   => _ar ? 'اعثر على تركيزك' : 'Find Your Focus';
  String get onboardBody2    => _ar
      ? 'دفعات لطيفة وتقنيات مدعومة علمياً لتثبيت انتباهك حين يشرد.'
      : 'Gentle nudges and science-backed techniques to anchor your attention when it wanders.';
  String get onboardTitle3   => _ar ? 'استرح بعمق'      : 'Rest Deeply';
  String get onboardBody3    => _ar
      ? 'أطفئ ضجة المساء بروتين يهدئ عقلك الدائم الإيقاظ لنوم أفضل.'
      : "Switch off the evening buzz with routines that calm the 'always-on' mind for better sleep.";
  String get getStarted      => _ar ? 'ابدأ الآن'       : 'Get Started';
  String get continueBtn     => _ar ? 'متابعة'           : 'Continue';

  // ── Sign-up ──────────────────────────────────────────────────────────────────
  String get createProfile       => _ar ? 'إنشاء الملف الشخصي'    : 'Create Profile';
  String get joinJourney         => _ar ? 'انضم إلينا لبدء رحلتك' : 'Join us to start your journey';
  String get fullName            => _ar ? 'الاسم الكامل'           : 'FULL NAME';
  String get fullNameHint        => _ar ? 'مثال: محمد أحمد'        : 'e.g. John Doe';
  String get emailAddress        => _ar ? 'البريد الإلكتروني'      : 'EMAIL ADDRESS';
  String get emailHint           => _ar ? 'مثال: name@example.com' : 'e.g. name@example.com';
  String get region              => _ar ? 'المنطقة'                : 'REGION';
  String get phoneNumber         => _ar ? 'رقم الهاتف'             : 'PHONE NUMBER';
  String get phoneHint           => _ar ? 'مثال: 123456789'        : 'e.g. 123456789';
  String get selectGender        => _ar ? 'اختر الجنس'             : 'SELECT GENDER';
  String get male                => _ar ? 'ذكر'                    : 'Male';
  String get female              => _ar ? 'أنثى'                   : 'Female';
  String get password            => _ar ? 'كلمة المرور'            : 'PASSWORD';
  String get passwordHint        => _ar ? '٨ أحرف على الأقل'      : 'Min. 8 characters';
  String get req8Chars           => _ar ? '٨ أحرف على الأقل'      : 'At least 8 characters';
  String get reqUppercase        => _ar ? 'حرف كبير واحد'          : 'One upper case letter';
  String get reqDigit            => _ar ? 'رقم واحد على الأقل'    : 'At least 1 digital number';
  String get confirmPassword     => _ar ? 'تأكيد كلمة المرور'      : 'CONFIRM PASSWORD';
  String get confirmPasswordHint => _ar ? 'أعد إدخال كلمة المرور'  : 'Confirm your password';
  String get createAccount       => _ar ? 'إنشاء حساب'             : 'Create Account';

  // ── Select Interests ─────────────────────────────────────────────────────────
  String get selectInterests     => _ar ? 'اختر اهتماماتك'              : 'Select Interests';
  String get pickUpTo3           => _ar ? 'اختر حتى ٣ مواضيع تهمك'     : 'Pick up to 3 topics you care about';
  String get selectAtLeastOne    => _ar ? 'يرجى اختيار اهتمام واحد على الأقل' : 'Please select at least one interest';
  String get interestFashion     => _ar ? 'الأزياء'         : 'Fashion';
  String get interestBeauty      => _ar ? 'الجمال'          : 'Beauty';
  String get interestTech        => _ar ? 'التكنولوجيا'     : 'Technology';
  String get interestFood        => _ar ? 'الطعام'          : 'Food';
  String get interestHealth      => _ar ? 'الصحة'           : 'Health';
  String get interestAdventure   => _ar ? 'المغامرة'        : 'Adventure';
  String get interestGaming      => _ar ? 'الألعاب'         : 'Gaming';
  String get interestHomeDecor   => _ar ? 'المنزل والديكور' : 'Home & Decor';
  String get interestCrafts      => _ar ? 'الحرف اليدوية'   : 'Crafts';
  String get interestMusic       => _ar ? 'الموسيقى'        : 'Music';
  String get interestPets        => _ar ? 'الحيوانات الأليفة' : 'Pets & Animals';
  String get interestArt         => _ar ? 'الفن'            : 'Art';
  String get interestAutomotive  => _ar ? 'السيارات'        : 'Automotive';

  // ── Bottom Nav ───────────────────────────────────────────────────────────────
  String get navExercise   => _ar ? 'التمارين' : 'EXERCISE';
  String get navGames      => _ar ? 'الألعاب'  : 'GAMES';
  String get navTutorials  => _ar ? 'الدروس'   : 'TUTORIALS';
  String get navMore       => _ar ? 'المزيد'   : 'MORE';

  // ── Exercise Screen ───────────────────────────────────────────────────────────
  String get exercise              => _ar ? 'التمارين'                     : 'Exercise';
  String get exerciseSubtitle      => _ar ? 'حرّك جسمك، صفِّ ذهنك'        : 'Move your body, sharpen your mind';
  String get breathingTitle        => _ar ? 'تمرين التنفس'                 : 'Breathing Exercise';
  String get dur1Min               => _ar ? '١ دقيقة'                     : '1 MIN';
  String get breathingDesc         => _ar ? 'تنفس صندوقي موجّه لتثبيت الجهاز العصبي وإزالة ضبابية الذهن.' : 'Guided box breathing to stabilize the nervous system and clear mental fog.';
  String get breathingH1           => _ar ? 'تحفيز العصب المبهم'           : 'Vagus nerve stimulation';
  String get breathingH2           => _ar ? 'تخفيف التوتر'                 : 'Stress reduction';
  String get breathingH3           => _ar ? 'تحمل ثاني أكسيد الكربون'      : 'CO2 tolerance';
  String get emotionsDiaryTitle    => _ar ? 'مذكرة المشاعر'                : 'Emotions Diary';
  String get dur5to20Min           => _ar ? '٥ - ٢٠ دقيقة'               : '5 - 20 MIN';
  String get emotionsDiaryDesc     => _ar ? 'تتبع مشاعرك وتأمل فيها لبناء الوعي الذاتي.' : 'Track and reflect on your emotions to build self-awareness over time.';
  String get emotionsH1            => _ar ? 'الوعي العاطفي'                : 'Emotional awareness';
  String get emotionsH2            => _ar ? 'التعرف على الأنماط'           : 'Pattern recognition';
  String get emotionsH3            => _ar ? 'تتبع المزاج'                  : 'Mood tracking';
  String get todosTitle            => _ar ? 'مهامي'                        : 'My TODOS';
  String get tasksDuration         => _ar ? 'مهام'                         : 'TASKS';
  String get todosDesc             => _ar ? 'نظّم يومك في مهام مركّزة وتابع تقدمك خطوة بخطوة.' : 'Organizes your day into focused tasks and track your progress step by step.';
  String get todosH1               => _ar ? 'تقسيم المهام'                 : 'Task breakdown';
  String get todosH2               => _ar ? 'تتبع الخطوات'                 : 'Step tracking';
  String get todosH3               => _ar ? 'التخطيط اليومي'               : 'Daily planning';

  // ── Exercise / Game Detail ───────────────────────────────────────────────────
  String get exerciseSession   => _ar ? 'جلسة التمرين'  : 'EXERCISE SESSION';
  String get gameSession       => _ar ? 'جلسة اللعبة'   : 'GAME SESSION';
  String get sessionHighlights => _ar ? 'أبرز الجلسة'   : 'SESSION HIGHLIGHTS';
  String get startSession      => _ar ? 'ابدأ الجلسة'   : 'START SESSION';

  // ── Breathing Exercise ───────────────────────────────────────────────────────
  String get breatheReady  => _ar ? 'استعد'   : 'Ready';
  String get breatheIn     => _ar ? 'شهيق'    : 'Breathe In';
  String get breatheOut    => _ar ? 'زفير'    : 'Breathe Out';
  String get breatheRepeat => _ar ? 'تكرار'   : 'REPEAT';

  // ── Emotions Diary ───────────────────────────────────────────────────────────
  String get chooseFeeling      => _ar ? 'اختر مشاعرك'                         : 'Choose your feeling';
  String get feelingToday       => _ar ? 'ما الذي تشعر به اليوم؟'              : 'What are you feeling today?';
  String get selectFeelingFirst => _ar ? 'اختر مشاعرك أولاً'                   : 'Select a feeling first';
  String get writeWhatYouFeel   => _ar ? 'اكتب ما تشعر به'                     : 'Write what you feel';
  String get entrySaved         => _ar ? 'تم حفظ الإدخال'                      : 'Entry saved';
  String get savedEntries       => _ar ? 'الإدخالات المحفوظة'                  : 'SAVED ENTRIES';
  String get noEntriesYet       => _ar ? 'لا توجد إدخالات بعد — اكتب أولى إدخالاتك أعلاه.' : 'No entries yet — write your first one above.';

  // ── Games Screen ─────────────────────────────────────────────────────────────
  String get cognitiveGames    => _ar ? 'الألعاب المعرفية'               : 'Cognitive Games';
  String get gamesSubtitle     => _ar ? 'درّب عقلك وأنت تستمتع'          : 'Train your brain while having fun';
  String get followTheDot      => _ar ? 'تابع النقطة'                   : 'Follow the Dot';
  String get tagFocus          => _ar ? 'التركيز'                       : 'FOCUS';
  String get tagMemory         => _ar ? 'الذاكرة'                       : 'MEMORY';
  String get dur5to20M         => _ar ? '٥ - ٢٠ د'                     : '5 - 20 M';
  String get dur5to10M         => _ar ? '٥ - ١٠ د'                     : '5 - 10 M';
  String get followDotDesc     => _ar ? 'عزز انتباهك المستمر بتتبع نقطة متحركة إيقاعية.' : 'Enhance your sustained attention by tracking a rhythmic moving point through a shifting landscape.';
  String get followDotH1       => _ar ? 'تدريب حركة العين'              : 'Saccadic eye training';
  String get followDotH2       => _ar ? 'الوعي المحيطي'                 : 'Peripheral awareness';
  String get followDotH3       => _ar ? 'بناء الصبر'                   : 'Patience building';
  String get flippingCard      => _ar ? 'بطاقة الذاكرة'                 : 'Flipping Card';
  String get flippingCardDesc  => _ar ? 'تجربة مطابقة للذاكرة لتعزيز الاسترجاع قصير الأمد.' : 'A memory-matching experience designed to strengthen short-term recall and visual processing speed.';
  String get flippingH1        => _ar ? 'حفظ الأنماط'                  : 'Pattern memorization';
  String get flippingH2        => _ar ? 'دقة الاسترجاع'                 : 'Recall accuracy';
  String get flippingH3        => _ar ? 'السرعة المعرفية'               : 'Cognitive speed';

  // ── Follow Dot Game ───────────────────────────────────────────────────────────
  String get ready    => _ar ? 'استعد'  : 'READY';
  String get go       => _ar ? 'انطلق' : 'GO';

  // ── Flipping Card Game ────────────────────────────────────────────────────────
  String get timeLabel        => _ar ? 'الوقت'          : 'TIME';
  String get scoreLabel       => _ar ? 'النتيجة'        : 'SCORE';
  String get sessionComplete  => _ar ? 'اكتملت الجلسة'  : 'Session Complete';
  String get timeLabelColon   => _ar ? 'الوقت: '        : 'Time: ';
  String get scoreLabelColon  => _ar ? 'النتيجة: '      : 'Score: ';
  String get playAgain        => _ar ? 'العب مجدداً'     : 'PLAY AGAIN';

  // ── Tutorials ────────────────────────────────────────────────────────────────
  String get latestTutorials     => _ar ? 'أحدث الدروس'               : 'Latest Tutorials';
  String get filterAll           => _ar ? 'الكل'                      : 'ALL';
  String get filterVideo         => _ar ? 'فيديو'                     : 'VIDEO';
  String get filterAudio         => _ar ? 'صوت'                      : 'AUDIO';
  String get tagCognitive        => _ar ? 'معرفي'                     : 'COGNITIVE';
  String get tagRest             => _ar ? 'الراحة'                    : 'REST';
  String get videoCourse         => _ar ? 'دورة فيديو'                : 'VIDEO COURSE';
  String get audioCourse         => _ar ? 'دورة صوتية'                : 'AUDIO COURSE';
  String get tutUnderstandRhythm => _ar ? 'افهم إيقاعك'               : 'Understanding Your Rhythm';
  String get tutSleepHygiene     => _ar ? 'نظافة النوم ١٠١'           : 'Sleep Hygiene 101';
  String get tutDopamine         => _ar ? 'الدوبامين وأنت'             : 'Dopamine & You';
  String get tutBreathing        => _ar ? 'التنفس للوضوح'              : 'Breathing for Clarity';
  String get tutHabits           => _ar ? 'بناء عادات أفضل'           : 'Building Better Habits';
  String get tutEveningWindDown  => _ar ? 'هدوء المساء'               : 'Evening Wind-Down';
  String get tutMorningBrain     => _ar ? 'تفعيل الدماغ صباحاً'       : 'Morning Brain Activation';
  String get tutDeepFocus        => _ar ? 'مشهد صوتي للتركيز العميق'  : 'Deep Focus Soundscape';

  // ── More Screen ───────────────────────────────────────────────────────────────
  String get brainFlowMember   => _ar ? 'عضو برين فلو'                : 'Brain Flow Member';
  String get fillForms         => _ar ? 'ملء نماذج التقييم'           : 'Fill Evaluation Forms';
  String get sectionAccount    => _ar ? 'الحساب'                      : 'ACCOUNT';
  String get tileProfile       => _ar ? 'الملف الشخصي'               : 'Profile';
  String get tileNotifications => _ar ? 'الإشعارات'                   : 'Notifications';
  String get tilePrivacy       => _ar ? 'الخصوصية'                    : 'Privacy';
  String get sectionPrefs      => _ar ? 'التفضيلات'                   : 'PREFERENCES';
  String get tileAppearance    => _ar ? 'المظهر'                      : 'Appearance';
  String get tileLanguage      => _ar ? 'اللغة'                       : 'Language';
  String get tileAccessibility => _ar ? 'إمكانية الوصول'              : 'Accessibility';
  String get sectionSupport    => _ar ? 'الدعم'                       : 'SUPPORT';
  String get tileHelpFaq       => _ar ? 'المساعدة والأسئلة الشائعة'   : 'Help & FAQ';
  String get tileRateApp       => _ar ? 'قيّم التطبيق'                : 'Rate the App';
  String get tileSignOut       => _ar ? 'تسجيل الخروج'               : 'Sign Out';

  // ── Language Sheet ────────────────────────────────────────────────────────────
  String get chooseLanguage => _ar ? 'اختر اللغة'  : 'Choose Language';
  String get langArabic     => 'العربية';
  String get langEnglish    => 'English';

  // ── Form Home Page ────────────────────────────────────────────────────────────
  String get evaluations         => _ar ? 'التقييمات'                              : 'Evaluations';
  String get assessmentLibrary   => _ar ? 'مكتبة التقييمات'                        : 'Assessment Library';
  String get assessmentSubtitle  => _ar ? 'افهم عقلك من خلال نماذج موجّهة'         : 'Understand your mind through guided forms';
  String get focusAssessment     => _ar ? 'تقييم التركيز'                           : 'Focus Assessment';
  String get tagClinical         => _ar ? 'سريري'                                  : 'CLINICAL';
  String get focusAssessDesc     => _ar ? 'قيّم استدامة الانتباه والقدرة المعرفية.' : 'Assess attention sustainability and cognitive stamina.';
  String get mentalDistractionTitle => _ar ? 'تقييم الشرود الذهني'                 : 'Mental Distraction Assessment';
  String get tagMentalDistraction   => _ar ? 'الشرود الذهني'                       : 'Mental Distraction';
  String get mentalDistractionDesc  => _ar ? 'قيّم مدى تأثرك بالشرود الذهني وأثره على تركيزك.' : 'Evaluate your susceptibility to common mental distractions and their impact on focus.';
  String get helpOnFocusTitle    => _ar ? 'المساعدة على التركيز'                   : 'Help On Focus';
  String get helpOnFocusDesc     => _ar ? 'احصل على إرشادات لتحسين تركيزك.'        : 'Get guidance on improving your focus and concentration.';

  // ── Assessment Focus Form ─────────────────────────────────────────────────────
  String get afIntroTitle        => _ar ? 'ما الذي ساعدني على\nالتركيز اليوم؟' : 'WHAT HELPED ME TO\nFOCUS TODAY?';
  String get afIntroBody         => _ar ? 'حدد ما أشعل حالة التدفق لديك اليوم\nكي تعيد إنتاجها غداً.' : 'Pinpoint exactly what triggered your flow\nstate today so you can replicate it tomorrow.';
  String get afSessionLabel      => _ar ? 'عوامل التركيز'  : 'FOCUS FACTORS';
  String get badgeQuickNote      => _ar ? 'ملاحظة سريعة'   : 'QUICK NOTE';
  String get badgeMultiChoice    => _ar ? 'اختيار متعدد'   : 'MULTIPLE CHOICE';
  String get badgeCheckIn        => _ar ? 'تسجيل الحالة'   : 'CHECK-IN';
  String get chooseAsMany        => _ar ? 'اختر كل ما ينطبق'   : 'CHOOSE AS MANY AS APPLY';
  String get doneForNow          => _ar ? 'انتهيت في الوقت الحالي' : 'DONE FOR NOW';
  String get continueUpper       => _ar ? 'متابعة'          : 'CONTINUE';
  String get chars               => _ar ? 'حرف'             : 'CHARS';
  String get focusLogged         => _ar ? 'تم تسجيل التركيز!' : 'Focus Logged!';
  String get focusLoggedBody     => _ar ? 'رائع! تأملك الذاتي هو الخطوة الأولى\nنحو إتقان تركيزك.' : 'Awesome! Your self-reflection is the first\nstep to mastering your focus.';
  String get finishReflection    => _ar ? 'أنهِ التأمل'     : 'Finish Reflection';
  String get finishReflectionUpper => _ar ? 'أنهِ التأمل'  : 'FINISH REFLECTION';
  String get afQ1                => _ar ? 'اللحظة التي شعرت فيها بأعلى تركيز اليوم:' : 'The moment I felt most focused today:';
  String get afQ1Hint            => _ar ? 'صف لحظة تركيزك الأعلى...' : 'Describe your most focused moment...';
  String get afQ2                => _ar ? 'ما الذي ساعدني على الوصول لهذه اللحظة؟' : 'What helped me reach this moment?';
  String get afQ2OptA            => _ar ? 'مكان هادئ'              : 'A QUIET PLACE';
  String get afQ2OptB            => _ar ? 'إيقاف الهاتف'           : 'TURN OFF YOUR PHONE';
  String get afQ2OptC            => _ar ? 'ترتيب الطاولة'           : 'TIDY YOUR TABLE';
  String get afQ2OptD            => _ar ? 'تحديد هدف صغير'         : 'SET A SMALL GOAL';
  String get afQ2OptE            => _ar ? 'ضبط مؤقت'               : 'SET A TIMER';
  String get afQ2OptF            => _ar ? 'الاستماع لموسيقى هادئة'  : 'LISTEN TO CALMING MUSIC';
  String get afQ2OptG            => _ar ? 'أخذ أنفاس عميقة'        : 'TAKE DEEP BREATHS';
  String get afQ2OptH            => _ar ? 'النوم الكافي'            : 'GET ENOUGH SLEEP';
  String get optSomethingElse    => _ar ? 'شيء آخر'                : 'SOMETHING ELSE';
  String get afQ3                => _ar ? 'الأشخاص الذين ساعدوني على التركيز (إن وجدوا):' : 'People who helped me focus (if any):';
  String get afQ3OptA            => _ar ? 'لا أحد'                 : 'NO ONE';
  String get afQ3OptB            => _ar ? 'صديق'                   : 'FRIEND';
  String get afQ3OptC            => _ar ? 'فرد من الأسرة'           : 'FAMILY MEMBER';
  String get afQ3OptD            => _ar ? 'مدرب / معلم'             : 'COACH/TEACHER';
  String get optOther            => _ar ? 'آخر'                    : 'OTHER';
  String get afQ4                => _ar ? 'ما قلته لنفسي لتشجيعها على التركيز:' : 'Things I said to myself that encouraged me to focus:';
  String get afQ4Hint            => _ar ? 'ماذا قلت لنفسك؟'        : 'What did you tell yourself?';
  String get afQ5                => _ar ? 'شيء سأكرره غداً لأنه أفادني اليوم:' : 'One thing I will repeat tomorrow because it helped me today:';
  String get afQ5Hint            => _ar ? 'أكرر هذا...'            : 'Repeat this...';
  String get afQ6                => _ar ? 'شيء سأتجنبه لأنه يضعف تركيزي:' : 'One thing I will try to avoid because it weakens my concentration:';
  String get afQ6Hint            => _ar ? 'أتجنب هذا...'           : 'Avoid this...';
  String get afQ7                => _ar ? 'كلماتي عن تركيزي اليوم:' : 'My words about my focus today:';
  String get afQ7Hint            => _ar ? 'مثال: جيد – متوسط – أفضل – منتظم – أقوى من أمس' : 'Example: Good – Average – Better – Consistent – Stronger than yesterday';
  String get afReminder          => _ar ? 'تذكير لنفسي:' : 'A reminder to myself:';
  String get afReminderQuote     => _ar ? '"أستطيع التركيز حين أهيئ الظروف المناسبة لنفسي."' : '"I can concentrate when I create the right conditions for myself."';

  // ── Help on Focus Form ────────────────────────────────────────────────────────
  String get hofIntroTitle   => _ar ? 'تقييم التركيز'         : 'FOCUS ASSESSMENT';
  String get hofIntroBody    => _ar ? 'تسجيل شامل لجودة انتباهك\nخلال أنشطة يومك.' : 'A comprehensive check-in on your attention\nquality throughout today\'s activities.';
  String get hofSessionLabel => _ar ? 'فحص التركيز'           : 'FOCUS CHECK';
  String get hofQ1           => _ar ? 'كيف تُقيّم مستوى انتباهك العام اليوم؟' : 'How would you rate your overall attention level today?';
  String get hofQ1O1         => _ar ? '١  ضعيف جداً'  : '1  Very poor';
  String get hofQ1O2         => _ar ? '٢  ضعيف'       : '2  Poor';
  String get hofQ1O3         => _ar ? '٣  متوسط'      : '3  Average';
  String get hofQ1O4         => _ar ? '٤  جيد'        : '4  Good';
  String get hofQ1O5         => _ar ? '٥  ممتاز'      : '5  Excellent';
  String get hofQ2           => _ar ? 'أثناء أداء المهمة المطلوبة، كنت:' : 'While performing the required task, I was:';
  String get hofQ2O1         => _ar ? 'أركز جيداً'              : 'Concentrating well';
  String get hofQ2O2         => _ar ? 'أشرد أحياناً'             : 'Sometimes distracted';
  String get hofQ2O3         => _ar ? 'أشرد كثيراً'              : 'Often distracted';
  String get hofQ2O4         => _ar ? 'غير قادر على الاستمرار'   : 'Unable to continue the task';
  String get hofQ3           => _ar ? 'عدد مرات الشرود أثناء المهمة:' : 'Number of times distracted during the task:';
  String get hofQ3O1         => _ar ? 'لا شرود'        : 'No distractions';
  String get hofQ3O2         => _ar ? 'مرة واحدة'      : 'Once';
  String get hofQ3O3         => _ar ? '٢-٣ مرات'       : '2–3 times';
  String get hofQ3O4         => _ar ? 'أكثر من ٣ مرات' : 'More than 3 times';
  String get hofQ4           => _ar ? 'أكثر ما شتّت انتباهي اليوم كان:' : 'What distracted me most today was:';
  String get hofQ4O1         => _ar ? 'هاتفي'            : 'MY PHONE';
  String get hofQ4O2         => _ar ? 'الضوضاء'          : 'NOISE';
  String get hofQ4O3         => _ar ? 'المحيطون بي'      : 'PEOPLE AROUND ME';
  String get hofQ4O4         => _ar ? 'الأفكار الداخلية' : 'INTERNAL THOUGHTS';
  String get hofQ4O5         => _ar ? 'الملل'            : 'BOREDOM';
  String get hofQ4O6         => _ar ? 'التعب'            : 'FATIGUE';
  String get hofQ5           => _ar ? 'هل استطعت استعادة تركيزك بعد الشرود؟' : 'Were you able to regain your focus after being distracted?';
  String get hofQ5O1         => _ar ? 'نعم، بسهولة'           : 'Yes, easily';
  String get hofQ5O2         => _ar ? 'نعم، بصعوبة'           : 'Yes, with difficulty';
  String get hofQ5O3         => _ar ? 'حاولت لكن لم أستطع'    : "I tried but couldn't";
  String get hofQ5O4         => _ar ? 'لم أحاول'              : "I didn't try";
  String get hofQ6           => _ar ? 'ما الذي ساعدك على استعادة انتباهك؟' : 'What helped you regain your attention?';
  String get hofQ6O1         => _ar ? 'التنفس العميق'          : 'Deep breathing';
  String get hofQ6O2         => _ar ? 'إيقاف مصادر الشرود'     : 'Turning off distractions';
  String get hofQ6O3         => _ar ? 'تغيير وضعية الجلوس'     : 'Changing your sitting position';
  String get hofQ6O4         => _ar ? 'أخذ استراحة قصيرة'      : 'Taking a short break';
  String get hofQ6O5         => _ar ? 'لا شيء أفاد'            : 'Nothing helped';
  String get hofQ6O6         => _ar ? 'أخرى'                  : 'Other';
  String get hofQ7           => _ar ? 'صف انتباهي اليوم بكلمة واحدة:' : 'Describe my attention today in one word:';
  String get hofQ7Hint       => _ar ? 'كلمة واحدة عن تركيزك...' : 'One word focus...';
  String get hofQ8           => _ar ? 'ما الذي سأفعله غداً لتحسين انتباهي؟' : 'What will I do tomorrow to improve my attention?';
  String get hofQ8Hint       => _ar ? 'خطة تحسيني...'           : 'My improvement plan...';

  // ── Mental Distraction Form ───────────────────────────────────────────────────
  String get mdIntroTitle    => _ar ? 'تقييم\nالشرود الذهني'             : 'MENTAL DISTRACTION\nASSESSMENT';
  String get mdIntroBody     => _ar ? 'تتبع الشرود الذهني وحلله\nلبناء جدران تركيز أقوى.' : 'Track and analyze mental distractions to\nbuild stronger concentration walls.';
  String get mdSessionLabel  => _ar ? 'نبض الشرود'                       : 'DISTRACTION PULSE';
  String get mdRateQuestion  => _ar ? '⭐ قيّم مستوى شرودك اليوم:'        : '⭐ Rate your distraction level today:';
  String get mdRateHint      => _ar ? 'اضغط رقماً من ١ (تركيز عالٍ) إلى ٥ (شرود تام)' : 'Tap a number from 1 (very focused) to 5 (totally scattered)';
  String get mdR1Label       => _ar ? 'تركيز\nعالٍ'    : 'Very\nFocused';
  String get mdR2Label       => _ar ? 'شرود\nبسيط'     : 'Minimal\nDistraction';
  String get mdR3Label       => _ar ? 'متوسط'          : 'Moderate';
  String get mdR4Label       => _ar ? 'كثير\nمن الشرود' : 'Many\nDistractions';
  String get mdR5Label       => _ar ? 'شرود تام'       : 'Scattered';
  String get mdFeedback1     => _ar ? 'رائع! كنت في منطقة التركيز اليوم. لنكتشف ما أبقاك مركزاً.' : 'Great! You were in the zone today. Let\'s find out what kept you focused.';
  String get mdFeedback2     => _ar ? 'جيد. شرود بسيط لكنك بقيت على المسار.' : 'Pretty good. Minor distractions but you mostly stayed on track.';
  String get mdFeedback3     => _ar ? 'يوم مختلط — بعض التركيز وبعض الشرود. لنعرف ما الذي أبعدك.' : 'A mixed day — some focus, some drift. Let\'s figure out what pulled you away.';
  String get mdFeedback4     => _ar ? 'كان الشرود متكرراً اليوم. تحديده هو الخطوة الأولى للإصلاح.' : 'Distractions were frequent today. Identifying them is the first step to fixing it.';
  String get mdFeedback5     => _ar ? 'كان ذهنك منشغلاً. لا بأس — هذا التقييم سيساعدك على الفهم.' : "Your mind was all over the place. That's okay — this assessment will help you understand why.";
  String get mdQ1            => _ar ? 'ما الأشياء التي تشتت انتباهي؟'     : 'What things distract me?';
  String get mdQ1Hint        => _ar ? 'اذكر أبرز مصادر شرودك...'          : 'List your main distractions...';
  String get mdQ2            => _ar ? 'في أي أوقات يكون شرودي أكثر؟'      : 'What times am I most distracted?';
  String get mdQ2Hint        => _ar ? 'الصباح؟ المساء؟ بعد الغداء؟'        : 'Morning? Evening? After lunch?';
  String get mdQ3            => _ar ? 'من هم الأشخاص الذين يشتتون انتباهي؟' : 'Who are the people who distract me?';
  String get mdQ3Hint        => _ar ? 'الأصدقاء؟ الأسرة؟ الزملاء؟'          : 'Friends? Family? Colleagues?';
  String get mdQ4            => _ar ? 'ما الأفكار التي تتكرر في ذهني حين أشرد؟' : 'What thoughts most often recur in my mind when I am distracted?';
  String get mdQ4Hint        => _ar ? 'صف أفكارك المتكررة...'               : 'Describe your recurring thoughts...';
  String get mdQ5            => _ar ? 'ما الذي أردت التركيز عليه لكنني لم أستطع؟' : 'What did I want to focus on but couldn\'t?';
  String get mdQ5Hint        => _ar ? 'ما كان هدفك؟'                        : 'What was your goal?';
  String get mdQ6            => _ar ? 'ما المشاعر التي عشتها حين كنت شارداً؟' : 'What feelings did I experience when I was distracted?';
  String get mdQ6Hint        => _ar ? 'مثال: قلق، ملل، انزعاج، توتر، إثارة مفاجئة، خوف، تفكير مفرط' : 'Example: anxiety, boredom, annoyance, tension, sudden excitement, fear, overthinking';
  String get mdQ7            => _ar ? 'ما السلوك الذي أظهرته بسبب الشرود؟' : 'What behavior did I exhibit because of the distraction?';
  String get mdQ7Hint        => _ar ? 'مثال: أمسكت هاتفي، توقفت عن الدراسة، حلمت يقظاً، غيّرت مهمتي فجأة' : 'Example: I picked up my phone, stopped studying, daydreamed, suddenly changed my task';
  String get mdQ8            => _ar ? 'ما الذي ساعدني على استعادة التركيز؟' : 'What helped me refocus?';
  String get mdQ8Hint        => _ar ? 'كيف عدت إلى منطقة التركيز؟'          : 'How did you get back in the zone?';
  String get mdQ9            => _ar ? 'خطتي لتحسين التركيز في اليوم التالي:' : 'My plan to improve focus for the next day:';
  String get mdQ9Hint        => _ar ? 'ما الذي ستغيره غداً؟'                : 'What will you change tomorrow?';
  String get mdQ10           => _ar ? 'جملة أكتبها لتشجيع نفسي على التركيز:' : 'A sentence I write to encourage myself to focus:';
  String get mdQ10Hint       => _ar ? 'اكتب جملتك القوية...'                : 'Write your power sentence...';

  // ── Todo List ─────────────────────────────────────────────────────────────────
  String get dailyFlow         => _ar ? 'التدفق اليومي'                      : 'Daily Flow';
  String get dailyFlowSubtitle => _ar ? 'صمّم يومك، اعثر على تركيزك'         : 'Design your day, find your focus';
  String get noTasksYet        => _ar ? 'لا مهام بعد.\nاضغط + لإضافة أول مهمة.' : 'No tasks yet.\nTap + to add your first flow.';
  String get deleteTask        => _ar ? 'حذف المهمة؟'                        : 'Delete Task?';
  String get deletedMsg        => _ar ? 'ستُحذف نهائياً.'                    : 'will be permanently removed.';
  String get cancel            => _ar ? 'إلغاء'                              : 'Cancel';
  String get delete            => _ar ? 'حذف'                               : 'Delete';
  String get stepHint          => _ar ? 'وصف الخطوة...'                      : 'Step description...';
  String get addStep           => _ar ? 'إضافة وصف / خطوة'                   : 'ADD DESCRIPTION/STEP';
  String get newFlowTask       => _ar ? 'مهمة تدفق جديدة'                    : 'New Flow Task';
  String get mainTaskTitle     => _ar ? 'عنوان المهمة الرئيسي'               : 'MAIN TASK TITLE';
  String get taskTitleHint     => _ar ? 'مثال: التركيز على المشروع المهم'     : 'e.g., Critical Project Focus';
  String get targetTime        => _ar ? 'الوقت المستهدف'                     : 'TARGET TIME';
  String get addToFlow         => _ar ? 'أضف للتدفق'                         : 'Add to Flow';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension AppLocalizationsExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
