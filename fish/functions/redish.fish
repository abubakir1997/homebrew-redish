# SSH-like Redis wrapper for Fish shell

function redish
    set config_file $REDIS_CONFIG_FILE

    if test (count $argv) -eq 0
        echo "Usage: redis <host> <command> [args...]"
        echo "Available hosts:"
        grep -i "^Host " $config_file | cut -d ' ' -f 2- | tr ' ' '\n' | grep -v "\*"
        return 1
    end

    set host $argv[1]
    set verbose 0
    set cmd_args

    for arg in $argv[2..-1]
        if test "$arg" != "-v" -a "$arg" != "--verbose"
            set cmd_args $cmd_args $arg
        else
            set verbose 1
        end
    end

    set block (awk -v h="$host" '
        $1 == "Host" && $2 == h {inblock=1; next}
        $1 == "Host" {inblock=0}
        inblock && NF {print $0}
    ' $config_file)

    if test -z "$block"
        echo "Host not found: $host"
        return 1
    end

    set redis_host_name ""
    set redis_port ""
    set redis_password ""
    set tls_flag ""

    for line in $block
        if string match -r -q '^ *HostName ' $line
            set redis_host_name (string trim (string replace -r '^ *HostName ' '' $line))
            if test $verbose -eq 1
                echo "INFO> Found HostName: $redis_host_name"
            end
        end
        if string match -r -q '^ *Port ' $line
            set redis_port (string trim (string replace -r '^ *Port ' '' $line))
            if test $verbose -eq 1
                echo "INFO> Found Port: $redis_port"
            end
        end
        if string match -r -q '^ *Password ' $line
            set redis_password (string trim (string replace -r '^ *Password ' '' $line))
            if test $verbose -eq 1
                echo "INFO> Found Password: ********"
            end
        end
        if string match -r -q '^ *TLS ' $line
            if string match -r -q 'yes' $line
                set tls_flag "--tls"
                if test $verbose -eq 1
                    echo "INFO> TLS enabled"
                end
            end
        end
    end

    if test -z "$redis_host_name"
        echo "ERROR> No HostName found for $host"
        return 1
    end

    if test -z "$redis_password"
        echo "ERROR> No Password found for $host"
        return 1
    end

    if test -z "$redis_port"
        set redis_port 6379
    end

    if test $tls_flag = ""
        if test $verbose -eq 1
            echo "INFO> redis-cli -u rediss://$redis_password@$redis_host_name:$redis_port $cmd_args"
        end
        redis-cli -u rediss://$redis_password@$redis_host_name:$redis_port $cmd_args
    else
        if test $verbose -eq 1
            echo "INFO> redis-cli $tls_flag -u rediss://$redis_password@$redis_host_name:$redis_port $cmd_args"
        end
        redis-cli $tls_flag -u rediss://$redis_password@$redis_host_name:$redis_port $cmd_args
    end
end