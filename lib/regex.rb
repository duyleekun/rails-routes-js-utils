class Regexp
  def to_javascript
    Regexp.new(inspect.sub('\\A','^').sub('\\Z','$').sub('\\z','$').sub(/^\//,'').sub(/\/[a-z]*$/,'').gsub(/\(\?#.+\)/, '').gsub(/\(\?-\w+:/,'(').gsub(/\(\(\(([^()]*)\)\)\)/,"(?:(?:(\\1)))").gsub(/\(\(([^()]*)\)\)/,"(?:(\\1))"), self.options).inspect
  end
end