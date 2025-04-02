#!/bin/bash
find Icons -name '*.png' | parallel -j$(nproc) optipng -strip all -quiet
