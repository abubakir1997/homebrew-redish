if not set -q REDISH_CONFIG_FILE
    set -gx REDISH_CONFIG_FILE ~/.redish_config
end

if status is-interactive
    # Enable SSH config host autocompletion
    function __redish_hosts
        command grep -i "^Host " $REDISH_CONFIG_FILE | cut -d ' ' -f 2- | tr ' ' '\n' | grep -v "\*"
    end
    
    complete -c redish -f -a "(__redish_hosts)"
    complete -c redish -n "test (count (commandline -opc)) -eq 2" -a "GET SET DEL EXISTS PING INFO KEYS HSET HGET HGETALL HMSET HMGET LPUSH RPUSH LPOP RPOP LRANGE SADD SMEMBERS SUNION SDIFF ZADD ZRANGE ZRANK ZREM ZCARD AUTH FLUSHDB FLUSHALL DBSIZE SELECT CONFIG CLIENT MONITOR SLOWLOG SCAN"
end