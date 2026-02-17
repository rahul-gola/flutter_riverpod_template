0.0.4

- feat: overhauled splash screen with new animations and branding
- feat: implemented CI/CD workflow with GitHub Actions for Android builds and releases
- feat: added proguard rules for Android release builds
- refactor: enhanced API error handling with detailed exception mapping and logging
- refactor: updated UI colors and themes across the app
- refactor: modernized iOS project structure with SceneDelegate
- refactor: converted home view model state to a private part file
- chore: upgraded Flutter SDK, Android Gradle Plugin, and numerous dependencies
- chore: updated and streamlined linter rules across all modules
- fix: corrected API call wrapper to properly handle async operations
- fix: removed obsolete `TextView` widget and iOS launch screen assets
- style: improved code formatting and documentation in multiple files

0.0.3

- refactor: enhanced BaseStatefulWidget with generic state support for better type safety
- fix: resolved state selection issues in HomeScreen
- refactor: updated base architecture components

0.0.2

- feat: migrated Android build system from Groovy to Kotlin DSL
- feat: added core architecture with base classes (BaseWidget, BasePage, BaseViewModel,
  BasePageState)
- feat: implemented home screen with view model using Riverpod
- feat: added MyApp widget with proper app structure
- feat: restructured error handling entities and improved error management
- feat: moved utility functions to better organized structure
- feat: updated analysis options and linting rules
- feat: enhanced dependency injection setup
- feat: added iOS and web platform support
- refactor: improved project structure and organization
- refactor: updated dependencies and package configurations

0.0.1

- feat: initial commit
