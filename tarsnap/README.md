# Tarsnap

    make install-tarsnap

This will only install `tarsnaprc` to `~/.tarsnaprc`.

If you're running tarsnap on Mac OS, you will probably need to run `tarsnap` with `sudo`, which means your root user needs a tarsnap conf, too. You can do this with a symlink, which the following make task does.

```
❯ make configure-tarsnap
```

## ACTS and scheduled backups on MacOS

https://github.com/alexjurkiewicz/acts

A sample acts.conf, LaunchDaemon, and newsyslog.d config file are present if you wish to use ACTS.

### ACTS conf

Make sure to update the backuptargets in this config to match what you want to back up. Be sure to use absolute paths.

```
❯ cp acts.conf /usr/local/etc/acts.conf
```

or

```
❯ make install-tarsnap-acts
```

### LaunchDaemon

Make sure the path to `acts` is correct in the first element of the `ProgramArguments` array. Make sure the log file specified in `StandardErrorPath` and `StandardOutPath` is what you want and matches the newsyslog conf. The schedule in the config specifies every day at 3am.

To configure and test this setup, use the following commands. You will need `sudo` most of the time.

```
❯ cp com.thomasupton.tarsnap-acts.plist /Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist
❯ chown root:wheel /Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist
❯ sudo launchctl unload /Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist && sudo launchctl load -w /Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist && sudo launchctl start com.thomasupton.tarsnap-acts
```

or

```
❯ make configure-tarsnap-acts-launch-daemon
```

Note that the `make` target does not actually start the `launchctl` item like the above manual command does.

### newsyslog conf

Make sure the log file in the newsyslog conf file matches the log file in the LaunchDaemon. Use the following commands to install the newsyslog config. You will need `sudo` most of the time.

```
❯ cp com.thomasupton.tarsnap-acts.conf /etc/newsyslog.d/com.thomasupton.tarsnap-acts.conf
❯ chown root:wheel /etc/newsyslog.d/com.thomasupton.tarsnap-acts.conf
❯ sudo newsyslog -nvv -f /etc/newsyslog.d/com.thomasupton.tarsnap-acts.conf # test newsyslog config
```

or

```
❯ make configure-tarsnap-acts-newsyslog
```
