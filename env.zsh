#
## PATH & ENV Var
##

export PATH="$HOME/.moon/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export KUBECONFIG="$HOME/.config/k3s.yaml"
export starship_config="$ZDOTDIR/starship.toml"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

if command -v direnv >/dev/null 2>&1; then
  export DIRENV_LOG_FORMAT=''

  _direnv_hook() {
    trap -- '' SIGINT
    eval "$(direnv export zsh 2> >(command sed -E "s/\x1b\[[0-9;]*m//g" | command grep -v '^direnv:' >&2))"
    trap - SIGINT
  }

  typeset -ag precmd_functions chpwd_functions
  if (( ! ${precmd_functions[(I)_direnv_hook]} )); then
    precmd_functions+=(_direnv_hook)
  fi
  if (( ! ${chpwd_functions[(I)_direnv_hook]} )); then
    chpwd_functions+=(_direnv_hook)
  fi
fi


# elan
if [ -f "$HOME/.elan/env" ]; then
  # shellcheck source=/dev/null
  . "$HOME/.elan/env"
fi

# export PNPM_HOME="$HOME/.local/share/pnpm"
# export PATH="$PNPM_HOME:$PATH"
# export PATH="$HOME/.scripts:$PATH"
# export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/.cargo/bin:$PATH"
# export PATH="/opt/riscv-gnu-toolchain/bin:$PATH"
# export PATH="/opt/homebrew/opt/gcc/bin:$PATH"
# export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
# export PATH="/Applications/ARM/bin:$PATH"
# export PATH="/opt/homebrew/anaconda3/bin:$PATH"
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
# export PATH="$HOME/.jenv/bin:$PATH"
# export PATH="/opt/llvm/bin:$PATH"
# export PATH="/opt/homebrew/opt/curl/bin:$PATH"
# export PATH="/Users/hank/.ghcup/ghc/9.4.8/bin:$PATH"
# eval "$(jenv init -)"
# export GPG_TTY="${TTY:-$(tty)}"
# export HOMEBREW_NO_INSTALL_FROM_API=1
# export HDF5_DIR="/opt/homebrew/anaconda3/bin:$PATH"

# export SUDO_PROMPT="passwd: "
export TERMINAL="ghostty"
# export BROWSER="firefox"
# export VISUAL="nvim"
export EDITOR="nvim"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# export XDG_CONFIG_DIRS="/etc/xdg"
# export XDG_DATA_DIRS="/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$XDG_DATA_HOME/flatpak/exports/share"
# export XDG_RUNTIME_DIR="/run/user/$(id -u)"
# export XDG_DESKTOP_DIR="$HOME/Desktop"
# export XDG_DOWNLOAD_DIR="$HOME/Downloads"
# export XDG_TEMPLATES_DIR="$HOME/Templates"
# export XDG_PUBLICSHARE_DIR="$HOME/Public"
# export XDG_DOCUMENTS_DIR="$HOME/Documents"
# export XDG_MUSIC_DIR="$HOME/Music"
# export XDG_PICTURES_DIR="$HOME/Pictures"
# export XDG_VIDEOS_DIR="$HOME/Videos"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

## Comment this to use normal manpager
export MANPAGER='nvim +Man! +"set nocul" +"set noshowcmd" +"set noruler" +"set noshowmode" +"set laststatus=0" +"set showtabline=0" +"set nonumber"'

if [ $(echo $MANPAGER | awk '{print $1}') = nvim ]; then
  export LESS="--RAW-CONTROL-CHARS"
  export MANPAGER="less -s -M +Gg"

  export LESS_TERMCAP_mb=$'\e[1;32m'
  export LESS_TERMCAP_md=$'\e[1;32m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_so=$'\e[01;33m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export LESS_TERMCAP_us=$'\e[1;4;31m'
fi

# fzf 与 fzf-tab 共用 Flat White 配色。
FZF_COLORS="fg:$foreground,fg+:$selection_fg,bg:$background,bg+:$selection_bg,hl:$color3,hl+:$color11,info:$color8,prompt:$color4,spinner:$color5,pointer:$color3,marker:$color2,border:$color8,header:$color4,gutter:$background"
export FZF_DEFAULT_OPTS="
  --color=$FZF_COLORS
  --prompt ' '
  --pointer ' λ'
  --layout=reverse
  --border horizontal
  --height 40"

# 文件列表使用终端的 Flat White ANSI 颜色。
export LS_COLORS='di=1;34:ln=36:or=31:mi=31:so=35:pi=33:ex=32:bd=33:cd=33:su=1;31:sg=1;33:tw=1;32:ow=34:st=34:*.zip=35:*.tar=35:*.gz=35:*.7z=35:*.jpg=33:*.png=33:*.mp4=35:*.pdf=36'

proxy() {
    # 定义代理服务器地址
    local proxy_address="http://127.0.0.1:7890"

    # 设置小写环境变量
    export http_proxy="${proxy_address}"
    export https_proxy="${proxy_address}"
    export all_proxy="${proxy_address}" # 有些程序会读取这个

    # 设置大写环境变量 (为了更好的兼容性)
    export HTTP_PROXY="${proxy_address}"
    export HTTPS_PROXY="${proxy_address}"
    export ALL_PROXY="${proxy_address}"

    echo "✅ 代理已启用 (http/https/all -> ${proxy_address})"
    echo "   当前代理设置:"
    env | grep -i "_proxy"
}

unproxy() {
    # 取消设置所有相关的代理环境变量
    unset http_proxy https_proxy all_proxy
    unset HTTP_PROXY HTTPS_PROXY ALL_PROXY
    echo "❌ 代理已禁用"
}

# vim:ft=zsh:nowrap
