#!/usr/bin/env bash
set -euo pipefail

tmp_dir="$(mktemp -d)"
tmp_override="${tmp_dir}/comments-test-override.yml"
tmp_site="${tmp_dir}/site"
created_posts=()
created_posts_dir=false

cleanup() {
  if [ "${#created_posts[@]}" -gt 0 ]; then
    for post in "${created_posts[@]}"; do
      rm -f "${post}"
    done
  fi
  if [ "${created_posts_dir}" = true ]; then
    rmdir "_posts" 2>/dev/null || true
  fi
  rm -rf "${tmp_dir}"
}
trap cleanup EXIT

ensure_post() {
  local path="$1"
  if [ -f "${path}" ]; then
    return
  fi
  if [ ! -d "_posts" ]; then
    created_posts_dir=true
  fi
  mkdir -p "_posts"
  cat >"${path}"
  created_posts+=("${path}")
}

ensure_post "_posts/2015-01-01-disqus-comments.md" <<'MARKDOWN'
---
layout: post
title: disqus comments
date: 2015-01-01 00:00:00
description: Integration fixture for Disqus comments.
disqus_comments: true
related_posts: false
---

This temporary fixture is created by `test/integration_comments.sh` when the
starter sample posts are not present.
MARKDOWN

ensure_post "_posts/2022-01-01-giscus-comments.md" <<'MARKDOWN'
---
layout: post
title: giscus comments
date: 2022-01-01 00:00:00
description: Integration fixture for Giscus comments.
giscus_comments: true
related_posts: false
---

This temporary fixture is created by `test/integration_comments.sh` when the
starter sample posts are not present.
MARKDOWN

cat >"${tmp_override}" <<'YAML'
giscus:
  repo: alshedivat/al-folio
  repo_id: R_kgDOExample
  category: Comments
  category_id: DIC_kwDOExample
YAML

bundle exec jekyll build --config "_config.yml,${tmp_override}" -d "${tmp_site}" >/dev/null

giscus_page="${tmp_site}/blog/2022/giscus-comments/index.html"
disqus_page="${tmp_site}/blog/2015/disqus-comments/index.html"

grep -q 'https://giscus.app/client.js' "${giscus_page}"
if grep -q 'giscus comments misconfigured' "${giscus_page}"; then
  echo "unexpected giscus misconfiguration warning in ${giscus_page}" >&2
  exit 1
fi

grep -q 'id="disqus_thread"' "${disqus_page}"
grep -q '.disqus.com/embed.js' "${disqus_page}"

echo "comments integration checks passed"
