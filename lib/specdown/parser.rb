module Specdown
  class Parser
    def self.parse(readme, lookups={})
      self.new(readme, lookups).parse
    end

    def initialize(readme, lookups={})
      @readme   = readme
      @lookups  = lookups
    end

    def parse
      kramdown = Kramdown::Document.new @readme, :input => "GithubMarkdown"
      build_tree kramdown.root.children
    end

    private
    def build_tree(parsed_elements)
      tree = Specdown::Tree.new
      scan_for_root_node parsed_elements
      tree.root = consume_section parsed_elements unless parsed_elements.empty?
      consume_children parsed_elements, tree.root unless parsed_elements.empty?
      tree
    end

    def consume_children(parsed_elements, current_parent)
      current_level = parsed_elements.first.options[:level] 
      raise "Specdown Parse Error: Detected multiple h1 headers in document." if current_level == 1

      unless parsed_elements.empty?
        current_parent.children << consume_section(parsed_elements, current_parent)
      end

      unless parsed_elements.empty?
        next_section_level = parsed_elements.first.options[:level]
        if next_section_level < current_level
          consume_children parsed_elements, current_parent.parent
        elsif next_section_level == current_level
          consume_children parsed_elements, current_parent
        else
          consume_children parsed_elements, current_parent.children.last
        end
      end
    end
    
    def consume_section(parsed_elements, parent=nil)
      node = Specdown::Node.new
      node.name = parsed_elements.shift.options[:raw_text]
      node.parent = parent

      while !parsed_elements.empty? && parsed_elements.first.type != :header
        element        = parsed_elements.shift

        if element.type == :codeblock && element.options["language"] == "ruby"
          node.code += "\n" + element.value.to_s.strip 

        elsif has_implicits?(element)
          gather_implicit_keys(element).each do |key|
            value = @lookups[key]

            if value
              node.code += "\n" + value
            else
              node.undefined_implicits << key
            end
          end
        end

        node.contents += element.value.to_s + element.children.map(&:value).join
      end
      node
    end

    def scan_for_root_node(parsed_elements)
      until parsed_elements.empty? || (
        parsed_elements.first.type == :header && parsed_elements.first.options[:level] == 1
      )
        parsed_elements.shift
      end
    end

    def has_implicits?(element)
      element.type == :strong || element.children.map {|child| has_implicits?(child) }.any?
    end

    def gather_implicit_keys(element)
      if element.type == :strong
        [element.children.map(&:value).compact.join(" ")]
      else
        element.children.map {|child| gather_implicit_keys(child)}.flatten
      end
    end
  end
end
