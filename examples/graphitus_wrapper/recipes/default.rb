include_recipe 'apache2'

dashboards_hash = {
  'system.profile' => {
    title: 'System Profile',
    columns: 2,
    user: 'erez',
    timeBack: '3h',
    from: '',
    until: '',
    width: 500,
    height: 250,
    legend: true,
    refresh: true,
    refreshIntervalSeconds: 30,
    averageSeries: false,
    defaultLineWidth: 2,
    defaultParameters: 'hideLegend=true',
    data: [
      {
          title: 'CPU Utilization',
          target: '*.system.cpu.*',
          description: 'CPU time spent in various states',
      },
      {
          title: 'Network Traffic',
          target: 'derivative(*.system.net.*.*)',
          params: 'areaMode=stacked',
      },
      {
          title: 'Free Memory',
          target: '*.system.memory.free',
          params: 'hideLegend=false',
      },
    ],
    parameters: {
      datacenter: {
        'All' => {
          'dc' => '*',
        },
        'New York' => {
          'dc' => 'ny',
        },
          'LA' => {
            'dc' => 'la',
        },
          'Chicago' => {
          'dc' => 'chi',
        },
      },
    },
  },
}

graphitus_instance '/srv/www/graphitus' do
  graphite_url 'http://127.0.0.1'
  config({ minimumRefresh: 20 })
  dashboards dashboards_hash
end

template "#{node['apache']['dir']}/sites-available/graphitus" do
  source 'graphitus-vhost.conf.erb'
  notifies :reload, 'service[apache2]'
end

apache_site 'graphitus'
