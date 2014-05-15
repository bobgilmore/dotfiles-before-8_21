# From http://brettterpstra.com/2014/05/10/bash-and-dash/
# url encode the passed string
urlenc () {
  echo -n "$@" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($    1))/seg'
}

# Open in Dash
# Example:
# dash ruby:FileUtils cp_r
function dash() {
  open "dash://$(urlenc $@)"
}

function dman() {
  open "dash://man:$(urlenc $@)"
}

