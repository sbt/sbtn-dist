VER=1.7.0-RC1

MAC_URL=https://github.com/sbt/sbtn-dist/releases/download/v${VER}/sbtn-x86_64-apple-darwin

WINDOWS_URL=https://github.com/sbt/sbtn-dist/releases/download/v${VER}/sbtn-x86_64-pc-win32.exe

LINUX_URL=https://github.com/sbt/sbtn-dist/releases/download/v${VER}/sbtn-x86_64-pc-linux

# cd /tmp
# mkdir sbtn
# cd sbtn

mkdir x86_64-apple-darwin
mkdir x86_64-pc-linux
mkdir x86_64-pc-win32

curl -L $MAC_URL > x86_64-apple-darwin/sbtn
curl -L $LINUX_URL > x86_64-pc-linux/sbtn
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

cd x86_64-pc-win32
zip sbtn-x86_64-pc-win32-$VER.zip sbtn.exe
mv sbtn-x86_64-pc-win32-$VER.zip ../
cd ../
gpg -u 0x642ac823 --detach-sign --armor sbtn-x86_64-pc-win32-$VER.zip
