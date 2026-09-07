# Skills

Personal skills for Android and Kotlin development.

## Install

Fetches the vendored skill repos and generates one directory per skill at the top level.

```
git submodule update --init --recursive
scripts/link-skills.sh
```

## Update

Pulls the latest commits from every vendored repo, then regenerates the skill directories so renamed
or removed skills upstream are reflected here.

```
git submodule update --remote --merge
scripts/link-skills.sh
```

## Add a skill set

Vendors another repo of skills as a submodule. Its skills get a prefix so names coming from
different sources never collide.

```
git submodule add --name <name> -b <branch> <url> .vendor/<name>
scripts/link-skills.sh
```

Optional keys in `.gitmodules`:

```
git config -f .gitmodules submodule.<name>.skillsroot <path>      # if skills aren't at the repo root
git config -f .gitmodules submodule.<name>.skillsprefix <prefix>   # defaults to the owner in the URL
```

## Sources

| Prefix        | Upstream                                 |
|---------------|------------------------------------------|
| `android-`    | https://github.com/android/skills        |
| `chrisbanes-` | https://github.com/chrisbanes/skills     |
| `caveman`     | https://github.com/JuliusBrussee/caveman |
