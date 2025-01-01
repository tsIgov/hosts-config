# Igov's host configurations
Contains personal host configurations. One per branch.

## How to deploy a configuration on a new machine
Execute the following script:
```
 curl -O https://raw.githubusercontent.com/tsIgov/hosts-config/main/deploy
 chmod 775 deploy
 ./deploy $(hostname)
 ```

## How to create a new host configuration

### 0. Prerequisites
You must have age and git-agecrypt installed.

### 1. Create new empty branch
Create a new empty branch by using this command `git switch --orphan <branch_name>`. Name your branch the same as the hostname.

### 2. Prepare an age key
In order for the configuration to be encrypted you need to provide an age key with the same name as the host inside the `~/.age/` directory. If you don't have one already, you can generate it with `age-keygen -o ~/.age/$(hostname)`.

### 3. Prepate the repository for encryption
1. Initialize the encryption by executing these commands at the root of the repository:
```bash
git-agecrypt init
git-agecrypt config add -i ~/.age/$(hostname)
```
2. Create a file called `git-agecrypt.toml` at the root of the repository with the following content (Replace `PUBLIC_KEY` with yours. You can find it by executing `cat ~/.age/$(hostname)`.):
```toml
[config]
"src/**" = ["PUBLIC_KEY"]
```
3. Create a file called `.gitattributes` at the root of the repository with the following content:
```
src/** filter=git-agecrypt diff=git-agecrypt
```

### 4. Allow symetric decryption
Encrypt the key file symetrically with a strong passphrase and and put it at the root of the repository in a file named `key`. You can do that by executing `age -e -p -o key ~/.age/$(hostname)` at the root of the branch.

### 5. Add your configuration
Add your flake in the `src` folder. Make sure to have the hostname of the nixos system configuration be the same as the branch name. 
