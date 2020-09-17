#
# Cookbook:: graphitus
# Provider:: instance
#
# Copyright:: 2014, Heavy Water Operations, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :create do
  d = directory ::File.dirname(new_resource.path) do
    recursive true
    action :create
  end
  new_resource.updated_by_last_action(d.updated_by_last_action?)

  g = git new_resource.path do
    repository new_resource.git_repository || node['graphitus']['git_repository']
    revision new_resource.git_revision || node['graphitus']['git_revision']
    depth 1
    action :sync
  end
  new_resource.updated_by_last_action(g.updated_by_last_action?)

  f = file ::File.join(new_resource.path, 'config.json') do
    content JSON.pretty_generate(new_resource.default_config.merge(new_resource.config).merge(graphiteUrl: new_resource.graphite_url))
    action :create
  end
  new_resource.updated_by_last_action(f.updated_by_last_action?)

  i = file ::File.join(new_resource.path, 'dashboard-index.json') do
    rows = { rows: new_resource.dashboards.keys.map { |id| { id: id } } }
    content JSON.pretty_generate(rows)
    action :create
  end
  new_resource.updated_by_last_action(i.updated_by_last_action?)

  new_resource.dashboards.each do |id, config|
    d = file ::File.join(new_resource.path, "#{id}.json") do
      content JSON.pretty_generate(config)
    end
    new_resource.updated_by_last_action(d.updated_by_last_action?)
  end
end

action :delete do
end
