#!/usr/bin/awk -f

function trimStart(string) {
    sub(/^[ \t\r\n]+/, "", string);
    return string;
}
function trimEnd(string) {
    sub(/[ \t\r\n]+$/, "", string);
    return string;
}

function trim(string) {
    return trimEnd(trimStart(string));
}

BEGIN {
    print("Id,App,Version,Price\n"); 
} {
    noResults = $1 == "No" ? 1 : 0;
    if (noResults) {
        exit;
    }
    id = $1;
    $1 = "";
    split($0, str, "$");
    name = str[1];
    meta = str[2];
    split(str[2], versionInfo, "(");
    version = substr(versionInfo[2], 1, length(versionInfo[2]) -1)
    price = substr(meta, 0, 5);
    print(trim(id) "," trim(name) "," trim(version) "," trim(price) "," "\n");
} END { }
