require "csv_box/version"
require "csv"

module CSVBox
  def self.add(box, &block)
    @boxmap ||= {}
    @boxmap.store(box, block)
  end
  
  def self.box_names
    @boxmap.keys
  end

  def self.take(box, layout)
    box_layout = @layoutmap.fetch(box)
    Box.new(@boxmap.fetch(box), box_layout.fetch(layout))
  end

  def self.layouts(name, &block)
    @layoutmap ||= {}

    layout = Layout.new
    layout.instance_eval(&block)

    @layoutmap.store(name, layout)
  end

  class Layout
    def layout(feature, &block)
      @featuremap.store(feature, block)
    end

    def fetch(layout)
      @featuremap.fetch(layout)
    end

    def initialize
      @featuremap = {}
    end
  end

  class Box
    def initialize(fields, layout)
      @csv = CSV::Table.new([])
      @rows = []
      @layout = layout

      instance_eval(&fields)
    end

    def <<(record)
      @cache = record
      @headers = []
      @fields = []

      instance_exec(self, &@layout)

      @rows << CSV::Row.new(@headers, @fields)
    end

    def to_csv
      return @raw if @raw

      @rows.each do |row|
        @csv << row
      end

      @raw = @csv.to_csv
    end

    private

    def field(field_name)
      define_singleton_method field_name do
        @headers << field_name
        @fields << @cache.public_send(field_name)
      end
    end
  end
end
