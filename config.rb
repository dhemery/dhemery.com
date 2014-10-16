site = OpenStruct.new(YAML::load_file(File.join('data', 'site.yaml')))

Time.zone = site['timezone']

set :layout, :page
set :haml, {ugly: true}

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = 'dhemery.com'
  deploy.user   = 'dhemery'
  deploy.path   = '/srv/sites/dhemery.com'
  deploy.flags  = '-avz -e ssh --delete'
end

activate :directory_indexes

helpers do
  def relativize url
    uri = URI.parse(url)
    if uri.host == data.site.domain
      uri.route_from "http://#{data.site.domain}"
    else
      uri
    end
  end
end
