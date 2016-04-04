module CdnHelper

  def prepend_cdn(path)
    if cdndomain.present?
      URI.join(cdndomain, path)
    else
      path
    end
  end

  def cdndomain
    ENV["CLOUDFRONT_DOMAIN"]
  end

end
