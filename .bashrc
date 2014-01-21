if [ "$TERM" != "dumb" ]
then

  for file in ~/.bash/plugins/*.bash; do
      source "$file"
  done

  for file in ~/.bash/aliases/*.bash; do
      source "$file"
  done

  . ~/.bash/env
  . ~/.bash/prompt

  if [ -x "/usr/bin/lesskey" ] ; then
    lesskey
  fi
fi
