# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/.nodebrew/current/bin:$PATH

alias n='nvim'

# pnpm
export PNPM_HOME="/Users/nicon/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

alias gconf='nvim ~/Library/Application\ Support/com.mitchellh.ghostty/config'
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Added by Windsurf
export PATH="/Users/nicon/.codeium/windsurf/bin:$PATH"

export PATH="/Users/nicon/.bun/bin:$PATH"

eval "$(fzf --zsh)"

# Use eza as the default 'ls' command
alias ls='eza --color=auto --icons --group-directories-first'

alias l='eza -lbF --git'
alias la='eza -lbhHigUmuSa'  # list all
alias ll='eza --all --header --long --git' # long format, all files, git status
alias tree='eza --tree --icons -L 2' # tree view with icons and depth 2

eval "$(zoxide init zsh)"

# ghq
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf

# Lazygit
alias lg='lazygit'

# brew優先
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship
eval "$(starship init zsh)"

# 親ディレクトリへ移動alias
alias '..'='cd ..'
