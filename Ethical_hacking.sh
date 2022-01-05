# Project Name   - Ethical_hacking.sh
# Author Name    - Md. Samir Amin
# Author E-mail  - samiramin.cse.52@gmail.com
# Created On     - 01/05/22, 01:51:01 PM

#! /bin/sh
echo "# Ethical hacking - Network Hacking
-----------------------------------
1.  iwconfig                    -   to see wireless interfaces [Managed/Monitor] Mode.
2.  ifconfig wlan0 down         -   command is Used for disabling the [Managed] Mode.
3.  airmon-ng check kill        -   is used to kill any process that could interfare with using my interface in [Monitor] Mode.
4.  iwconfig wlan0 mode monitor -   is used to enable Monitor Mode.
5.  ifconfig wlan0 up           -   command is used to enable the interface.
6.  iwconfig                    -   command shows that the mode is set to monitor.
7.  airodump-ng [wlan0]         -   airdump-ng is used to list all the network around us and display useful information about them.

                (i)     BSSID   -                        shows the MAC address of the target network.
                (ii)    PWR     -                        shows the signal strength of the network. Higher the number has better signal.
                (iii)   Beacons -                        are the frames send by the network in order to broadcast its existence.
                (iv)    #Data   -                        shows the number of data packets or the number of data frames.
                (v)     #/s     -                        shows the number of data packets that we collect in the past 10 seconds.
                (vi)    CH      -                        shows the channel on which the network works on.
                (vii)   ENC     -                        shows the encryption used by the network. It can be WEP, OPN, WPA, WPA2.
                (viii)  CIPHER  -                        shows the cipher used in the network.
                (ix)    AUTH    -                        shows the authentication used on the network.
                (x)     ESSID   -                        shows the name of the network.

8.  airodump-ng --bssid mac:address --channel no --write test wlan0

                (i)     --bssid      -                   mac:address is the access point MAC address.
                                                         It is used to eliminate extraneous traffic.

                (ii)    --channel no -                   is the channel for airodump-ng to snif on.
                (iii)   --write test -                   is used to store all the data in a file named as test. It is not mandatory,
                                                         you can skip this part.

                (iv)    wlan0        -                   is the interface name in Monitor mode.

    After execution of this command, the following devices will be shown:

                (i)     BSSID   -                         of all the devices is same because devices are connected to the same network.
                (ii)    STATION -                         shows the number of devices that are connected to this network.
                (iii)   PWR     -                         shows the power strength of each of the devices.
                (iv)    Rate    -                         shows the speed.
                (v)     Lost    -                         shows the amount of data loss.
                (vi)    Frames  -                         show the number of frames that we have captured.

9.  Deauthenticate the wireless client:
    -----------------------------------
    It is also known as deauthentication attacks. These attacks are very useful. These attacks allow us to disconnect
    any device from any network that is within our range even if the network has encryption or uses a key.

    code : aireplay-ng --deauth [#DeauthPackets/Beacons] -a [NetworkMac] -c [TargetMac] [Interface]
    EXP  : aireplay-ng --deauth 100000 -a 50:C8:E5:AF:F6:33 -c A8:7D:12:30:E9:A4 wlan0

                (i)     -deauth     -       is used to tell airplay-ng that we want to run a deauthentication attack and assign 100000 which is the number   of
                                            packets so that it keeps sending a deauthentication packets to both the router and client and keep the client disconnected.

                (ii)    -a          -       is used to specify the MAC address of the router. 50:C8:E5:AF:F6:33 is the target access point AP.
                (iii)   -c          -       specifies the MAC address of the client. A8:7D:12:30:E9:A4 is client's MAC address that we want to disconnect.
                (iv)    wlan0       -       is the wireless adaptor in Monitor mode.

10. Gaining Access :
    ----------------

    Gaining access attack is the second part of the network penetration testing. In this section, we will connect to the network.
    If the network uses encryption, we can't get anywhere unless we decrypt it. In this section, we will discuss that how to break
    that encryption and how to gain access to the networks whether they use WEP/WPA/WPA2.

    1. WEP Introduction.             2.Basic WEP cracking.                3.Fake authentication attack.        4.ARP request replay.
    5. WPA theory.                   6.Handshake theory.                  7.Capturing handshakes.              8.Creating wordlists.
    9.Wordlist cracking.


    1. WEP Introduction
       ----------------
    => In this section, we will discuss WEP (Wired Equivalent Privacy). It is the oldest one, and it can be easily broken.
       WEP uses the algorithm called RC4 encryption. In this algorithm, each packet is encrypted at the router or access point
       and then send out into the air. Once the client receives this packet, the client will be able to transform it back to
       its original form because it has the key. In other words, we can say that the router encrypts the packet and send it,
       and the client receives and decrypts it.

       Each packet that is sent into the air has a unique keystream. The unique keystream is generated using a 24- bit IV
       (Initialization Vector).The weakness with the IV is that it is sent in the pain text and it is very short(only 24- bit).
       The IV will start repeating on a busy network. The repeated IVs can be used to determine the key stream. This makes WEP
       vulnerable to statistical attacks.

       To determine the key stream we can use a tool called as [ aircrack-ng ]. This tool is used to determine the key stream.
       Once we have enough repeated IV, then it will also be able to crack WEP and give us the key to the network.

    2.Basic WEP Cracking
    --------------------
    => In order to crack WEP, we need first to capture the large number of packets that means we can capture a large number of IVs.
       Once we have done that, we will use a tool called aircrack-ng.

       This method is going to be better when we have more than two packets, and our chances of breaking the key will be higher.

        Commands :
        ---------

                    airodump-ng wlan0 -     to see all of the networks that are within our Wi-Fi range and then we will target one of those networks.
                    airodump-ng -bssid TargetMac --channel no --write wep wlan0
                    ls
                    aircrack-ng wep-02.cap

   ***** This is how we crack tha wep Security from router.*****

   3. Fake authentication attack :
      ----------------------------
      => One problem that we could face is if the network is not busy. If the network is not busy, the number of data will be
         increasing very very slowly. At that time we're going to fake as an AP that doesn't have any clients connected to it
         or an AP that has a client connected to it, but the client is not using the network as heavily as the client in the previous section.

         If there are no clients connected and the #Data is 0, it didn't even go to 1. we use fake AP to data set to 1.

      Commands:
      ---------
      aireplay-ng --fakeauth 0 -a 74:DA:DA:DB:F7:67 -h 10:F0:05:87:19:32 wlan0  [10:F0:05:87:19:32] own mac address [iwconfig]

    4. ARP request replay :
       --------------------
                airodump-ng --bssid 74:DA:DA:DB:F7:67 [TargetMac] --write arp-request-replay-test wlan0
                aireplay-ng --arpreplay -b TargetMac -h OwnMac wlan0
                ls
                aircrack-ng arp-request-replay-test-01.cap

    5. WPA Theory:
       ----------
        => In this section, we are going to discuss Wi-Fi Protected Access(WPA) encryption. After WEP, this encryption was
           designed to address all of the issues that made WEP very easy to crack. In WEP, the main issue is the short IV,
           which is sent as plain text in each packet. The short IV means that the possibility of having a unique IV in each
           packet can be exhausted in active network so that when we are injecting packets, we will end up with more than one
           packet that has the same IV. At that time, aircrack-ng can use statistical attacks to determine the key stream and
           WEP key for the network.

           In WPA, each packet is encrypted using a temporary key or unique key. It means that the number of data packets
           that we collect is irrelevant. If we collect one million packets, these packets are also not useful because they
           do not contain any information that we can use to crack the WPA key. WPA2 is the same as WPA. It works with the same
           methods and using the same method it can be cracked. The only difference between WPA, WPA2 is that WPA2 uses an algorithm
           called Counter-Mode Cipher Block Chaining Message Authentication Code Protocol (CCMP) for encryption.

    6. Handshake theory :
       -----------------
        => In WPA, each packet is encrypted using a unique temporary key. It is not like WEP, where IVs are repeated,
           and we collect a large number of data packets with the same IVs. In each WPA packet, there is a unique temporary IV,
           even if we collect 1 million packets, these packets will not be useful for us. These packets don?t contain any information
           that can help us to determine the actual WPA key.

           The only packets that contain useful information and help us to determine the key are the handshake packets.
           These are the four packets, and these packets will be sent when a new device connects to the target network.
           For example, suppose we are at home, our device connect to the network using the password, and a process called
           four-way handshake happens between the AP and the devices. In this process, four packets called the handshake packets,
           get transferred between the two devices, to authenticate the device connection. We can use a wordlist using the aircrack-ng
           and test each password in the wordlist by using the handshake.

           To crack WPA encrypted network, we need two things: we need to capture the handshake,
           and we need a wordlist that contains passwords.

    7.Capturing handshakes :
      ----------------------
                     Commands:
                    <=========>

                            airodump-ng wlan0
                            airodump-ng --bssid TargetMac --channel no --write wap_handshake wlan0

        We can capture the handshake in two ways. First, we can just sit down and wait for a device to connect to the network.
        Once a device is connected then we can capture the handshake. Second, we can use deauthentication attack which we learned
        in the previous section, in Pre-connection attacks section.

        In a deauthentication attack, we can disconnect any device form a network that is within our Wi-Fi range.
        If we apply this attack for a very short period of time, we can disconnect a device form the network for a second,
        the device will try to connect to the network automatically, and even the person using the device will not notice
        that the device is disconnected or reconnected. Then we will be able to capture the handshake packets.
        The handshake gets sent every time a device connects to a target network.

                     Commands:
                    <=========>


                            aireplay-ng --deauth 3 or 4 -a TargetMac -c StationMac wlan0

    8. Creating Wordlist
       -----------------
       => Now we've captured the handshake, all we need to do is create a wordlist to crack the WPA key.
          A wordlist is just a list of words that aircrack-ng is going to go through, and trying each one against the handshake
          until it successfully determines the WPA key. If the wordlist is better, the chances of cracking the WPA key will be higher.
          If the password is not in our wordlist file, we will not be able to determine the WPA key.

                    crunch [min] [max] [characters] -o [FileName]
                    or
                    crunch [min] [max] [characters] -t [pattern] -o [FileName]

                                    crunch is the name of the tool.
                                    [min] specifies the minimum number of characters for the password to be generated.
                                    [max] specifies the maximum number of characters for the password.

        characters specify the characters that we want to use in the password. For example, you can put all lowercase characters,
        all uppercase characters, numbers, and symbols.

                            (i) -t is optional. It specifies the pattern.
                            (ii) -o option specifies the filename where the passwords are going to be stored.

    9.Wordlist cracking
      -----------------
        => To crack WPA or WPA2, we need to first capture the handshake from the target AP and second have a wordlist
           which contains a number of passwords.
           that we are going to try. Now we've captured the handshake, and we have a wordlist ready to use.

                            aircrack-ng wpa_hanshake_01.cap -w pass.txt

        **** This is how we can crack WPA/WPA-PSK encrypted Protected password ****
"
