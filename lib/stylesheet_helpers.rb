module StylesheetHelpers
  def inline_amp_stylesheet(name)
    stylesheet = sprockets["#{name}.css"].to_s.gsub('@charset "UTF-8";','')
    "<style amp-custom>#{stylesheet}</style>"
  end
end
