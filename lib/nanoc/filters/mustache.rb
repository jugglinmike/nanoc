# encoding: utf-8

module Nanoc::Filters

  # @since 3.2.0
  class Mustache < Nanoc::Filter

    requires 'mustache'

    # Runs the content through
    # [Mustache](http://github.com/defunkt/mustache). This method takes no
    # options.
    #
    # @param [String] content The content to filter
    # @param [Hash] params TODO: Document
    #
    # @return [String] The filtered content
    def run(content, params = {})
      context = params.merge({
        :item => item.attributes(),
        :yield => assigns[:content],
        :config => assigns[:config]
      })

      ::Mustache.render(content, context)
    end

  end

end
