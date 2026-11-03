# Homebrew tap for Meluli

[Meluli](https://github.com/rashi123123/meluli) is Hebrew dictation and transcription that runs on your Mac. Apple Silicon, macOS 13.3 or later.

```sh
brew install --cask rashi123123/meluli/meluli
```

The cask installs the signed, notarized DMG from the project's GitHub Releases, and checks its SHA-256. Meluli updates itself after that. `brew uninstall --zap --cask meluli` also deletes your history, models and settings.

A workflow here checks for a new release every day and moves the cask to it.

## התקנה בעברית

```sh
brew install --cask rashi123123/meluli/meluli
```

ה־cask מוריד את ה־DMG החתום מ־GitHub Releases של הפרויקט ובודק את ה־SHA-256 שלו. אחרי ההתקנה מלולי מתעדכן לבד. `brew uninstall --zap --cask meluli` מוחק גם את ההיסטוריה, המודלים וההגדרות.
