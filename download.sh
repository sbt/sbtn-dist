VER=1.8.0

BASE_URL=https://github.com/sbt/sbtn-dist/releases/download/v${VER}

MAC_URL=$BASE_URL/sbtn-x86_64-apple-darwin

WINDOWS_URL=$BASE_URL/sbtn-x86_64-pc-win32.exe

LINUX_X86_64_URL=$BASE_URL/sbtn-x86_64-pc-linux

LINUX_AARCH64_URL=$BASE_URL/sbtn-aarch64-pc-linux

# cd /tmp
# mkdir sbtn
# cd sbtn

mkdir x86_64-apple-darwin
mkdir x86_64-pc-linux
mkdir aarch64-pc-linux
mkdir x86_64-pc-win32

curl -L $MAC_URL > x86_64-apple-darwin/sbtn
curl -L $LINUX_X86_64_URL > x86_64-pc-linux/sbtn
curl -L $LINUX_AARCH64_URL > aarch64-pc-linux/sbtn
curl -L $WINDOWS_URL > x86_64-pc-win32/sbtn.exe

cd x86_64-apple-darwin
chmod +x sbtn
tar czvf sbtn-x86_64-apple-darwin-$VER.tar.gz sbtn
mv sbtn-x86_64-apple-darwin-$VER.tar.gz ../
cd ../
gpg -u 0x642ac823 --detach-sign --armor sbtn-x86_64-apple-darwin-$VER.tar.gz

cd x86_64-pc-linux
chmod +x sbtn
tar czvf sbtn-x86_64-pc-linux-$VER.tar.gz sbtn
mv sbtn-x86_64-pc-linux-$VER.tar.gz ../
cd ../
gpg -u 0x642ac823 --detach-sign --armor sbtn-x86_64-pc-linux-$VER.tar.gz

cd aarch64-pc-linux
chmod +x sbtn
tar czvf sbtn-aarch64-pc-linux-$VER.tar.gz sbtn
mv sbtn-aarch64-pc-linux-$VER.tar.gz ../
cd ../
gpg -u 0x642ac823 --detach-sign --armor sbtn-aarch64-pc-linux-$VER.tar.gz

cd x86_64-pc-win32
zip sbtn-x86_64-pc-win32-$VER.zip sbtn.exe
mv sbtn-x86_64-pc-win32-$VER.zip ../
cd ../
gpg -u 0x642ac823 --detach-sign --armor sbtn-x86_64-pc-win32-$VER.zip
