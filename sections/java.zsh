#
# Java
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_JAVA_SHOW="${SPACESHIP_JAVA_SHOW=true}"
SPACESHIP_JAVA_PREFIX="${SPACESHIP_JAVA_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_JAVA_SUFFIX="${SPACESHIP_JAVA_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_JAVA_SYMBOL="${SPACESHIP_JAVA_SYMBOL="☕️ "}"
SPACESHIP_JAVA_DEFAULT_VERSION="${SPACESHIP_JAVA_DEFAULT_VERSION=""}"
SPACESHIP_JAVA_COLOR="${SPACESHIP_JAVA_COLOR="red"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of java, exception system.
spaceship_java() {
  [[ $SPACESHIP_JAVA_SHOW == false ]] && return

  # Show JAVA status only for Java-specific folders
  [[ -f build.xml || -f pom.xml || -f build.gradle || -n *.java(#qN^/) ]] || return

  local 'java_version'

  if spaceship::exists jenv; then
    java_version=$(jenv version 2>/dev/null | awk -F ' ' '{print $1}')
    [[ $java_version == "system" ]] && return
  elif spaceship::exists java; then
    java_version=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
  else
    return
  fi

  [[ $java_version == $SPACESHIP_JAVA_DEFAULT_VERSION ]] && return

  spaceship::section \
    "$SPACESHIP_JAVA_COLOR" \
    "$SPACESHIP_JAVA_PREFIX" \
    "${SPACESHIP_JAVA_SYMBOL}${java_version}" \
    "$SPACESHIP_JAVA_SUFFIX"
}
