/// All portfolio content, transcribed from the CV.
///
/// Pure Dart — no Flutter imports — so it stays testable without a widget
/// binding and can be swapped for a CMS-backed source later.
library;

enum ProjectCategory {
  /// Shipped to the public app stores.
  production,

  /// Internal or B2B tooling, not publicly listed.
  enterprise,
}

extension ProjectCategoryLabel on ProjectCategory {
  String get label => switch (this) {
        ProjectCategory.production => 'PRODUCTION',
        ProjectCategory.enterprise => 'ENTERPRISE',
      };

  String get filterLabel => switch (this) {
        ProjectCategory.production => 'Production',
        ProjectCategory.enterprise => 'Enterprise',
      };
}

class ProjectItem {
  final String id;
  final String name;
  final String domain;
  final String company;
  final String? role;
  final String period;
  final String teamSize;
  final ProjectCategory category;

  /// The headline metric shown on the card.
  final String impact;

  /// One-line description used at the top of the detail overlay.
  final String summary;

  final List<String> bullets;
  final List<String> tech;

  final String? playStoreUrl;
  final String? appStoreUrl;

  /// Screenshot for the card cover. Null today — cards fall back to a
  /// typographic cover until real screenshots are supplied.
  final String? coverAsset;

  const ProjectItem({
    required this.id,
    required this.name,
    required this.domain,
    required this.company,
    required this.period,
    required this.teamSize,
    required this.category,
    required this.impact,
    required this.summary,
    required this.bullets,
    required this.tech,
    this.role,
    this.playStoreUrl,
    this.appStoreUrl,
    this.coverAsset,
  });

  bool get hasStoreLinks => playStoreUrl != null || appStoreUrl != null;
}

class ExpertiseItem {
  final String title;
  final String description;
  const ExpertiseItem({required this.title, required this.description});
}

class StackGroup {
  final String title;
  final List<String> items;
  const StackGroup({required this.title, required this.items});
}

class ExperienceItem {
  final String company;
  final String role;
  final String period;
  final String? logoAsset;
  final List<String> projectIds;
  const ExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    required this.projectIds,
    this.logoAsset,
  });
}

class Profile {
  /// Hero wordmark, first line half — rendered as outline.
  final String heroOutline;

  /// Hero wordmark, solid half.
  final String heroSolid;

  /// The full legal name, used where the wordmark is not.
  final String fullName;

  final String title;
  final String tagline;
  final String summary;
  final String email;
  final String phone;
  final String location;
  final String github;
  final String linkedin;
  final int yearsExperience;

  const Profile({
    required this.heroOutline,
    required this.heroSolid,
    required this.fullName,
    required this.title,
    required this.tagline,
    required this.summary,
    required this.email,
    required this.phone,
    required this.location,
    required this.github,
    required this.linkedin,
    required this.yearsExperience,
  });
}

class PortfolioData {
  const PortfolioData._();

  static const Profile profile = Profile(
    heroOutline: 'DUY',
    heroSolid: 'KHANG',
    fullName: 'Huynh Duy Khang',
    title: 'Mobile Engineer',
    tagline: 'Flutter Expert · 4 years · 6+ production apps shipped',
    summary:
        'Results-driven mobile engineer with 4 years of experience shipping 6+ '
        'production apps across Flutter and Android Native. Specialised in Clean '
        'Architecture, real-time systems and hardware SDK integrations.',
    email: 'huynhduykhang2001gv@gmail.com',
    phone: '(+84) 762 449 965',
    location: 'Ho Chi Minh City, Vietnam',
    github: 'https://github.com/DuyKhangIT',
    linkedin: 'https://linkedin.com/in/khang-huynh-15b0b1248/',
    yearsExperience: 4,
  );

  static const List<ProjectItem> projects = [
    ProjectItem(
      id: 'rocky-app',
      name: 'Rocky App',
      domain: 'B2B E-commerce Platform',
      company: 'Eggstech',
      role: 'Lead Mobile',
      period: 'May 2025 — Present',
      teamSize: '10 · 1 Lead Mobile, 2 Mobile, 3 BE, 2 Web, 1 QC, 1 PM',
      category: ProjectCategory.production,
      impact: 'Feature delivery ~30% faster',
      summary:
          'A B2B commerce platform where wholesale buyers order at scale, led on '
          'the mobile side from architecture through release.',
      bullets: [
        'Architected a multi-layered Clean Architecture foundation with independent feature modules — reduced feature delivery time by ~30% through modular separation.',
        'Developed a custom Kotlin MethodChannel for QR code generation and real-time payment sync.',
        'Implemented FCM and deep-linking strategies to improve user re-engagement through targeted push notification campaigns.',
        'Configured SignalR event listeners to force-logout users in real time — enforcing server-driven session control across devices.',
        'Orchestrated hybrid Provider + GetX state management.',
        'Integrated Sentry for real-time crash and performance monitoring, enabling proactive issue detection and faster resolution across the app.',
      ],
      tech: [
        'Flutter',
        'Kotlin',
        'MethodChannel',
        'SignalR',
        'FCM',
        'Provider',
        'GetX',
        'Sentry',
        'Clean Architecture',
      ],
    ),
    ProjectItem(
      id: 'champong',
      name: 'Truyền thuyết Champong',
      domain: 'F&B Chain Application',
      company: 'Eggstech',
      period: 'May 2025 — Present',
      teamSize: '7 · 1 Mobile, 2 BE, 2 Web, 1 QC, 1 PM',
      category: ProjectCategory.production,
      impact: 'Image load 1.2s → 0.3s · storage −35%',
      summary:
          'Ordering and loyalty app for a restaurant chain, with live customer '
          'support and branch-aware delivery.',
      bullets: [
        'Engineered a real-time customer support module using SignalR, enabling seamless delivery of text, image and audio messages.',
        'Implemented automatic nearest-branch selection to enhance the ordering experience, ensuring faster delivery times and better food quality.',
        'Engineered native Kotlin QR caching — storage reduced by 35%, image load from 1.2s to 0.3s.',
        'Used Stream-based techniques to update the UI across multiple screens simultaneously.',
        'Integrated Facebook, TikTok and Google Ads SDKs for install attribution — recording app-install events triggered by ad clicks across all three platforms.',
        'Engineered an auto-retry mechanism with randomised backoff (up to 3 attempts) for failed API calls — improving resilience on unstable networks.',
        'Customised push notification sounds for both foreground and background states to strengthen alert visibility.',
        'Orchestrated hybrid Bloc/Cubit + GetX state management.',
        'Integrated Firebase Crashlytics for real-time crash reporting and monitoring.',
      ],
      tech: [
        'Flutter',
        'Kotlin',
        'SignalR',
        'Bloc/Cubit',
        'GetX',
        'Firebase Crashlytics',
        'Ads SDKs',
      ],
    ),
    ProjectItem(
      id: 'rfid-scanner',
      name: 'RFID Scanner',
      domain: 'Enterprise Inventory Management',
      company: 'Eggstech',
      period: 'May 2025 — Present',
      teamSize: '9 · 1 Mobile, 3 BE, 2 Web, 1 QC, 1 PM, 1 BA',
      category: ProjectCategory.enterprise,
      impact: 'Scan cycle 3s → 0.8s · memory −45%',
      summary:
          'Handheld inventory tooling that drives RFID hardware directly from '
          'Flutter through a native bridge.',
      bullets: [
        'Developed a MethodChannel bridge for handheld RFID scanner SDKs — under 50ms Flutter-to-native response time.',
        'Built data-chunking algorithms processing 10,000+ items per session — memory reduced by ~45% versus full-dataset loading.',
        'Designed EPC scanning with native audio feedback — scan cycle from 3s to 0.8s, operator throughput up ~25%.',
        'Built a feature that automatically updates the app to the latest version without requiring manual installation.',
        'Implemented structured error logging — persisting logs to the local device and syncing them to the backend for centralised diagnostics.',
        'Built the base project architecture using the MVVM pattern and managed state with Provider + GetX.',
      ],
      tech: [
        'Flutter',
        'Kotlin',
        'MethodChannel',
        'RFID SDK',
        'MVVM',
        'Provider',
        'GetX',
      ],
    ),
    ProjectItem(
      id: 'rail-pro',
      name: 'Rail Pro App',
      domain: 'Point-of-Sale System',
      company: 'ECR Vietnam',
      period: 'Feb 2024 — Apr 2025',
      teamSize:
          '14 · 2 Mobile, 1 Lead Mobile, 1 Lead BE, 4 BE, 2 Web, 1 Lead QC, 2 QC, 1 PM',
      category: ProjectCategory.enterprise,
      impact: '60 FPS · load 8s → 2.5s · 100% uptime',
      summary:
          'A point-of-sale terminal app that keeps selling when the network '
          'drops, backed by an offline-first sync engine.',
      bullets: [
        'Architected a bidirectional offline-sync engine (Hive/Floor) ensuring 100% POS uptime — automatically synchronising transactions daily once the connection is restored.',
        'Built PAX payment SDK integration via MethodChannel — secure credit, debit and e-wallet transactions.',
        'Maintained 60 FPS for 5,000+ product catalogs — initial load from 8s to 2.5s via lazy loading and widget caching.',
      ],
      tech: [
        'Flutter',
        'Hive',
        'Floor',
        'PAX SDK',
        'MethodChannel',
        'Offline sync',
      ],
    ),
    ProjectItem(
      id: 'impl',
      name: 'IMPL App',
      domain: 'Logistics & Delivery · Singapore',
      company: 'ECR Vietnam',
      period: 'Feb 2024 — Apr 2025',
      teamSize: '9 · 1 Mobile, 3 BE, 2 Web, 2 QC, 1 PM',
      category: ProjectCategory.enterprise,
      impact: '99.9% crash-free · manual entry −70%',
      summary:
          'Parcel handling for a Singapore logistics operator, with on-device '
          'OCR and runtime-switchable languages.',
      bullets: [
        'Developed Kotlin plugins for OCR parcel scanning — manual entry reduced by ~70%, processing 300+ parcels per day.',
        'Engineered a dynamic UI rendering engine with 3 runtime-switchable languages (VI, EN, ID) — zero restart required.',
        'Achieved 99.9% crash-free sessions via Sentry monitoring — resolution time from 48h to 6h with structured triage.',
      ],
      tech: ['Flutter', 'Kotlin', 'OCR', 'Sentry', 'Dynamic i18n'],
    ),
    ProjectItem(
      id: 'eca',
      name: 'eCa App',
      domain: 'Automotive Community & Roadside Rescue',
      company: 'EcarAid',
      period: 'Jun 2022 — Jan 2024',
      teamSize: '10 · 2 Mobile, 1 Lead Mobile, 1 Lead BE, 2 BE, 2 Web, 1 QC, 1 PM',
      category: ProjectCategory.production,
      impact: '50+ active communities',
      summary:
          'A community and roadside-rescue platform for car owners, combining '
          'live location, bookings and group chat.',
      bullets: [
        'Engineered location services via the Google Maps API (autocomplete, markers, polylines).',
        'Architected a booking system for 3 service types with real-time FCM updates.',
        'Built real-time group chat with multimedia support across 50+ active car owner communities.',
        'Managed CI/CD via App Center with consistent bi-weekly deployments; contributed UI/UX collaboration, QA and API validation.',
      ],
      tech: [
        'Flutter',
        'Google Maps API',
        'FCM',
        'App Center',
        'Real-time chat',
      ],
    ),
  ];

  static const List<ExpertiseItem> expertise = [
    ExpertiseItem(
      title: 'Legacy Modernization',
      description:
          'Refactored monolithic codebases to modular Clean Architecture, reducing build times by ~40% and enabling parallel team development.',
    ),
    ExpertiseItem(
      title: 'Hardware Integration',
      description:
          'Deep experience bridging Flutter with native hardware SDKs — RFID scanners, PAX terminals and thermal printers — via Platform Channels.',
    ),
    ExpertiseItem(
      title: 'Performance Obsessed',
      description:
          'Consistently delivering 60 FPS UIs, reducing screen load times by 50–70%, and optimising memory across diverse device profiles.',
    ),
    ExpertiseItem(
      title: 'End-to-End Ownership',
      description:
          'Leading mobile features from architecture through deployment, monitoring, and iterating based on production metrics.',
    ),
  ];

  static const List<StackGroup> stack = [
    StackGroup(
      title: 'Mobile Frameworks',
      items: ['Flutter (Expert · 4 yrs)', 'Android Native', 'Kotlin', 'Java'],
    ),
    StackGroup(
      title: 'Architecture',
      items: ['Clean Architecture', 'SOLID Principles', 'MVVM'],
    ),
    StackGroup(
      title: 'State Management',
      items: ['Bloc / Cubit (Advanced)', 'GetX', 'Provider'],
    ),
    StackGroup(
      title: 'Real-time & APIs',
      items: ['WebSocket', 'SignalR', 'Socket.IO', 'REST (Dio, Retrofit)'],
    ),
    StackGroup(
      title: 'CI/CD & Source Control',
      items: [
        'GitHub Actions',
        'Fastlane',
        'FVM',
        'GitHub / GitLab',
        'Bitbucket',
        'Jira',
      ],
    ),
    StackGroup(
      title: 'Databases',
      items: ['Hive', 'SQLite', 'SharedPreferences', 'Secure Storage'],
    ),
    StackGroup(
      title: 'Additional',
      items: [
        'Sentry',
        'Firebase',
        'Unit / Widget / Integration Testing',
        'App Center',
        'Figma',
        'Lottie',
        'Rive',
      ],
    ),
  ];

  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      company: 'Eggstech',
      role: 'Lead Mobile / Mobile Developer',
      period: 'May 2025 — Present',
      projectIds: ['rocky-app', 'champong', 'rfid-scanner'],
    ),
    ExperienceItem(
      company: 'ECR Vietnam',
      role: 'Mobile Developer',
      period: 'Feb 2024 — Apr 2025',
      logoAsset: 'assets/images/png/ic_ecr.png',
      projectIds: ['rail-pro', 'impl'],
    ),
    ExperienceItem(
      company: 'EcarAid',
      role: 'Flutter Developer',
      period: 'Jun 2022 — Jan 2024',
      logoAsset: 'assets/images/png/ic_ecaraid.png',
      projectIds: ['eca'],
    ),
  ];

  static ProjectItem projectById(String id) =>
      projects.firstWhere((p) => p.id == id);
}
