# Build Instructions

This document explains how to build Structurizr Lite with the C4 Framework auto-injection feature.

## Prerequisites

- Java 17 or later (Java 21 recommended for Docker)
- Git (for cloning the structurizr-ui repository)
- Docker (optional, for containerized deployment)

## Automated UI Build Process

The build process now **automatically** handles UI asset preparation. You no longer need to run `ui.sh` manually!

### How It Works

The Gradle build automatically:
1. Clones the `structurizr-ui` repository (if not present) to `../structurizr-ui`
2. Updates the repository (if it exists) with `git pull`
3. Copies UI assets (JS, CSS, images, JSP files) into the project
4. Builds the WAR file with all assets included

This happens automatically when you run `./gradlew build` or `./gradlew bootWar`.

## Building Locally

### Standard Build

Simply run:

```bash
./gradlew clean build
```

This will:
- Clone/update the structurizr-ui repository automatically
- Copy all UI assets into the project
- Compile the Java code
- Run tests
- Create the WAR file in `build/libs/structurizr-lite.war`

### Build Without Tests

```bash
./gradlew clean build -x test
```

### Build Options

#### Custom structurizr-ui Location

If you want to use a different location for the structurizr-ui repository:

```bash
./gradlew clean build -PstructurizrUiDir=/path/to/structurizr-ui
```

#### Skip UI Sync

If you already have UI assets and want to skip the sync process:

```bash
./gradlew clean build -PskipUiSync=true
```

This is useful for:
- Offline builds
- CI/CD environments where UI assets are pre-populated
- Faster incremental builds when UI hasn't changed

#### Pin to Specific UI Version

To use a specific version/tag/branch of structurizr-ui:

```bash
./gradlew clean build -PstructurizrUiRef=v2.4.0
```

#### Add Build Number to JS Files

To add a build number suffix to JavaScript files (for cache busting):

```bash
./gradlew clean build -PstructurizrBuildNumber=123
```

This will rename `structurizr*.js` files to `structurizr*-123.js` (except `structurizr-embed.js`).

## Building Docker Image

### Standard Docker Build

```bash
# Build the project
./gradlew clean build

# Build Docker image
docker build -t structurizr-lite-c4framework:latest .
```

### Run Docker Container

```bash
docker run -d \
  -p 8080:8080 \
  -v $(pwd)/workspace:/usr/local/structurizr \
  --name structurizr-c4 \
  structurizr-lite-c4framework:latest
```

Access the application at: http://localhost:8080

### Docker Build with Custom Image Name

```bash
docker build -t my-custom-structurizr:latest .
docker run -d -p 8080:8080 -v $(pwd)/workspace:/usr/local/structurizr --name my-structurizr my-custom-structurizr:latest
```

## Running Locally (Without Docker)

```bash
./gradlew bootRun
```

Access the application at: http://localhost:8080

## Troubleshooting

### Issue: Git not found

**Error:** `git: command not found` or similar

**Solution:** Install Git on your system:
- **Windows:** Download from https://git-scm.com/download/win
- **macOS:** `brew install git` or install Xcode Command Line Tools
- **Linux:** `sudo apt-get install git` (Debian/Ubuntu) or `sudo yum install git` (RHEL/CentOS)

Alternatively, manually clone the structurizr-ui repository and specify its location:

```bash
git clone https://github.com/structurizr/ui.git ../structurizr-ui
./gradlew clean build -PstructurizrUiDir=../structurizr-ui
```

### Issue: structurizr-ui repository not found

**Error:** `structurizr-ui repository not found or has unexpected structure`

**Solution:** The build will automatically clone it, but if you encounter issues:

```bash
# Clone manually to the default location
cd ..
git clone https://github.com/structurizr/ui.git structurizr-ui
cd structurizer-lite
./gradlew clean build
```

Or specify a custom location:

```bash
./gradlew clean build -PstructurizrUiDir=/path/to/structurizr-ui
```

### Issue: Build fails with "Illegal null value"

**Error:** `Illegal null value provided in this collection`

**Solution:** This is fixed in the latest version. Make sure you have the latest `build.gradle` from the repository.

### Issue: UI assets not updating

**Problem:** Changes in structurizr-ui are not reflected in the build

**Solution:** Clean the build and force UI sync:

```bash
./gradlew clean cleanUiStatic prepareUi build
```

Or delete the UI assets manually:

```bash
rm -rf src/main/resources/static/static/*
rm -rf src/main/webapp/WEB-INF/jsp/*
rm -rf src/main/webapp/WEB-INF/fragments/*
./gradlew clean build
```

### Issue: Permission denied on ui.sh

**Problem:** The old `ui.sh` script shows permission errors

**Solution:** You don't need `ui.sh` anymore! The build process is now automated in Gradle. Just run:

```bash
./gradlew clean build
```

## Gradle Tasks Reference

### UI-Related Tasks

- `ensureStructurizrUiRepo` - Clones structurizr-ui if it doesn't exist
- `updateStructurizrUiRepo` - Updates structurizr-ui with git pull
- `checkoutStructurizrUiRef` - Checks out a specific ref (if specified)
- `cleanUiStatic` - Removes old UI assets
- `prepareUi` - Copies UI assets from structurizr-ui to the project

### Standard Gradle Tasks

- `clean` - Removes build directory
- `build` - Builds the project (includes `prepareUi`)
- `bootWar` - Creates the WAR file (includes `prepareUi`)
- `bootRun` - Runs the application locally
- `test` - Runs unit tests
- `integrationTest` - Runs integration tests

## CI/CD Integration

For CI/CD pipelines, you have several options:

### Option 1: Let CI clone structurizr-ui

```bash
./gradlew clean build
```

This works if your CI environment has git and internet access.

### Option 2: Pre-populate UI assets

```bash
# In your CI setup script
git clone https://github.com/structurizr/ui.git ../structurizr-ui

# In your build script
./gradlew clean build
```

### Option 3: Skip UI sync (if assets are cached)

```bash
./gradlew clean build -PskipUiSync=true
```

This is useful if you cache the `src/main/resources/static/static/` and `src/main/webapp/WEB-INF/` directories between builds.

## Development Workflow

### First Time Setup

```bash
git clone https://github.com/victor-lby/structurizer-lite.git
cd structurizer-lite
./gradlew clean build
```

The build will automatically clone structurizr-ui and set everything up.

### Regular Development

```bash
# Make your changes to Java code
./gradlew build

# Run locally to test
./gradlew bootRun
```

### Updating UI Assets

```bash
# Pull latest UI changes
cd ../structurizr-ui
git pull

# Rebuild
cd ../structurizer-lite
./gradlew clean build
```

Or force a clean UI sync:

```bash
./gradlew cleanUiStatic prepareUi build
```

## Legacy ui.sh Script

The `ui.sh` script is now **deprecated** and no longer needed. The build process is fully automated in Gradle.

If you have been using `ui.sh`, you can now simply run:

```bash
./gradlew clean build
```

The Gradle build will handle everything that `ui.sh` used to do, and it works cross-platform (Windows, macOS, Linux).

## Additional Resources

- [C4 Framework Update Guide](C4_FRAMEWORK_UPDATE_GUIDE.md) - How to add new C4 Framework archetypes
- [Structurizr Documentation](https://structurizr.com/) - Official Structurizr documentation
- [C4 Model](https://c4model.com/) - C4 architecture model documentation
