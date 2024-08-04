# GIO.sh

## how2use

get this shell script on your Linux Server, 

edit the varible in line 10/11/12, `SERVER_DIR="/genshin"` `VIAGENSHIN_GAMEPORT=1234` and `ORIGIN_GAMEPORT=20041` .

make sure that your GIO instance is in your `SERVER_DIR` folder like this:
```
SERVER_DIR
└── genshin
    ├── gateserver
    ├── gameserver
    ├── nodeserver
    ├── dbgate
    ├── dispatch (optional Dispatch Server)
    ├── newdispatch (optional Dispatch Server)
    ├── muipserver
    ├── multiserver
    ├── viagenshin (not exist in 3.2, but required in higher versions)
    ├── cokesdk (optional SDK Server)
    ├── gcsdk (optional SDK Server and Dispatch Server)
    ├── hk4e_emu (optional SDK Server and Dispatch Server)
    ├── jdk-17.0.12 (optional env for GCSDK)
    └── python3.9.13 (optional env for CokeSDK)

```

edit the start script in line 256~279, choose what SDK Server or Dispatch Server you will use. You can also edit the start scripts for server bins to modify Java or Python that server will use.

make sure that MySQL and Redis is running. if you use GCSDK, make sure that MongoDB is running.

make sure that your system has libASan5 and libPython2.7.

finally BASH it and enjoy it!

据说来自钟旭东