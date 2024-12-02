# This project is discontinued.

We recommend to use [Ghostery Tracker and Ad Blocker](https://www.ghostery.com/ghostery-ad-blocker) in [Firefox](https://play.google.com/store/apps/details?id=org.mozilla.firefox&hl=pl&gl=US&pli=1).

---

# Ghostery Browser for Android

This is the next generation Ghostery Browser for Android based on Firefox Fenix.

The project uses a specific tag of the upstream Fenix project as a submodule and then applies a set of patches to add the Ghostery extension and branding.

## Build Instructions

Note: Both Android SDK and NDK are required.

  ```shell
  # Checkout the repo
  git clone https://github.com/ghostery/user-agent-android
  # Pull Fenix code
  git submodule init
  git submodule update --force
  # Apply patches
  ./import.sh
  # the browser directory contains the app project
  cd browser/
  ./gradlew clean app:assembleGhostery
  ```

## Dev workflow

We use git to import and export patches. Having initially imported patches via `import.sh` you can modify and edit patches in the browser folder.
Once finished, you can export your changes with the following command:

```bash
cd browser/
git format-patch ${TAG} --minimal --no-numbered --keep-subject --output-directory ../patches/
```

Where `${TAG}` is a ref to the tip of the Fenix branch you originally applied the patches onto. The command will update the patches in the `patches` folder
to match your git commit history.

### Merging upstream

To update the browser to a newer version of Fenix, first update the Fenix submodule branch, then apply and fix the patches.

To update Fenix version:
* change `FENIX_TAG` in `./config.sh`
* change `.gitmodule` to specify new version
* `git submodule sync --recursive`
* `git submodule foreach --recursive git fetch`
* `git submodule update --init --recursive`
* in browser folder `git checkout TAG`
* commit changes
