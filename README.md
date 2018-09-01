- install

```
curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-SoftEtherVPN/master/docker-compose.yaml -o $PWD/docker-compose.yaml
docker-compose -f $PWD/docker-compose.yaml up -d
```

When the container starts, you need to download the SoftEther VPN Server.

The first link will reset the password and then simply configure it.

1

You need to set the ip address, port 443 default

Then you don't need to enter a password, reset the password in the pop-up dialog box.

![1](https://raw.githubusercontent.com/LinuxEA-Mark/docker-SoftEtherVPN/master/img/1.png)

2

But after the save is complete

Click to connect

![2](https://raw.githubusercontent.com/LinuxEA-Mark/docker-SoftEtherVPN/master/img/2.png)

3

But after the connection is successful, click on "Manage Virtual HUB(A)", in the figure 1

Then in the figure 2, "virtual NAT and virtual DHCP server (v)", click the button

Next in the figure 3, start SecureNAT (E)

If you need to add users at this moment, click on the picture (4), "Manage Users (U)"

![3](https://raw.githubusercontent.com/LinuxEA-Mark/docker-SoftEtherVPN/master/img/3.png)

3

Among them, "manage user button" --> "new (C)", fill in the username and password

![4](https://raw.githubusercontent.com/LinuxEA-Mark/docker-SoftEtherVPN/master/img/4.png)


Then, you need to download a SoftEter VPN client and fill in the created user information for authentication.

![5](https://raw.githubusercontent.com/LinuxEA-Mark/docker-SoftEtherVPN/master/img/5.png)
