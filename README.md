# dotfiles
Dotfiles plus a little Git/Bash voodoo to bootstrap source controlling them and setting up a new system from this repo.

Based on [this guide](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

## Bootstrapping a new system
Run this:

```bash
git clone --bare https://github.com/seppomerimaa/dotfiles.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```

## Usage
Basically we just have `config` as a fancy alias for `git` so you can `config add foo` and `config commit -m "Add foo" and `config push` etc.

## Notes
`.bash_profile` just has general stuffs that I want to use across machines. It sources `.corporate-profile` which is where I put company-specific aliases etc. that obviously shouldn't be posted publicly.
