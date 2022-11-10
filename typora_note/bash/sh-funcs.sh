#!/usr/bin/env bash


str_lower() {
    echo "$@" | tr '[:upper:]' '[:lower:]'
    # or
    # echo "$@" | awk '{print tolower($0)}'
}

str_upper() {
    echo "$@" | tr '[:lower:]' '[:upper:]'
    # or
    # echo "$@" | awk '{print toupper($0)}'
}