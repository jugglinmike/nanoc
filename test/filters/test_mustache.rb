# encoding: utf-8

class Nanoc::Filters::MustacheTest < Nanoc::TestCase

  def test_filter
    if_have 'mustache' do
      # Create item
      item = Nanoc::Item.new(
        'content',
        { :title => 'Max Payne', :protagonist => 'Max Payne' },
        '/games/max-payne/'
      )

      # Create filter
      filter = ::Nanoc::Filters::Mustache.new({ :item => item })

      # Run filter
      result = filter.setup_and_run('The protagonist of {{item.title}} is {{item.protagonist}}.')
      assert_equal('The protagonist of Max Payne is Max Payne.', result)
    end
  end

  def test_filter_with_yield
    if_have 'mustache' do
      # Create item
      item = Nanoc::Item.new(
        'content',
        { :title => 'Max Payne', :protagonist => 'Max Payne' },
        '/games/max-payne/'
      )

      # Create filter
      filter = ::Nanoc::Filters::Mustache.new(
        { :content => 'No Payne No Gayne', :item => item })

      # Run filter
      result = filter.setup_and_run('Max says: {{yield}}.')
      assert_equal('Max says: No Payne No Gayne.', result)
    end
  end

  def test_with_helpers
    if_have 'mustache' do
      item = Nanoc::Item.new(
        'content',
        { :title => 'Max Payne', :protagonist => 'Max Payne' },
        '/games/max-payne/'
      )

      # Create filter
      filter = ::Nanoc::Filters::Mustache.new({ :item => item })

      g = {}
      def g.shout(x)
        x + '!'
      end

      # Run filter
      result = filter.setup_and_run '{{#helpers.shout}}X{{/helpers.shout}}', :helpers => g
      assert_equal('X!', result)
    end
  end

end
