# Pasithea0 tap

Homebrew formulae for my tools.

```
brew tap Pasithea0/tap
brew trust pasithea0/tap
```
Taps require a one-time trust step, because
Homebrew now checks formulae that come from outside its own taps.

## plex-sync

The official Plex integration for [TheIntroDB](https://theintrodb.org). It fills
in Plex's intro and credits markers from the community database rather than
making Plex fingerprint every file in your library.

```
brew install plex-sync
plex-sync config check     # confirm it found Plex and its database
plex-sync plan             # what a run would change, writing nothing
plex-sync tui              # the terminal interface
brew services start plex-sync   # or let it run on a schedule
```

The binary is the released one for your platform, so there is no Go toolchain to
install. Source and documentation:
[TheIntroDB/plex-sync](https://github.com/TheIntroDB/plex-sync).

## siri-cli

Ask the real macOS Siri from your terminal and read back its actual response.

```
brew install siri-cli
siri status                # permission and environment check
```

The `siri` command is added to your PATH. Then grant Accessibility (and
optionally Screen Recording) to your terminal:

```
System Settings → Privacy & Security → Accessibility
```

and fully quit and relaunch your terminal. Verify with `siri status`.

> Requires **macOS 27** (the new "Siri AI" app). On macOS 26 the overlay's
> Accessibility tree is empty and responses cannot be read back.

Source and documentation: [Pasithea0/siri-cli](https://github.com/Pasithea0/siri-cli).

