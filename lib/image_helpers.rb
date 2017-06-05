module ImageHelpers
  # Embed SVG images inline within a Middleman template.
  # Adapted from the work of James Martin and Steven Harley.
  # References:
  # https://robots.thoughtbot.com/organized-workflow-for-svg
  # https://gist.github.com/bitmanic/0047ef8d7eaec0bf31bb
  def inline_svg(filename, options = {})

    asset = sprockets.find_asset(filename)

    if asset.nil?
      %(
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 30"
          width="400px" height="30px"
        >
          <text font-size="16" x="8" y="20" fill="#cc0000">
            Error: '#{filename}' could not be found.
          </text>
          <rect
            x="1" y="1" width="398" height="28" fill="none"
            stroke-width="1" stroke="#cc0000"
          />
        </svg>
      )
    else
      file = asset.source.force_encoding("UTF-8")
      doc = Nokogiri::HTML::DocumentFragment.parse file
      doc.css('*').remove_attr('style')
      doc.css('*').remove_attr('width')
      doc.css('*').remove_attr('height')
      svg = doc.at_css "svg"
      svg["class"] = options[:class] if options[:class].present?
      doc
    end
  end

  def amp_image(path, options = {})

    #FIXME: Add support for srcset
    #FIXME: Add support for sprockets loading of asset

    return "" unless path
    options[:src] = "assets/images/#{path}"
    image_size = FastImage.size("source/#{options[:src]}")
    options[:width] = image_size[0].to_s
    options[:height] = image_size[1].to_s
    options[:alt] ||= File.basename(options[:src])
    attributes = options.map { |k,v| "#{k}=\"#{v}\"" }.join(' ')
    "<amp-img #{attributes}></amp-img>"
  end

  def amp_remote_image(url, options = {})
    begin
      options[:src] = url
      image_size = FastImage.size(options[:src])
      options[:width] = image_size[0].to_s
      options[:height] = image_size[1].to_s
      options[:alt] ||= ''
      attributes = options.map { |k,v| "#{k}=\"#{v}\"" }.join(' ')
      "<amp-img #{attributes}></amp-img>"
    rescue
      ""
    end
  end

end
