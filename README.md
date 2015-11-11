# Introduction

I love writing bare metal ARM code. While there are a pluthora of development platforms available to do just that, you can't beat the retro feeling you get when writing code for an aging video game console.

The GameBoy Advance SP is a great development platform. It has an LCD controller, DMA controller, audio controller, IO controller, and many more just begging to be put to use. Unfortunately, it's really difficult to find software development kits for the GBA that allow you to start with nothing and work your way up to the reward that is plotting a single pixel on the screen.

This project aims to solve just that. With only three files, an `gba.ld`, `gba.s`, and `main.c`, you can get up and running developing for the GameBoy Advance in no time!

# Compiling

To compile, use the makefile that is included. But wait! Be sure to change the varaibles such as `cc` and `nm` to the tools that you use to build for the ARM architecture if you've moved them somewhere other than their default install location. If these tools can be found in your `PATH` environment variable, the script should work automatically.

One other thing, you need a tool called `gbafix` to patch the ROM header. You can obtain it by downloading and installing `DevKitPro`.

If you don't want to download `DevKitPro`, run a Google seach for `gbafix.cpp` and build it yourself using `gcc gbafix.cpp -o gbafix`. After it's built, point the makefile macro to its location on your system.

# Having Fun

Once you've built your newfound GBA ROM, you need to test it! You can do this using an emulator, but that's not nearly as fun as running it on real hardware. For a starting point on how to do that, check out [this video](https://youtu.be/Zfmj_KPE_L4). If there is enough demand for an elaborate tutorial on compiling and running GBA ROMS from the ground up, I will make one and publish it to YouTube. If you would be interested in this, please reach out to me at the email found on my GitHub homepage.