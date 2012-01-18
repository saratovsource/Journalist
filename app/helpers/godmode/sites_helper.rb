module Godmode
  module SitesHelper
    def application_domain
      domain = Journalist.config.domain
      domain += ":#{request.port}" if request.port != 80
      domain
    end

    def error_on_domain(site, name)
      if (error = (site.errors[:domains] || []).detect { |n| n.include?(name) })
        content_tag(:span, error, :class => 'inline-errors')
      else
        ''
      end
    end

    def manage_subdomain_or_domains?
      Journalist.config.manage_subdomain? || Journalist.config.manage_domains?
    end

    def manage_subdomain?
      Journalist.config.manage_subdomain?
    end

    def manage_domains?
      Journalist.config.manage_domains?
    end

    def multi_sites?
      Journalist.config.multi_sites?
    end
  end
end