require 'net/http'
require 'json'

def request(address, api_key)
    url = URI(address+api_key)
    
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    
    request = Net::HTTP::Get.new(url)
    
    response = https.request(request)
    JSON.parse response.read_body
end

def build_web_page(body)
    photos = body["photos"]
    
    top = 
    "<html>\n
    <title>Fotos de la NASA</title>\n
    <head>\n
    </head>\n
    <body>\n
    <h1>Bienvenid@, conoce fotos tomadas por la NASA en el espacio<h1>\n
    <ul>\n"
    
    photos.map {|x| top += "\t""<li><img src=#{x["img_src"]} width='200px'></li>""\n"}    
    
    final =
    "</ul>\n
    </body>\n
    </html>"

    html = top + final
    
    File.write('NASA_photos.html', html)
end

body = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000", "&api_key=0IKxbe4GcwTwCfJsbKzegTyslzF6NhVE1gHkgRgy&page=1")
build_web_page(body)