lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'present_me/version'

Gem::Specification.new do |gem|
  gem.name          = "present_me"
  gem.version       = PresentMe::VERSION
  gem.authors       = ["Federico Iachetti"]
  gem.email         = ["iachetti.federico@gmail.com"]
  gem.description   = %q{Allows you to do presentations using xmpfilter}
  gem.summary       = %q{Allows you to do presentations using xmpfilter}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  #gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = [lib]

end
