#!/usr/bin/env sh
set -e

BASE_DIR=$(dirname "$0")
WRAPPER_DIR="$BASE_DIR/.mvn/wrapper"

# Download wrapper jar if missing
if [ ! -f "$WRAPPER_DIR/maven-wrapper.jar" ]; then
  echo "maven-wrapper.jar not found; downloading..."
  java -cp "$WRAPPER_DIR" org.apache.maven.wrapper.MavenWrapperDownloader "$BASE_DIR"
fi

JAVA_CMD=${JAVA_HOME:+"$JAVA_HOME/bin/"}java

exec "$JAVA_CMD" -Dmaven.multiModuleProjectDirectory="$BASE_DIR" \
  -classpath "$WRAPPER_DIR/maven-wrapper.jar" \
  org.apache.maven.wrapper.MavenWrapperMain "$@"


