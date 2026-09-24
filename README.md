# homebrew-ccwho

The Homebrew tap for [ccwho](https://github.com/lukaso/ccwho) - which Claude Code
session needs you, and what it is about.

```sh
brew install lukaso/ccwho/ccwho
ccwho setup
```

Upgrade with `brew upgrade ccwho`. macOS only; it needs iTerm2 and Claude Code, and
brings `uv` for the live list.

## Releasing

Publish a GitHub release in `lukaso/ccwho` with a `vX.Y.Z` tag. The `brew bump`
workflow here runs daily, sees the new tag, and opens a pull request that updates
the formula's `url` and `sha256`. Merge it once `brew test-bot` is green.
