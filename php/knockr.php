<?php

array_shift($argv);

$host = current($argv);

if (!filter_var($host, FILTER_VALIDATE_IP)) {
    throw new \Exception("{$host} is not a valid IP address");
}

foreach (explode(",", end($argv)) as $port) {
    $fp = @stream_socket_client("tcp://{$host}:{$port}", $errno, $errstr, 10);

    if (!$fp) {
        continue;
    }

    fclose($fp);
}
