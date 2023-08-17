# wa2da

"Web App to Desktop App" (aka `wa2da`) is a simple script shell to download websites as desktop apps.

<br>
<h4>Requirements:</h4>

- `nativefier`

<br>


<h2>Usage:</h2>

To use the script, clone it, then run the `.sh` file:
```sh
git clone https://github.com/AinTEAsports/wa2da
cd wa2da
chmod +x ./wa2da.sh
```

<br></br>
Then you can run the script, like this:
```sh
./wa2da.sh <app_name> <website_url>
```
Where `<app_name>` is the name you want to give the app and where `<website_url>` is the website URL you want to "download".

<br>

Also, logs are in `/tmp/wa2da.log` (or in whatever you set in the variable `$LOG_FILE` in the script).
