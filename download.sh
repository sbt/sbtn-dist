VER=1.4.0-M2

MAC_URL=https://ci.appveyor.com/api/buildjobs/ahrbl4qjo0jko1ci/artifacts/client%2Ftarget%2Fbin%2Fsbtn

WINDOWS_URL=https://ci.appveyor.com/api/buildjobs/77m655luaj8xencg/artifacts/client%2Ftarget%2Fbin%2Fsbtn.exe

LINUX_URL=https://ci.appveyor.com/api/buildjobs/g26p768sh4b90u76/artifacts/client%2Ftarget%2Fbin%2Fsbtn

# cd /tmp
# mkdir sbtn
# cd sbtn

mkdir darwin-amd64
mkdir linux-amd64
mkdir windows-amd64

curl -L $MAC_URL > darwin-amd64/sbtn
curl -L $LINUX_URL > linux-amd64/sbtn
curl -L $WINDOWS_URL > windows-amd64/sbtn.exe

cd darwin-amd64
chmod +x sbtn
tar czvf sbtn-darwin-amd64-$VER.tar.gz sbtn
mv sbtn-darwin-amd64-$VER.tar.gz ../
cd ../
gpg -u 0x642ac823 --detach-sign --armor sbtn-darwin-amd64-$VER.tar.gz

cd linux-amd64
chmod +x sbtn
tar czvf sbtn-linux-amd64-$VER.tar.gz sbtn
mv sbtn-linux-amd64-$VER.tar.gz ../
cd ../
gpg -u 0x642ac823 --detach-sign --armor sbtn-linux-amd64-$VER.tar.gz

cd windows-amd64
zip sbtn-windows-amd64-$VER.zip sbtn.exe
mv sbtn-windows-amd64-$VER.zip ../
cd ../
gpg -u 0x642ac823 --detach-sign --armor sbtn-windows-amd64-$VER.zip
