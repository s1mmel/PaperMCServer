#!/bin/ash
set -e

if [[ "$1" = 'tini' ]];  then

  # Start server
  /usr/bin/java -jar $JAVA_ARGS \
    -Xmx$JAVA_HEAP_SIZE -Xms$JAVA_HEAP_SIZE \
    $SERVER_PATH/paper.jar \
    $SPIGOT_ARGS \
    --bukkit-settings $CONFIG_PATH/bukkit.yml --plugins $PLUGINS_PATH --world-dir $WORLDS_PATH --spigot-settings $CONFIG_PATH/spigot.yml --commands-settings $CONFIG_PATH/commands.yml --config $PROPERTIES \
    --paper-settings $CONFIG_PATH/paper.yml \
    $PAPER_ARGS
fi

exec "$@"

