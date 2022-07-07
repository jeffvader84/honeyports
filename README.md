# HoneyPorts
HoneyPorts is a Active Cyber Defense/Deception tool

*Credit for structure of script/idea to John Strand and his training course, 'Active Defense & Cyber Deception.'*
*Overall idea came from course. This reflects my changes to his idea. Thanks, John!*

>HoneyPorts will open a port, wait for an attacker to attempt a TCP connection, and then blocks the IP Address at the local firewall.  This type of connection attempt is common during enumeration scans.  All activity is saved to a log file.

**Install, Setup, and Usage**
1. `sudo apt install git -y`
2. `git clone https://github.com/jeffvader84/honeyports`
3. `cd honeyports`
4. `sudo chmod +x honeyports.sh`
5. `sudo ./honeyports.sh -p <any port of your choice>`

*For Help run:*
`sudo ./honeyports.sh -h`
