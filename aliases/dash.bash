# From http://brettterpstra.com/2014/05/10/bash-and-dash/
# url encode the passed string
# Example:
# dash ruby:FileUtils cp_r
urlenc () {
  echo -n "$@" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($    1))/seg'
}

# Open in Dash
# Example:
# dash ruby:FileUtils cp_r
function dash() {
  if [[ $# -eq 0 ]] ; then
    echo 'DASH'
    echo 'Opens documentation in Dash.'
    echo 'Example:'
    echo 'dash ruby:FileUtils cp_r'
  else
    open "dash://$(urlenc $@)"
  fi
}

function dman() {
  if [[ $# -eq 0 ]] ; then
    echo 'DMAN'
    echo 'Opens MAN pages in DASH.'
    echo 'Example:'
    echo 'dman sed'
  else
    open "dash://man:$(urlenc $@)"
  fi
}

