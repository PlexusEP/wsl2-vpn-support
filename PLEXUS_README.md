# Plexus Specific Installation Steps

## Inegrated Provisioning (EP-Expected workflow)
This repository is cloned when the [EP-maintained provisioning script](https://eng.plexus.com/git/projects/EP/repos/provisioning/browse) is invoked on WSL/2 instances to resolve DNS issues while on VPN.

No further actions is required by the consumer after executing that script to provision the WSL/2 host environment.

## Manual Provisioning (Not supported by EP)

Please follow these steps if you would like your system to automatically execute the WSL2 VPN
Configuration script each time a network connect or disconnect event occurs:

1. Make sure all files are located at c:\users\first.last\scripts

2. Run the installer.ps1 script. You may need to set your machine to execute unsigned powershell scripts with the command "set-executionpolicy bypass". If you do, change it back with "set-executionpolicy remotesigned" afterwards.

3. Make sure to do the WSL configuration below.


### WSL Configuration
Note, you may also need to configure DNS manually in the WSL2 guest. For Ubuntu proceed as follows:

1. Delete the previous /etc/resolv.conf with sudo rm /etc/resolv.conf

2. create and edit /etc/resolv.conf to contain:
   ```
   nameserver 10.255.63.254
   nameserver 8.8.8.8
   ```


3. Prevent WSL from generating resolv.conf, by adding the following to `/etc/wsl.conf`
   ```
   [network]
   generateResolvConf = false
   ```
   See [here](https://docs.microsoft.com/en-us/windows/wsl/wsl-config) for more details.

4. Restart WSL to apply the above changes


## Troubleshooting

### Task Scheduler
If your task is not working properly, Open "Event Viewer", Navigate to "Windows Logs" -> "System". Observe, which events are logged when your WSL starts. Take the fields "Log", "Source", "Event ID" from the logged event and use them as trigger for the task.
