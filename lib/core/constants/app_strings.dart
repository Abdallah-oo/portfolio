class AppStrings {
  AppStrings._();

  // ── Personal ─────────────────────────────────────────────────
  static const String name = 'Abdallah Ahmed';
  static const String role = 'Flutter Developer';
  static const String roleTag = '< Flutter Developer />';
  static const String email = 'abdallah81786417@gmail.com';
  static const String phone = '+201210075879';
  static const String location = 'Cairo, Egypt';
  static const String githubUrl = 'https://github.com/Abdallah-oo';
  static const String linkedinUrl = 'https://www.linkedin.com/in/abdallah-oo/';
  static const String cvLink =
      'https://drive.google.com/drive/folders/1VmPaF4XjhP-nrpnegGMP-ZudC14UAtFV?hl=ar';

  static const String summary =
      'Flutter Developer with 1+ year of experience building '
      'production-quality Android & iOS applications. Proficient in '
      'Clean Architecture, BLoC/Cubit, REST APIs, and Supabase.';

  // ── Hero typewriter phrases ───────────────────────────────────
  static const List<String> typewriterPhrases = [
    'Flutter Developer',
    'Mobile App Builder',
    'Clean Architecture Fan',
    'BLoC / Cubit Expert',
    'UI/UX Enthusiast',
  ];

  // ── Education ────────────────────────────────────────────────
  static const String university = 'Zagazig University';
  static const String degree = 'B.Sc. Computers & Information — IT';
  static const String gpa = 'GPA: 3.15 / 4.0 — Very Good';
  static const String eduPeriod = 'Sep 2021 – Sep 2025';
  static const String gradProject =
      'Graduation Project: Eco-Friendly Food Waste Tracker (Flutter) — Grade A+';

  // ── Projects ─────────────────────────────────────────────────
  static const List<Map<String, dynamic>> projects = [
    {
      'number': '01',
      'title': 'Chattr',
      'subtitle': 'Real-Time Chat Application',
      'year': '2026',
      'image': 'assets/images/projects_covers/Chat.jpg',
      'youtubeUrl': 'https://youtu.be/OTLd1MyU0y8',
      'githubUrl': 'https://github.com/Abdallah-oo/Chattr',
      'description':
          'Feature-First Clean Architecture chat app with live private & group '
          'messaging powered by Supabase Realtime. Supports voice messages, '
          'image sharing, offline caching (Hive), pagination, and role-based '
          'group management with optimistic UI updates.',
      'tech': ['Flutter', 'Supabase', 'BLoC/Cubit', 'Hive', 'Clean Arch'],
      'highlights': [
        'Real-time messaging with Supabase Realtime',
        'Offline-first with Hive caching',
        'Voice messages & image sharing',
        'Role-based group management',
      ],
    },
    {
      'number': '02',
      'title': 'Hungry Time',
      'subtitle': 'Food Delivery App',
      'year': '2026',
      'image': 'assets/images/projects_covers/Hungry.jpg',
      'youtubeUrl': 'https://youtu.be/ZyhmN2Mzk8k',
      'githubUrl': 'https://github.com/Abdallah-oo/hungry_time',
      'description':
          'End-to-end food ordering experience built with Clean Architecture '
          'and a reusable Dio-based API layer with JWT auth, interceptors, '
          'and centralized error handling.',
      'tech': ['Flutter', 'REST APIs', 'Dio', 'BLoC/Cubit', 'JWT'],
      'highlights': [
        'Dio API layer with JWT & interceptors',
        'Guest checkout & payment flow',
        'Meal customization & cart management',
        'Real-time order tracking',
      ],
    },
    {
      'number': '03',
      'title': 'Sooq',
      'subtitle': 'Grocery Shopping App',
      'year': '2025',
      'image': 'assets/images/projects_covers/Sooq.jpg',
      'youtubeUrl': 'https://youtu.be/cgoHK1NfNtM',
      'githubUrl': 'https://github.com/Abdallah-oo/sooq',
      'description':
          'Grocery shopping app with Clean Architecture, global BLoC state '
          'for cart & favorites, live search, category filtering, promo codes, '
          'image cropping, skeleton loading, and smooth page transitions.',
      'tech': ['Flutter', 'Supabase', 'BLoC/Cubit', 'Clean Arch'],
      'highlights': [
        'Live search & category filtering',
        'Global BLoC cart & favorites',
        'Promo codes & image cropping',
        'Skeleton loading & smooth transitions',
      ],
    },
    {
      'number': '04',
      'title': 'ToneDust',
      'subtitle': 'Music Player App',
      'year': '2025',
      'image': 'assets/images/projects_covers/ToneDust.jpg',
      'youtubeUrl': 'https://youtube.com/shorts/1zVvhi8nO0g?feature=share',
      'githubUrl': 'https://github.com/Abdallah-oo/music_app',
      'description':
          'Music player app focused on custom animations: playback-synced '
          'vinyl rotation, staggered transitions, animated auth flows, and '
          'a glassmorphism navigation UI.',
      'tech': ['Flutter', 'Supabase Auth', 'BLoC/Cubit', 'Animations'],
      'highlights': [
        'Playback-synced vinyl rotation animation',
        'Staggered & glassmorphism UI',
        'Animated authentication flows',
        'Custom navigation animations',
      ],
    },
    {
      'number': '05',
      'title': 'Cafe App',
      'subtitle': 'Flutter Drink Ordering App',
      'year': '2025',
      'image': 'assets/images/projects_covers/CafeApp.jpg',
      'youtubeUrl': 'https://youtube.com/shorts/TjaAW1uiXGE?feature=share',
      'githubUrl': 'https://github.com/Abdallah-oo/cafe_app',
      'description':
          'Production-quality drink ordering app built from scratch with no '
          'third-party UI kits. Features a fully custom design system, '
          'composite-key cart, real-time search & filter, and a glassmorphism '
          'checkout sheet.',
      'tech': ['Flutter', 'Provider', 'Custom Animations', 'Clean Arch'],
      'highlights': [
        'Composite-key cart (product + size) with live badge count',
        'Glassmorphism checkout sheet with DraggableScrollableSheet',
        'Staggered list entrance & Hero animations',
        'Real-time search + category filter in a single computed getter',
      ],
    },
    {
      'number': '06',
      'title': 'Runway',
      'subtitle': 'Fashion E-Commerce App',
      'year': '2025',
      'image': 'assets/images/projects_covers/Runway.jpg',
      'youtubeUrl': 'https://youtube.com/shorts/j9Pl-9rG5GE?feature=share',
      'githubUrl': 'https://github.com/Abdallah-oo/Runway',
      'description':
          'Sleek fashion shopping app with a full-screen video banner, '
          'parallax image carousel, DraggableScrollableSheet product details, '
          'complete checkout & order flow, and a dark-themed design system '
          'with gold accents powered by Supabase.',
      'tech': ['Flutter', 'Supabase', 'BLoC/Cubit', 'Clean Arch'],
      'highlights': [
        'Full-screen video banner & SVG splash animation',
        'Parallax carousel with color & size selectors',
        'Complete order flow: address, payment & confirmation',
        'Dark theme with gold accents & Playfair Display typography',
      ],
    },
    {
      'number': '07',
      'title': 'Fashion App',
      'subtitle': 'Full-Featured Fashion E-Commerce',
      'year': '2025',
      'image': 'assets/images/projects_covers/Fashion.jpg',
      'youtubeUrl': 'https://youtube.com/shorts/KuQkPCRzgSc?feature=share',
      'githubUrl': 'https://github.com/Abdallah-oo/fashion_app',
      'description':
          'Sleek fashion shopping app with complete onboarding, authentication, '
          'live product browsing from Supabase, and a full checkout flow including '
          'address & payment management. Dark-themed design with gold accents and '
          'Playfair Display typography.',
      'tech': ['Flutter', 'Supabase', 'BLoC/Cubit', 'Clean Arch'],
      'highlights': [
        'Complete auth flow: onboarding, login & sign-up via Supabase',
        'Full checkout: address, credit card & order confirmation',
        'Dark theme with gold accents & Playfair Display typography',
        'Custom snackbar system & responsive layout across all screen sizes',
      ],
    },
  ];
  // ── Skills ───────────────────────────────────────────────────
  static const List<Map<String, dynamic>> skillCategories = [
    {
      'category': 'Mobile',
      'icon': '📱',
      'skills': ['Flutter', 'Dart', 'Android', 'iOS', 'Responsive UI'],
    },
    {
      'category': 'State Management',
      'icon': '⚙️',
      'skills': ['BLoC / Cubit', 'Provider'],
    },
    {
      'category': 'Architecture',
      'icon': '🏛️',
      'skills': ['Clean Architecture', 'MVVM', 'SOLID', 'Repository Pattern'],
    },
    {
      'category': 'Backend & APIs',
      'icon': '🔌',
      'skills': ['REST APIs', 'Dio', 'Supabase', 'Firebase', 'Firebase FCM'],
    },
    {
      'category': 'Storage',
      'icon': '💾',
      'skills': ['Hive', 'Shared Preferences', 'Flutter Secure Storage'],
    },
    {
      'category': 'Tools',
      'icon': '🛠️',
      'skills': [
        'Git / GitHub',
        'Postman',
        'Figma',
        'GitHub Actions',
        'Fastlane',
      ],
    },
  ];
}
