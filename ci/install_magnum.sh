if [ "$TRAVIS_OS_NAME" == "linux" ]; then
    sudo apt-get -qq update
    sudo apt-get install -y --no-install-recommends libglfw3-dev libglfw3 libopenal-dev

    # install Corrade
    git clone https://github.com/mosra/corrade.git
    cd corrade
    mkdir build && cd build
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make -j
    sudo make install
    cd ../..

    # install Magnum
    git clone https://github.com/mosra/magnum.git
    cd magnum
    mkdir build && cd build
    # Ubuntu
    cmake -DCMAKE_BUILD_TYPE=Release -DWITH_AUDIO=ON -DWITH_DEBUGTOOLS=ON -DWITH_GL=ON -DWITH_MESHTOOLS=ON -DWITH_PRIMITIVES=ON -DWITH_SCENEGRAPH=ON -DWITH_SHADERS=ON -DWITH_TEXT=ON -DWITH_TEXTURETOOLS=ON -DWITH_TRADE=ON -DWITH_GLFWAPPLICATION=ON -DWITH_WINDOWLESSGLXAPPLICATION=ON -DWITH_OPENGLTESTER=ON -DWITH_ANYAUDIOIMPORTER=ON -DWITH_ANYIMAGECONVERTER=ON -DWITH_ANYIMAGEIMPORTER=ON -DWITH_ANYSCENEIMPORTER=ON -DWITH_MAGNUMFONT=ON -DWITH_OBJIMPORTER=ON -DWITH_TGAIMPORTER=ON -DWITH_WAVAUDIOIMPORTER=ON ..
    make -j
    sudo make install
    cd ../..

    # install MagnumPlugins
    git clone https://github.com/mosra/magnum-plugins.git
    cd magnum-plugins
    mkdir build && cd build
    cmake -DCMAKE_BUILD_TYPE=Release -DWITH_ASSIMPIMPORTER=ON -DWITH_DDSIMPORTER=ON -DWITH_JPEGIMPORTER=ON -DWITH_OPENGEXIMPORTER=ON -DWITH_PNGIMPORTER=ON -DWITH_TINYGLTFIMPORTER=ON -DWITH_STBTRUETYPEFONT=ON ..
    make -j
    sudo make install
    cd ../..

    # install MagnumIntegration
    git clone https://github.com/mosra/magnum-integration.git
    cd magnum-integration
    mkdir build && cd build
    cmake -DCMAKE_BUILD_TYPE=Release -DWITH_DART=ON -DWITH_EIGEN=ON ..
    make -j
    sudo make install
    cd ../..

    sudo ldconfig
    cd $CI_HOME
else
    sudo xcode-select -r
    # We need a newer version than 2019.10 for Magnum
    HOMEBREW_NO_AUTO_UPDATE=1 brew install --HEAD mosra/magnum/corrade
    HOMEBREW_NO_AUTO_UPDATE=1 brew install --HEAD mosra/magnum/magnum
    HOMEBREW_NO_AUTO_UPDATE=1 brew install --HEAD mosra/magnum/magnum-plugins --with-assimp
    HOMEBREW_NO_AUTO_UPDATE=1 brew install --HEAD mosra/magnum/magnum-integration --with-dartsim --with-eigen
fi
