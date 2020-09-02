#
# Cookbook:: graphitus
# Resource:: instance
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

actions :create, :delete
default_action :create

attribute :path, kind_of: String, name_attribute: true
attribute :graphite_url, kind_of: [String, NilClass], required: true
attribute :config, kind_of: Hash, default: {}
attribute :dashboards, kind_of: Hash, default: {}
attribute :git_repository, kind_of: String
attribute :git_revision, kind_of: String
attribute :template_cookbook, kind_of: String, default: 'graphitus'
attribute :template_source, kind_of: String, default: 'config.js.erb'

def default_config
  {
    dashboardListUrl: 'dashboard-index.json',
    dashboardUrlTemplate: '${dashboardId}.json',
    eventsUrl: 'events.json?start=<%=start%>&end=<%=end%>',
    eventsDateFormat: 'HH:mm:ss DD/MM/YYYY',
    eventsTimezone: 'US/Eastern',
    minimumRefresh: 30,
    metricsQueryUrl: 'http://my.graphite.com/metrics/find?format=completer&query=',
    timezones: ['UTC', 'US/Eastern', 'US/Central', 'US/Pacific', 'Europe/London'],
  }
end
