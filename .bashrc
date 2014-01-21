if [ "$TERM" != "dumb" ]
then
  export EDITOR="vim"
  export PATH=~/bin:$PATH

  if [ -x "$HOME/.rbenv/bin/rbenv" ] ; then
    eval "$(rbenv init -)"
    export PATH=$HOME/.rbenv/bin:$PATH
  fi

  if [ -x "/usr/bin/lesskey" ] ; then
    lesskey
  fi

  for file in ~/.bash/plugins/*.bash; do
      source "$file"
  done

  for file in ~/.bash/aliases/*.bash; do
      source "$file"
  done

  . ~/.bash/prompt

fi
