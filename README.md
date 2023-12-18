# You've reached ?

![564ship](https://github.com/564ship/blackarch-blackpearl/blob/master/.github/banner.jpg)

I've heard of one, supposed to be very fast, nigh uncatchable: The Black Pearl.

# "Ken, Unix and Games”

![UNIX](https://upload.wikimedia.org/wikipedia/commons/c/c9/Version_6_Unix_SIMH_PDP11_Emulation_KEN.png)

Dennis M. Ritchie and Ken Thompson (at) Bell Laboratories
(The) UNIX Time-Sharing System :
    <a href="https://dsf.berkeley.edu/cs262/unix.pdf">CS 262A. Advanced Topics in Computer Systems</a>

# Powered by archlinuxcn

![archlinuxcn](https://i.postimg.cc/gcVCdFbm/2022-12-17-11-48.png)

archlinuxcn客制套件來源，它不止將Yaourt編譯成套件，還有其他許多的來源也編成套件，建議第一次使用Arch能加入此客制套件來源.

# linux-ogo ?

![linux-ogo](http://knoppix.net/images/logo.png)

New suitable runs revived for resolute version-rolling automation... 
Once upon a time, The OpenGroupware.org (OGo) Knoppix CD existed, kernel image would Highly-reproducible.

```
archlinuxcn/linux-ogo
    The Linux (own goal oh) kernel and modules (disable nouveau, disable
    uvcvideo, default apparmor, default bbr)
Packager        : Dct Mei <dctxmei@build.archlinuxcn.org>

```

# Supersubset ?

Modern computers with arch/x86 only (tweaking modules removes painfully). 1st deps defined as 

```sh
	vi util-linux (util-linux-libs)
```

# Technical notes

Debian status :
    <a href="https://wiki.debian.org/DebianKernel/UserspaceTools">Nowadays Provided by Kernel Userspace</a>

# Blackarch ?

![blackarch](https://blackarch.org/images/slider/ba-slider.png)

BlackArch Linux is an Arch Linux-based penetration testing distribution for 
penetration testers and security researchers.
The repository contains 2263 tools. You can install tools individually or in groups.

Learn more :
    <a href="https://blackarch.org/">The official blackarch website</a>


## SIMD operations

Tending to be 128 bits wide or higher, should be aligned to 16 bytes boundaries for compile.

## x86_64 (Support)

AVX mode may take advantages of alignments up to 32-byte aligned. See i386-common.c in gcc, 


```sh
	${CFLAGS} -malign-functions=32 # if unspecified
```

Desktop: ALIENWARE Area-51 (Broadwell-E Core i7 6950X)
Laptop: ThinkPad X13 Gen1 AMD (Ryzen 5 PRO 4650U)
or later

```sh
        KCARCH="cooperlake" ##knl,cooperlake
        CFLAGS="-march=${KCARCH} -fno-builtin-abort -funroll-loops \
        -funsafe-math-optimizations -ffast-math -frounding-math \
        -mno-3dnow -mno-lwp -mno-tbm -mno-xop -mno-fma4 \
        -mno-rdpid -mno-pku -mno-wbnoinvd \
        -mno-mwaitx -mno-waitpkg -mno-ptwrite \
        -mno-avx512pf -mno-avx512er -mno-prefetchwt1 \
        -mmovbe -mfsgsbase -mpclmul -msahf -mcx16 -mf16c -madx \
        -mmmx -mfxsr -mfma -mbmi -mpopcnt -mbmi2 -mlzcnt \
        -msse -msse2 -msse3 -mssse3 -msse4 -mavx -mavx2 \
        -mfpmath=sse -minline-all-stringops"
        CXXFLAGS="${CFLAGS}"
```

## aarch64 (armv9)

the stack must remain 16-byte aligned at all times (X31 register), See aarch64-common.c in gcc,
Checking only available in aarch64.


```sh
	${CFLAGS} -malign-functions=16 # if unspecified
```

Not yet Full-featured in 2023, (need crosscompiling) but it will be soon from official...
Suggest: Google Pixel 8 Pro, Galaxy S23 Ultra, Sony Xperia 1 V, ROG Phone 7

```sh
	CFLAGS="-march=armv9 -mtune=cortex-a715 -O2 -pipe"
	CXXFLAGS="${CFLAGS}"
```

## aarch64 (armv8)

AppleM2 Ultra, Khadas Edge2 (Rockchip RK3588S)

```sh
	CFLAGS="-march=armv8 -mtune=cortex-a72 -O2 -pipe"
	CXXFLAGS="${CFLAGS}"
```

# issues ?

The final executable relating has no dependencies with them on the library at run time, can properly ignored.

```sh
	libarchive libxcrypt libsecret libuv libevent libverto libnsl libassuan libsasl
```

# systemd ?

Current services status :
    <a href="https://github.com/systemd/systemd/tree/main/units">No Help :lol</a>


# Python Problems

boost, tensorflow might be face...

```sh
    https://fedoraproject.org/wiki/User:Cstratak/python3_static_link_against_libpython
    (calamares) libkcrash5, libpython, libboost, libyaml-cpp should static linking at-least.
```

# inspired by ?

Charlie Bit Me (qpec)

![qpec](https://github.com/564ship/blackarch-blackpearl/blob/master/.github/pickup1.png)

Olenergy :
    <a href="https://ccmixter.org/files/qpec/15156">Sooner or Later by Olenergy</a>

Ado (@ado_staff)

![Ado](https://github.com/564ship/blackarch-blackpearl/blob/master/.github/pickup2.png)

すべて再生    歌いました - Ado :
    <a href="https://www.youtube.com/playlist?list=PLaxauk3chSWjJUBirUlCQH9fOgvfiNjcc">The official Ado Youtube Playlist</a>

YuNi (@_YuNiofficial_)

![YuNi](https://github.com/564ship/blackarch-blackpearl/blob/master/.github/pickup3.png)

すべて再生    歌ってみた - YuNi :
    <a href="https://www.youtube.com/playlist?list=PLjGAXih5gQmHavTwLCBjCJRCi-a6Z4TG_">The official YuNi Playlist</a>

# (NOW THIS repos HEAD)

Current wishlist

![Amazon(JP)](https://i.ytimg.com/vi/uy8cadKwuPk/hqdefault.jpg)

Amazon(JP) :
    <a href="https://www.amazon.co.jp/hz/wishlist/ls/1KSDJ67KVDVPS?ref_=wl_s">sapphire, Japanese Arch/Gentoo linux user @ Amazon(JP)</a>
