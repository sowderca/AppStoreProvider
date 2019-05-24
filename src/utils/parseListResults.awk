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
    print("Id,App,Version\n"); 
} {
    noResults = $1 == "No" ? 1 : 0;
    if (noResults) {
        exit;
    }
    id = $1;
    $1 = "";
    split($0, str, "$");
    split(str[1], versionInfo, "(");
    name = versionInfo[1]
    version = substr(versionInfo[2], 1, length(versionInfo[2]) -1)
    print(trim(id) "," trim(name) "," trim(version) "," "\n");
} END { }

