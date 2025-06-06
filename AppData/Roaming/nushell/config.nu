# use completions *

# Envs
$env.EDITOR = "nvim"

# Aliases
alias n = nvim
alias g = git

alias ll = ls -l
alias la = ls -a
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ..... = cd ../../../..
alias ...... = cd ../../../../..

# Bindings
$env.config = {
  show_banner: false
  keybindings: [
    {
      name: history_search_forward
      modifier: control
      keycode: char_j
      mode: emacs
      event: { send: NextHistory  }
    }
    {
      name: history_search_backward
      modifier: control
      keycode: char_k
      mode: emacs
      event: { send: PreviousHistory }
    }
    {
      name: forward_char
      modifier: control
      keycode: char_l
      mode: emacs
      event: { edit: MoveRight }
    }
    {
      name: backward_char
      modifier: control
      keycode: char_h
      mode: emacs
      event: { edit: MoveLeft }
    }
  ]
}

fastfetch
