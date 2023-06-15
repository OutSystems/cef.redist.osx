TMP="tmp-$1"
OUTPUT="../package-$1"

if [ "$1" == "osx64" ]; then 
    DOWNLOAD_URL="https://cef-builds.spotifycdn.com/cef_binary_112.3.0%2Bgb09c4ca%2Bchromium-112.0.5615.165_macosx64_minimal.tar.bz2"; else
    DOWNLOAD_URL="https://cef-builds.spotifycdn.com/cef_binary_112.3.0%2Bgb09c4ca%2Bchromium-112.0.5615.165_macosarm64_minimal.tar.bz2";
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
    curl -o "$CEFZIP" "https://cef-builds.spotifycdn.com/cef_binary_112.3.0%2Bgb09c4ca%2Bchromium-112.0.5615.165_$ARCH_minimal.tar.bz2"
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
