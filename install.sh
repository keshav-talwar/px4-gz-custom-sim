#!/usr/bin/env bash
# Apply these customizations to a fresh PX4-Autopilot checkout.
# Usage: ./install.sh [PX4_DIR] [TERRAIN_GEN_DIR]
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
PX4_DIR="${1:-$HOME/PX4-Autopilot}"
TERRAIN_DIR="${2:-$HOME/gazebo_terrain_generator}"
GZ="$PX4_DIR/Tools/simulation/gz"

echo "== Applying PX4 gz_bridge patch"
git -C "$PX4_DIR" apply "$HERE/patches/px4-autopilot-gz_bridge.patch"

echo "== Applying PX4-gazebo-models patch (sensor models)"
git -C "$GZ" apply "$HERE/patches/px4-gazebo-models.patch"

echo "== Copying custom worlds + models"
cp "$HERE"/worlds/*.sdf "$HERE"/worlds/model.config "$GZ/worlds/"
cp "$HERE/models/x500_lidar_front/k.py" "$GZ/models/x500_lidar_front/"
mkdir -p "$GZ/models/iris_with_hokuyo" && cp "$HERE/models/iris_with_hokuyo/model.sdf" "$GZ/models/iris_with_hokuyo/"

echo "== Copying prayag terrain textures from gazebo_terrain_generator"
mkdir -p "$GZ/worlds/textures"
cp "$TERRAIN_DIR"/sample_worlds/prayag/textures/* "$GZ/worlds/textures/"

echo "Done. Rebuild PX4: make -C \"$PX4_DIR\" px4_sitl"
