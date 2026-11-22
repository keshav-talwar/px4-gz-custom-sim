# px4-gz-custom-sim

My changes on top of **PX4-Autopilot** and **PX4-gazebo-models** for the drone GPS-spoofing
simulation. PX4 itself is about 8 GB, so instead of a fork this repo keeps **patches plus extra files**
and an installer that applies them to a clean PX4 checkout.

Used by [`Spoofing-of-drone-in-simulation`](https://github.com/keshav-talwar/Spoofing-of-drone-in-simulation)
(ROS 2 stack) and [`gnss-spoof-lab`](https://github.com/keshav-talwar/gnss-spoof-lab).

## What's changed

| Path | What it is |
|---|---|
| `patches/px4-autopilot-gz_bridge.patch` | Changes to PX4's Gazebo bridge (`src/modules/simulation/gz_bridge/GZBridge.cpp/.hpp`, `parameters.c`), the sim-side hooks the spoofing and sensor setup rely on |
| `patches/px4-gazebo-models.patch` | Sensor changes to the `OakD-Lite`, `mono_cam`, `x500_depth` and `x500_lidar_front` models (camera/depth/LiDAR configs for SLAM and spoof detection) |
| `worlds/prayag.sdf` | Main world: real terrain of Prayag (Prayagraj) made with gazebo_terrain_generator |
| `worlds/small_city.sdf` | Urban test world |
| `worlds/model.sdf`, `worlds/model.config` | Prayag terrain model (its textures are copied in from gazebo_terrain_generator) |
| `models/iris_with_hokuyo/model.sdf` | Iris quad with a Hokuyo 2D LiDAR |
| `models/x500_front_camera_snippet.sdf` | x500 + front camera SDF snippet |
| `terrain/1771879622584/` | Generated terrain + buildings model (height map, aerial texture, `buildings.geojson`/`.dae`) |
| `install.sh` | Applies both patches, copies the worlds/models and the Prayag textures into PX4 |

## Base versions

- PX4-Autopilot `e2e89def7ea4bdfaa861009c6d6d9e25c89cf39f`
- PX4-gazebo-models (`Tools/simulation/gz` submodule) `fe3fe236e36a3ed5bce01a7501347d20a466c407`
- gazebo_terrain_generator `b2fd84ac`

## Setup on a new machine

```bash
git clone --recursive https://github.com/PX4/PX4-Autopilot.git ~/PX4-Autopilot
git -C ~/PX4-Autopilot checkout e2e89def7ea4bdfaa861009c6d6d9e25c89cf39f
git -C ~/PX4-Autopilot submodule update --init --recursive
git clone https://github.com/saiaravind19/gazebo_terrain_generator.git ~/gazebo_terrain_generator
./install.sh ~/PX4-Autopilot ~/gazebo_terrain_generator
make -C ~/PX4-Autopilot px4_sitl

# fly in the Prayag world with the front-LiDAR x500
cd ~/PX4-Autopilot && PX4_GZ_WORLD=prayag make px4_sitl gz_x500_lidar_front
```

`install.sh` uses `git apply`, so run it on a **clean** checkout. If a patch fails, reset the
submodule (`git -C Tools/simulation/gz checkout .`) and retry.

## Notes

- `models/x500_lidar_front/k.py` is a stray scratch script (prints random numbers), not part of
  the model; `install.sh` copies it but nothing uses it.
