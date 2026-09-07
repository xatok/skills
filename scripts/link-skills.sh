#!/bin/sh
set -eu
cd "$(dirname "$0")/.."

TAB=$(printf '\t')
MANIFEST=.skills-generated
MARKER=.generated

slug_of() {
  git config -f .gitmodules --get "submodule.$1.url" |
    sed 's|\.git$||; s|.*[/:]\([^/]*/[^/]*\)$|\1|'
}

skill_name() {
  printf '%s/%s' "$1" "$2" | awk -F/ '{
    out = ""
    for (i = 1; i <= NF; i++) {
      if (i < NF && ($(i+1) == $i || index($(i+1), $i "-") == 1)) continue
      out = out (out == "" ? "" : "-") $i
    }
    print out
  }'
}

collect() {
  git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
  while read -r key path; do
    module=${key#submodule.}
    module=${module%.path}
    sub=$(git config -f .gitmodules --get "submodule.$module.skillsroot" || true)
    root=${sub:+$path/$sub}
    root=${root:-$path}
    prefix=$(git config -f .gitmodules --get "submodule.$module.skillsprefix" || slug_of "$module" | cut -d/ -f1)

    find "$root" -name SKILL.md | while read -r file; do
      dir=${file%/SKILL.md}
      if [ "$dir" = "$root" ]; then
        rel=$(basename "$dir")
      else
        rel=${dir#"$root"/}
      fi
      printf '%s\t%s\n' "$(skill_name "$prefix" "$rel")" "$dir"
    done
  done
}

rename_skill() {
  awk -v newname="$1" '
    NR == 1 && /^---[[:space:]]*$/       { fm = 1; print; next }
    fm && /^---[[:space:]]*$/            { if (!noauto) print "disable-model-invocation: true"
                                           fm = 0; print; next }
    fm && /^disable-model-invocation:/   { noauto = 1; print; next }
    fm && !done && /^name:/              { print "name: " newname; done = 1; next }
                                         { print }
  '
}

repoint_refs() {
  vendor_parent=$(dirname "$1")
  file=$2
  for ref in $(grep -oE '\.\./[A-Za-z0-9._-]+/' "$file" | sort -u); do
    seg=${ref#../}
    seg=${seg%/}
    target=$(awk -F"$TAB" -v k="$vendor_parent/$seg" '$2 == k { print $1; exit }' "$RECORDS")
    if [ -z "$target" ]; then
      echo "warn: $file: left unresolved reference ../$seg/" >&2
      continue
    fi
    awk -v from="../$seg/" -v to="../$target/" '{
      out = ""
      while ((i = index($0, from)) > 0) {
        out = out substr($0, 1, i - 1) to
        $0 = substr($0, i + length(from))
      }
      print out $0
    }' "$file" > "$file.tmp"
    mv "$file.tmp" "$file"
  done
}

clean() {
  find . -maxdepth 1 -type l -exec rm {} +
  [ -f "$MANIFEST" ] || return 0
  while read -r name; do
    case $name in ''|.|..|*/*) continue ;; esac
    [ -f "$name/$MARKER" ] && rm -rf "$name"
  done < "$MANIFEST"
  rm -f "$MANIFEST"
}

materialize() {
  while IFS="$TAB" read -r name dir; do
    mkdir -p "$name"
    : > "$name/$MARKER"
    rename_skill "$name" < "$dir/SKILL.md" > "$name/SKILL.md"
    repoint_refs "$dir" "$name/SKILL.md"
    find "$dir" -mindepth 1 -maxdepth 1 ! -name SKILL.md | while read -r child; do
      ln -sfn "../$child" "$name/$(basename "$child")"
    done
    echo "$name"
  done < "$1" > "$MANIFEST"
}

RECORDS=$(mktemp)
trap 'rm -f "$RECORDS"' EXIT

collect | sort > "$RECORDS"
clean
materialize "$RECORDS"

echo "generated $(wc -l < "$MANIFEST" | tr -d ' ') skills"
