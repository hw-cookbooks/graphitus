if defined?(ChefSpec)
  def create_graphitus_instance(name)
    ChefSpec::Matchers::ResourceMatcher.new(:graphitus_instance, :create, name)
  end

  def delete_graphitus_instance(name)
    ChefSpec::Matchers::ResourceMatcher.new(:graphitus_instance, :delete, name)
  end
end
