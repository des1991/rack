class TimeFormatter

  DATE_TIME_FORMAT = %w[year month day hour minute second].freeze

  attr_reader :date_str, :invalid_formats

  def initialize(date, format)
    @date = date
    @format_arr = format ? format.split(',') : []
    @valid_params = []
    @invalid_formats = []
    start_formatter
  end  

  def valid?
    @invalid_formats.empty?
  end

  private

  def start_formatter
    @format_arr.each do |format|
      if DATE_TIME_FORMAT.include? format
        @valid_params << @date.send(format)
      else
        @invalid_formats << format
      end
    end

    @date_str = @valid_params.join('-')
  end

end
