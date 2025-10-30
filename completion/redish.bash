# Bash completion for redish

_redish_complete() {
    local cur prev opts hosts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Get hosts from config file
    if [[ -f "${REDISH_CONFIG_FILE:-$HOME/.redish_config}" ]]; then
        hosts=$(grep -i "^Host " "${REDISH_CONFIG_FILE:-$HOME/.redish_config}" | cut -d ' ' -f 2- | tr ' ' '\n' | grep -v "\*")
    else
        hosts=""
    fi

    # Redis command list
    opts="GET SET DEL EXISTS PING INFO KEYS HSET HGET HGETALL HMSET HMGET LPUSH RPUSH LPOP RPOP LRANGE SADD SMEMBERS SUNION SDIFF ZADD ZREM ZRANGE ZSCORE ZCARD"

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $(compgen -W "${hosts}" -- ${cur}) )
    elif [ $COMP_CWORD -eq 2 ]; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    fi
}

complete -F _redish_complete redish