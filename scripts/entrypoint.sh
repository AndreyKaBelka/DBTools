#!/usr/bin/env bash

/home/wait-for-it.sh database:"${DATABASE_PORT}" -s -t 60 -- /entrypoint.py