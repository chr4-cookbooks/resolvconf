if defined? ChefSpec
  def create_resolvconf(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new :resolvconf, :create, resource_name
  end
end
