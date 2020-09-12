graphitus_instance 'create-full' do
  path '/somewhere/else'
  graphite_url 'http://example.com/stats'
  dashboards([
    { name: 'awesome', refresh: 600 },
    { name: 'notascool', refresh: 1600 },
  ])
  git_repository 'a-git-repo'
  git_revision 'a-version'
  template_cookbook 'graphitus_wrapper'
  template_source 'my-custom-dashboards.js.erb'
  action :create
end

graphitus_instance '/tmp/yep'

graphitus_instance '/mnt/big' do
  action :delete
end
