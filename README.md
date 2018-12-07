# STT

run application
```bash
ruby myapp.rb
```



## Configuration

Make a copy of the `.env.example` file and name it `.env`. This can be done with the following command as well: `cp .env.example .env`.

Then update the changes in the file according to your setup.

```bash
HTTP_CONVERTER_HTTP=http
HTTP_CONVERTER_HOST=localhost
HTTP_CONVERTER_PORT=4000
HTTP_CONVERTER_PATH=/


HTTP_TV_HTTP=http
HTTP_TV_HOST=172.16.2.151
HTTP_TV_PORT=
HTTP_TV_PATH=/api/image
```

Or you can change the setting in your terminal:

`HTTP_TV_HTTP=http HTTP_TV_HOST=172.16.2.151 HTTP_TV_PORT... ruby myapp.rb`