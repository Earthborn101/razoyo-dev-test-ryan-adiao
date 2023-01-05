#!/bin/bash

set -e

# Install the app's depedencies
mix deps.get

echo "\n Launching Phoenix web server..."
mix phx.server
