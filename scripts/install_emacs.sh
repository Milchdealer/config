#!/usr/bin/env bash
# Downloads a specified version of emacs and tries to install it.
# Will fail if dependencies are missing.
# Basic run:
# >>> bash ./install_emacs.sh
# To change installation path or version, pass it as variables
# >>> INSTALL_PATH=/usr/local/emacs EMACS_VER=26.3 ./install_emacs.sh

INSTALL_PATH=${INSTALL_PATH:-${HOME}/Software/emacs}
URL=https://mirror.kumi.systems/gnu/emacs/
EMACS_VER=${EMACS_VER:-26.3}
FILE_NAME=emacs-${EMACS_VER}.tar.gz
SIG_NAME=${FILE_NAME}.sig

trap cleanup 0 1 2 3 6

cleanup() {
	rm $SIG_NAME $FILE_NAME gnu-keyring.gpg || echo "$FILE_NAME, $SIG_NAME or gnu-keyring.gpg doesn't exist"
	rm -r emacs-${EMACS_VER} || echo "emacs-${EMACS_VER} doesn't exist"
}

echo "Downloading emacs '${EMACS_VER}' from ${URL}"
curl ${URL}${FILE_NAME} -o ${FILE_NAME}
curl ${URL}${SIG_NAME} -o ${SIG_NAME}
# Alternatively, `git clone git://git.savannah.gnu.org/emacs.git` for latest

echo "Getting the GNU keyring"
curl https://ftp.gnu.org/gnu/gnu-keyring.gpg -o gnu-keyring.gpg
gpg --import gnu-keyring.gpg

echo "Verifying signature"
gpg --verify $SIG_NAME $FILE_NAME || exit 1

echo "Unpacking"
tar -zxf $FILE_NAME

echo "Installing emacs to ${INSTALL_PATH}"
mkdir -p $INSTALL_PATH
cd emacs-${EMACS_VER}
./configure --prefix=$INSTALL_PATH
make
make install
cd ..

echo "Done. You may want to add $INSTALL_PATH/bin to your PATH"
