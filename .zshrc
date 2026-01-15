# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/.nodebrew/current/bin:$PATH

alias ls='ls --color'
alias ll='ls -l'
alias n='nvim'

# pnpm
export PNPM_HOME="/Users/nicon/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)

source $ZSH/oh-my-zsh.sh

alias gconf='nvim ~/Library/Application\ Support/com.mitchellh.ghostty/config'
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
