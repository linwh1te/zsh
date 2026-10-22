for _zsh_part in theme env aliases utility options plugins keybinds highlight; do
  source "$ZDOTDIR/$_zsh_part.zsh" || return
done
unset _zsh_part

# Home Manager 提供已启用工具的集成配置。
if [[ -f "$ZDOTDIR/hm-integration.zsh" ]]; then
  source "$ZDOTDIR/hm-integration.zsh" || return
fi

source "$ZDOTDIR/prompt.zsh"
