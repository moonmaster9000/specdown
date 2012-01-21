module Specdown
  class ImplicitParser
    def self.parse(*implicit_specifications)
      self.new(*implicit_specifications).parse
    end

    def initialize(*implicit_specifications)
      @specs = implicit_specifications
      @lookups = {}
    end

    def parse
      @specs.each do |spec|
        kramdown = Kramdown::Document.new spec, :input => "GithubMarkdown"
        build_lookup kramdown.root.children
      end

      @lookups
    end

    private
    def build_lookup(parsed_elements)
      scan_for_header parsed_elements
      consume_section parsed_elements until parsed_elements.empty? 
    end

    def consume_section(parsed_elements)
      key = parsed_elements.shift.options[:raw_text]
      value = ""

      while !parsed_elements.empty? && parsed_elements.first.type != :header
        element        = parsed_elements.shift
        value          += "\n" + element.value.to_s.strip if element.type == :codeblock && ([nil, "ruby", ""].include? element.options["language"])
      end

      @lookups[key] = value.strip
    end

    def scan_for_header(parsed_elements)
      until parsed_elements.empty? || (
        parsed_elements.first.type == :header
      )
        parsed_elements.shift
      end
    end
  end
end
