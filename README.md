# Claude Skills

Skills for Claude Code. Two of them are git submodules that track upstream `main`.

| Skill | Type | Source |
|---|---|---|
| `android-skills` | submodule | [android/skills](https://github.com/android/skills) |
| `chrisbanes-skills` | submodule | [chrisbanes/skills](https://github.com/chrisbanes/skills) |
| `caveman` | local | — |
| `plain-english` | local | — |

## First use

Get the submodule content after a fresh clone:

```sh
git submodule update --init --recursive
```

## Update

Pull the latest `main` of both submodules:

```sh
git submodule update --remote --merge
```

The command leaves the new pointers staged. Examine them, then commit:

```sh
git commit -am "Update skill submodules"
```
