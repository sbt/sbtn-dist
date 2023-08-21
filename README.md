# sbtn-dist
Repository to trigger and/or hold sbtn, thin client for sbt. 

## Requirements:
- Java >= 8

## Setup repository

### Debian/Ubuntu

1. Add repository to sources list:
```bash
echo "deb [arch=all] https://repo.scala-sbt.org/scalasbt/debian all main" > /etc/apt/sources.list.d/scala-archive.list
```
2. Download and add our GPG key:
```bash
curl -sS "https://repo.scala-sbt.org/scalasbt/debian/scala-archive-keyring.gpg" > /etc/apt/trusted.gpg.d/scala-archive.gpg
```
3. Update package database:
```bash
sudo apt update
```

### RPM (Fedora, RHEL, CentOS)

1. Add repository to repository directory
```bash
curl -sS "https://repo.scala-sbt.org/scalasbt/rpm/scala-archive.repo" > /etc/yum.repos.d/scala-archive.repo"
```

2. Update package database
```bash
yum update
```

## Installation

Once the repository is set up, you can install packages with:

### Debian/Ubuntu

```bash
sudo apt install sbt
```

### RPM (Fedora, RHEL, CentOS)
```bash
sudo yum install sbt
```
