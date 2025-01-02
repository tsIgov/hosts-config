# Igov's host configurations
Contains personal host configurations.

## How to deploy a configuration on a new machine
Execute the following script:
```
 curl -O https://raw.githubusercontent.com/tsIgov/hosts-config/main/deploy.sh
 chmod 755 deploy.sh
 ./deploy.sh $(hostname)
 ```

## How to create a new host configuration
1. Create a new branch from `main` bearing the name of the host.
2. Execute the `init-branch.sh` script.
3. Provide a strong passphrase when prompted.
4. Add your flake in the `src` folder. Make sure to have the hostname of the nixos system configuration be the same as the branch name. 
