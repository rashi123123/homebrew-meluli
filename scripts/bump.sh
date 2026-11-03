#!/usr/bin/env bash
# Points the cask at the newest published Meluli release that carries a DMG.
# Takes the hash from the release's SHA256SUMS.txt and checks it against the downloaded DMG.
set -euo pipefail

repo="rashi123123/meluli"
cask="Casks/meluli.rb"

tag=$(gh api "repos/$repo/releases" --jq '[.[] | select(.draft | not) | select(any(.assets[]; .name | endswith("-arm64.dmg")))][0].tag_name // empty')
if [ -z "$tag" ]; then
  echo "No published release has a DMG yet."
  exit 0
fi
version=${tag#v}
dmg="Meluli-$version-arm64.dmg"

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
gh release download "$tag" --repo "$repo" --dir "$work" --pattern "$dmg" --pattern SHA256SUMS.txt
sha=$(awk -v f="$dmg" '$2 == f || $2 == "*" f { print $1 }' "$work/SHA256SUMS.txt")
if ! [[ "$sha" =~ ^[0-9a-f]{64}$ ]]; then
  echo "SHA256SUMS.txt has no entry for $dmg." >&2
  exit 1
fi
(cd "$work" && echo "$sha  $dmg" | shasum -a 256 -c -)

sed -i.bak -E "s/^  version \".*\"$/  version \"$version\"/; s/^  sha256 \".*\"$/  sha256 \"$sha\"/" "$cask"
rm "$cask.bak"
grep -q "^  version \"$version\"$" "$cask"
grep -q "^  sha256 \"$sha\"$" "$cask"
echo "Cask points at $tag."
