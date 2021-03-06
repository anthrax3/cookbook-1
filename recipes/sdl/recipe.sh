VERSION=1.2.15
TAR=https://www.libsdl.org/release/SDL-$VERSION.tar.gz
BUILD_DEPENDS=(liborbital)

export CFLAGS="-I$PWD/sysroot/include/"
export LDFLAGS="-L$PWD/sysroot/lib/"

function recipe_version {
    echo "$VERSION"
    skip=1
}

function recipe_update {
    echo "skipping update"
    skip=1
}

function recipe_build {
    ./autogen.sh
    ./configure --prefix=/ --host=${HOST} --disable-shared --disable-pulseaudio --disable-video-x11 --disable-loadso --disable-threads --enable-audio --enable-dummyaudio --enable-video-orbital --enable-cdrom
    make
    skip=1
}

function recipe_test {
    echo "skipping test"
    skip=1
}

function recipe_clean {
    make clean
    skip=1
}

function recipe_stage {
    dest="$(realpath $1)"
    make DESTDIR="$dest" install
    skip=1
}
