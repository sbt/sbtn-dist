VER=1.4.0

MAC_URL=https://ci.appveyor.com/api/buildjobs/1npeninn3pvcq35f/artifacts/client%2Ftarget%2Fbin%2Fsbtn

LINUX_URL=https://ci.appveyor.com/api/buildjobs/uuw349v7uvll3n39/artifacts/client%2Ftarget%2Fbin%2Fsbtn

WINDOWS_URL=https://ci.appveyor.com/api/buildjobs/eh5ngoeaqs68u7ml/artifacts/client%2Ftarget%2Fbin%2Fsbtn.exe

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
