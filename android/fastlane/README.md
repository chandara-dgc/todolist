fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android validate_key

```sh
[bundle exec] fastlane android validate_key
```

Validate Google Play Store JSON key

### android increment_version

```sh
[bundle exec] fastlane android increment_version
```

Increment the version code and version name

### android deploy_create

```sh
[bundle exec] fastlane android deploy_create
```

Deploy a new version to the Google Play Console

### android bump_version_code

```sh
[bundle exec] fastlane android bump_version_code
```

Bump version code

### android bump_version_name

```sh
[bundle exec] fastlane android bump_version_name
```

Bump version name

### android generate_changelog

```sh
[bundle exec] fastlane android generate_changelog
```

Generate changelog

### android firebase_distribution

```sh
[bundle exec] fastlane android firebase_distribution
```

Deploy to Firebase App Distribution

### android deploy_staging

```sh
[bundle exec] fastlane android deploy_staging
```

Deploy staging build

### android deploy_production

```sh
[bundle exec] fastlane android deploy_production
```

Deploy production build

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
