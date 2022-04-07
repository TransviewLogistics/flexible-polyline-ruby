Gem::Specification.new do |s|
  s.name     = 'flexible_polyline'
  s.version  = '0.0.1'
  s.summary  = "Flexible polyline decoder"
  s.authors  = ["Headlight Solutions"]
  s.files    = %w[lib/flexible_polyline.rb lib/flexible_polyline/decoder.rb]
  s.homepage =
    'https://rubygems.org/gems/flexible_polyline'
  s.license  = 'MIT'
  s.add_development_dependency 'minitest', '~> 5.15'
  s.add_development_dependency 'simplecov', '~> 0.21.2'
end
