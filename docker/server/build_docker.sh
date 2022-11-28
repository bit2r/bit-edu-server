#!/usr/bin/env bash
cd ..
docker pull joygram/bit-server-base:latest
docker build -t r2bit/bit-edu-server . -f Dockerfile 