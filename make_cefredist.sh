TMP="tmp-$1"
OUTPUT="../package-$1"

if [ "$1" == "osx64" ]; then 
    ARCH="macosx64";
else
    ARCH="macosarm64";
fi

if [ ! -d "$TMP" ]; then
    mkdir "$TMP"
fi

cd "$TMP"

rm -rf "$OUTPUT"
mkdir "$OUTPUT"
mkdir "$OUTPUT/CEF"
mkdir "$OUTPUT/CEF/Resources"

CEFZIP="cef.tar.bz2"
CEFBINARIES="cef_binaries"

if [ ! -f "$CEFZIP" ]; then
    echo "downloading cef binaries"
    curl -o "$CEFZIP" "https://cef-builds.spotifycdn.com/cef_binary_121.3.13%2Bg5c4a81b%2Bchromium-121.0.6167.184_{$ARCH}_minimal.tar.bz2"
fi

if [ ! -d "$CEFBINARIES" ]; then
    echo "unzipping cef binaries"
    mkdir "$CEFBINARIES"
    tar -jxvf "$CEFZIP" -C "./$CEFBINARIES"
fi

CEFFRAMEWORK_DIR="$(find $CEFBINARIES -name "Release")/Chromium Embedded Framework.framework"

cp "$CEFFRAMEWORK_DIR/Chromium Embedded Framework" "$OUTPUT/CEF/libcef.dylib"
cp "$CEFFRAMEWORK_DIR/Libraries/"* "$OUTPUT/CEF/"
cp "$CEFFRAMEWORK_DIR/Resources/"* "$OUTPUT/CEF/Resources/"
cp "$CEFFRAMEWORK_DIR/Resources/en.lproj/"* "$OUTPUT/CEF/Resources/"
