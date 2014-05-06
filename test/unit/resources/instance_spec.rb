require_relative '../spec_helper'

describe "graphitus_instance resource" do
  let(:chef_run) do
    ChefSpec::Runner.new{|node|
      node.set['graphitus']['git_repository'] = "node_repo"
      node.set['graphitus']['git_revision'] = "node_revision"
    }.converge("fixtures::graphitus_instance")
  end

  context "for create action" do
    it "sets all the attributes" do
      expect(chef_run).to create_graphitus_instance("create-full").with(
        path: "/somewhere/else",
        graphite_url: "http://example.com/stats",
        dashboards: [
          { name: "awesome", refresh: 600 },
          { name: "notascool", refresh: 1600 },
        ],
        git_repository: "a-git-repo",
        git_revision: "a-version",
        template_cookbook: "graphitus_wrapper",
        template_source: "my-custom-dashboards.js.erb"
      )
    end

    it "enforces defaults" do
      expect(chef_run).to create_graphitus_instance("/tmp/yep").with(
        path: "/tmp/yep",
        graphite_url: nil,
        dashboards: [],
        git_repository: nil,
        git_revision: nil,
        template_cookbook: "graphitus",
        template_source: "dashboards.js.erb"
      )
    end
  end

  context "for delete action" do
    it "deletes the instance" do
      expect(chef_run).to delete_graphitus_instance("/mnt/big")
    end
  end
end
