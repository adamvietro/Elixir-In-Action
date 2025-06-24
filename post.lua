-- post.lua
wrk.method = "POST"
wrk.body = "list=bob&date=2023-12-19&title=Dentist"
wrk.headers["Content-Type"] = "application/x-www-form-urlencoded"
