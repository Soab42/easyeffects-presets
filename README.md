# EasyEffects Presets

A curated collection of **129** presets for [wwmm's EasyEffects](https://github.com/wwmm/EasyEffects), gathered from various community sources and bundled into a single repository.

## Contents

All presets live in the [`json/`](json) directory and cover a wide range of use cases:

- **Loudness / Auto Gain** — `LoudnessEqualizer`, `LoudnessEqualizer-GTK`, `LoudnessEqualizer-PE`, `LoudnessEqualizer-OldGate`, `LoudnessCrystalEqualizer`, `LoudnessCrystalEqualizer-GTK`, `Loudness+Autogain`, `Advanced Auto Gain`, `Levelizer (EBU R128)`, `NightOwl-Compressor`
- **EQ / Bass** — `Perfect EQ`, `Bass Enhancing + Perfect EQ`, `Bass Enhancing + Perfect EQ - Low Latency`, `Boosted`, `Bass Boosted`, `Heavy Bass`, `HB-Flat`, `HB-Lite`, `HB-Mid`
- **Laptop / Speaker tuning** — `Pavilion`, `thinkpad-t14-gen1`, `thinkpad-x1-yoga-gen2`, `thinkpad-unsuck`, `Cupertino Laptop Speakers`, `Tiny Speaker Rescue`, `Speaker Sync`
- **Dolby / Surround / HRTF** — `Dolby Atmos`, `ARI HRTF (SOFA)`, `MIT KEMAR HRTF (SOFA)`, `IRCAM LISTEN HRTF (Subject 1002)`, `LibreAtmos`, `Aurora Immersive`, `Synthetic Binaural Room`, `Synthetic Spherical Crossfeed`
- **HeSuVi virtualization** — full set of `HeSuVi *` presets (CMSS-3D, Dolby Headphone, DS3D, DTS Headphone X, GSX, Nahimic, OpenAL, Razer Surround, Sound Blaster SBX, Waves, Windows Sonic, SSC, Out Of Your Head, Flux HEar, Atmos)
- **FLORA / Concert / Movie** — `FLORA Cinema`, `FLORA Cinema (full marker)`, `FLORA Music`, `FLORA Music (full marker)`, `Concert Hall`, `Movie Dialogue Boost`, `Night Listening`
- **Music genres (EasyPulse)** — `rock`, `classical`, `edm`, `hifi`, `indie`, `kpop`, `lofi`, `analog` (`-min` / `-max` variants)
- **Dialogue / Vocal** — `Vocal Clarifier`, `GentleDynamics`, `GentleDynamics Dialogue Clarity Engine`, `GentleDynamics Feather Loudness`, `Monauralized and Maximized`, `Mono Sum (Accessibility)`
- **Misc / Reference** — `Music`, `Video`, `Bose`, `Sony`, `TrainCams`, `Max`, `125HP+AG+C+Max`, `AG+BE+Cry+M`, `AG+C+Max`, `AG+Comp+Cry+BE+Max`, `BE+Cr+Max`, `C+Cry+BE+Max`, `Analog Warmth`, `EFOtech MLV *`, `OpenEQ + Loudness`, `Reference Transparency`, `AAAAAAAaaaaa`, `input`, `music`

# Installation

The `install.sh` script will detect your EasyEffects presets directory and install every preset automatically:

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Soab42/easyeffects-presets/main/install.sh)"
```

**NOTE:** the script requires `curl` and `tar`. On Ubuntu, install them first with:

```shell
sudo apt install curl tar
```

# Manual installation

Clone the repository and copy the `.json` files from `json/` into the `output` directory of your EasyEffects presets folder.

> **Note:** recent EasyEffects versions load presets from the **XDG data** directory, not the config directory. The `install.sh` script writes to both locations so presets show up regardless of version. If you install manually, use the **data** paths below (preferred), falling back to config if your version is older.

If you installed EasyEffects through **Flatpak**, copy to:

```
~/.var/app/com.github.wwmm.easyeffects/data/easyeffects/output/
```

(older Flatpak builds may also read from `~/.var/app/com.github.wwmm.easyeffects/config/easyeffects/output/`)

If you used the **PPA** (Ubuntu) or the **AUR** package (Arch), copy to:

```
~/.local/share/easyeffects/output/
```

(older native builds may read from `~/.config/easyeffects/output/`)

Then copy the presets:

```shell
git clone https://github.com/Soab42/easyeffects-presets.git
mkdir -p ~/.local/share/easyeffects/output
cp easyeffects-presets/json/*.json ~/.local/share/easyeffects/output/
```

Restart EasyEffects (or reload its preset list) for the new presets to appear.
