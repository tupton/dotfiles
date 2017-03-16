# Tarsnap

    make install-tarsnap

This will only install `tarsnaprc` to `~/.tarsnaprc`.

## ACTS and scheduled backups on MacOS

https://github.com/alexjurkiewicz/acts

A sample acts.conf, LaunchDaemon, and newsyslog.d config file are present if you wish to use ACTS.

### ACTS conf

Make sure to update the backuptargets in this config to match what you want to back up. Be sure to use absolute paths.

Copy `acts.conf` → `/usr/local/etc/acts.conf`

### LaunchDaemon

Make sure the path to `acts` is correct in the first element of the `ProgramArguments` array. Make sure the log file specified in `StandardErrorPath` and `StandardOutPath` is what you want and matches the newsyslog conf. The schedule in the config specifies every day at 3am.

Copy `com.thomasupton.tarsnap-acts.plist` → `/Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist`

    chown root:wheel /Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist
    sudo launchctl unload /Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist && sudo launchctl load -w /Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist && sudo launchctl start com.thomasupton.tarsnap-acts

### newsyslog conf

Make sure the log file in the newsyslog conf file matches the log file in the LaunchDaemon.

Copy `com.thomasupton.tarsnap-acts.conf` → `/etc/newsyslog.d/com.thomasupton.tarsnap-acts.conf`

    chown root:wheel /etc/newsyslog.d/com.thomasupton.tarsnap-acts.conf
    sudo newsyslog -nvv -f /etc/newsyslog.d/com.thomasupton.tarsnap-acts.conf # test newsyslog config
