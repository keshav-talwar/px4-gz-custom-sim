# px4-gz-custom-sim

My local changes on top of PX4-Autopilot and PX4-gazebo-models for the drone spoofing
simulation (see the `Spoofing-of-drone-in-simulation` / `px4_ws` repo). PX4 itself is
~8 GB, so these changes are kept here as patches plus extra files instead of as a fork.

## Contents

| Path | What it is |
|---|---|
| `patches/px4-autopilot-gz_bridge.patch` | Changes to `src/modules/simulation/gz_bridge/` (GZBridge.cpp/.hpp, parameters.c) |
| `patches/px4-gazebo-models.patch` | Sensor changes to `OakD-Lite`, `mono_cam`, `x500_depth`, `x500_lidar_front` models |
| `worlds/prayag.sdf`, `worlds/small_city.sdf` | Custom Gazebo worlds |
| `worlds/model.sdf`, `worlds/model.config` | Prayag terrain model (textures come from gazebo_terrain_generator) |
| `models/iris_with_hokuyo/model.sdf` | Iris with Hokuyo LiDAR (was `offroad_11.xml`) |
| `models/x500_front_camera_snippet.sdf` | x500 + front camera SDF snippet |
| `terrain/1771879622584/` | Terrain/buildings model generated with gazebo_terrain_generator |

## Base versions

The patches were made against these commits:

- PX4-Autopilot: `e2e89def7ea4bdfaa861009c6d6d9e25c89cf39f`
- PX4-gazebo-models (`Tools/simulation/gz` submodule): `fe3fe236e36a3ed5bce01a7501347d20a466c407`

## Setup on a new machine

```bash
git clone --recursive https://github.com/PX4/PX4-Autopilot.git ~/PX4-Autopilot
git -C ~/PX4-Autopilot checkout e2e89def7ea4bdfaa861009c6d6d9e25c89cf39f
git -C ~/PX4-Autopilot submodule update --init --recursive
git clone https://github.com/saiaravind19/gazebo_terrain_generator.git ~/gazebo_terrain_generator
./install.sh ~/PX4-Autopilot ~/gazebo_terrain_generator
```
