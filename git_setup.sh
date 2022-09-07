#!/bin/sh

# The Tim Pope ctags setup: https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
githookdir=~/.git_template/hooks

postrewrite='#!/bin/sh
case "$1" in
    rebase) exec .git/hooks/post-merge ;;
esac'

posthook='#!/bin/sh
.git/hooks/ctags >/dev/null 2>&1 &'

read -r -d '' ctagshook <<'EOF'
#!/bin/sh
set -e
PATH="/usr/local/bin:$PATH"
trap 'rm -f "$$.tags"' EXIT
git ls-files | \
    ctags --tag-relative -L - -f"$$.tags" --languages=-javascript,sql
mv "$$.tags" "tags"
EOF

mkdir -p "$githookdir"
echo $posthook > "$githookdir/hooks/post-commit"
echo $posthook > "$githookdir/hooks/post-merge"
echo $posthook > "$githookdir/hooks/post-checkout"
echo $postrewrite > "$githookdir/hooks/post-rewrite"

git config --global init.templatedir '~/.git_template'
git config --global user.name "John Khoo"
git config --global user.email "john_khoo@u.nus.edu"
git config --global core.editor vim
git config --global core.autocrlf false

ssh-keygen -t ed25519
