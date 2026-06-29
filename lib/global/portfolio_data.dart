import 'package:flutter/material.dart';

/// A single project shipped within a role.
class ProjectItem {
  final String name;
  final String domain;
  final String highlight;
  final List<String> bullets;
  const ProjectItem({
    required this.name,
    required this.domain,
    required this.highlight,
    required this.bullets,
  });
}

/// A role at a company, containing one or more projects.
class ExperienceItem {
  final String company;
  final String role;
  final String period;
  final String? logo;
  final List<ProjectItem> projects;
  const ExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    this.logo,
    required this.projects,
  });
}

class StrengthItem {
  final IconData icon;
  final String title;
  final String description;
  const StrengthItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class SkillCategory {
  final String title;
  final List<String> items;
  const SkillCategory({required this.title, required this.items});
}

class PortfolioData {
  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      company: "Eggstech",
      role: "Lead Mobile / Mobile Developer",
      period: "May 2025 — Present",
      projects: [
        ProjectItem(
          name: "Rocky App",
          domain: "B2B E-commerce · Lead Mobile",
          highlight: "Manual order steps 8 → 3 (~60% ↓)",
          bullets: [
            "Architected a multi-layered Clean Architecture foundation with independent feature modules — cut feature delivery time by ~30%.",
            "Engineered real-time chat via WebSocket with ChatGPT AI-driven order automation — manual processing from 8 → 3 steps.",
            "Developed a custom Kotlin MethodChannel for QR code generation and real-time payment sync.",
            "Implemented FCM + deep-linking to boost re-engagement through targeted push campaigns.",
            "Orchestrated hybrid Provider + GetX state management.",
          ],
        ),
        ProjectItem(
          name: "Truyền thuyết Champong",
          domain: "F&B Chain Application",
          highlight: "Image load 1.2s → 0.3s · storage −35%",
          bullets: [
            "Engineered a real-time customer-support module using SignalR (text, image and audio messages).",
            "Implemented automatic nearest-branch selection for faster delivery and better food quality.",
            "Built native Kotlin QR caching — storage reduced 35%, image load from 1.2s → 0.3s.",
            "Used Stream-based techniques to update the UI across multiple screens simultaneously.",
            "Orchestrated hybrid Bloc/Cubit + GetX state management.",
          ],
        ),
        ProjectItem(
          name: "RFID Scanner",
          domain: "Enterprise Inventory Management",
          highlight: "Scan cycle 3s → 0.8s · memory −45%",
          bullets: [
            "Developed a MethodChannel bridge for handheld RFID scanner SDKs — <50ms Flutter-to-native response.",
            "Built data-chunking algorithms processing 10,000+ items/session — memory reduced ~45%.",
            "Designed EPC scanning + native audio feedback — scan cycle 3s → 0.8s, throughput up ~25%.",
            "Built silent in-app auto-update (no manual installation required).",
            "Established the base MVVM architecture with Provider + GetX.",
          ],
        ),
      ],
    ),
    ExperienceItem(
      company: "ECR Vietnam",
      role: "Mobile Developer",
      period: "Feb 2024 — Apr 2025",
      projects: [
        ProjectItem(
          name: "Rail Pro App",
          domain: "Point-of-Sale System",
          highlight: "60 FPS · load 8s → 2.5s · 100% uptime",
          bullets: [
            "Architected a bidirectional offline-sync engine (Hive/Floor) ensuring 100% POS uptime, auto-syncing transactions once the connection is restored.",
            "Integrated the PAX payment SDK via MethodChannel — secure credit, debit and e-wallet transactions.",
            "Maintained 60 FPS for 5,000+ product catalogs — initial load from 8s → 2.5s via lazy loading and widget caching.",
          ],
        ),
        ProjectItem(
          name: "IMPL App",
          domain: "Logistics & Delivery (Singapore)",
          highlight: "99.9% crash-free · manual entry −70%",
          bullets: [
            "Developed Kotlin plugins for OCR parcel scanning — manual entry reduced ~70%, processing 300+ parcels/day.",
            "Engineered a dynamic UI rendering engine with 3 runtime-switchable languages (VI, EN, ID) — zero restart required.",
            "Achieved 99.9% crash-free via Sentry monitoring — resolution time from 48h → 6h with structured triage.",
          ],
        ),
      ],
    ),
    ExperienceItem(
      company: "EcarAid",
      role: "Flutter Developer",
      period: "Jun 2022 — Jan 2024",
      projects: [
        ProjectItem(
          name: "eCa App",
          domain: "Automotive Community & Roadside Rescue",
          highlight: "50+ active car-owner communities",
          bullets: [
            "Engineered location services via Google Maps API (autocomplete, markers, polylines).",
            "Architected a booking system for 3 service types with real-time FCM updates.",
            "Built real-time group chat with multimedia support across 50+ active communities.",
            "Managed CI/CD via App Center with consistent bi-weekly deployments; contributed UI/UX, QA and API validation.",
          ],
        ),
      ],
    ),
  ];

  static const List<StrengthItem> strengths = [
    StrengthItem(
      icon: Icons.architecture_rounded,
      title: "Legacy Modernization",
      description:
          "Refactored monolithic codebases to modular Clean Architecture — reducing build times ~40% and enabling parallel team development.",
    ),
    StrengthItem(
      icon: Icons.memory_rounded,
      title: "Hardware Integration Expert",
      description:
          "Deep experience bridging Flutter with native hardware SDKs — RFID scanners, PAX terminals and thermal printers — via Platform Channels.",
    ),
    StrengthItem(
      icon: Icons.speed_rounded,
      title: "Performance-Obsessed",
      description:
          "Consistently delivering 60 FPS UIs, reducing screen load times by 50–70%, and optimizing memory across diverse device profiles.",
    ),
    StrengthItem(
      icon: Icons.all_inclusive_rounded,
      title: "End-to-End Ownership",
      description:
          "Leading mobile features from architecture through deployment, monitoring and iterating based on production metrics.",
    ),
  ];

  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: "Mobile Frameworks",
      items: ["Flutter (Expert · 3+ yrs)", "Android Native", "Kotlin", "Java"],
    ),
    SkillCategory(
      title: "Architecture",
      items: ["Clean Architecture", "SOLID Principles", "MVVM", "MVC"],
    ),
    SkillCategory(
      title: "State Management",
      items: ["Bloc / Cubit", "GetX", "Provider"],
    ),
    SkillCategory(
      title: "Real-time & APIs",
      items: ["WebSocket", "SignalR", "Socket.IO", "REST (Dio, Retrofit)"],
    ),
    SkillCategory(
      title: "CI/CD & Source Control",
      items: [
        "GitHub Actions",
        "Fastlane",
        "FVM",
        "GitHub / GitLab",
        "Bitbucket",
        "Jira",
      ],
    ),
    SkillCategory(
      title: "Databases",
      items: ["Hive", "SQLite", "SharedPreferences", "Secure Storage"],
    ),
    SkillCategory(
      title: "Additional",
      items: [
        "Sentry",
        "Firebase",
        "Unit / Widget / Integration Testing",
        "App Center",
        "Figma",
        "Lottie",
        "Rive",
      ],
    ),
  ];
}
