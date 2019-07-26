class TimeFormatter

  DATE_TIME_FORMAT = %w[year month day hour minute second].freeze

  def initialize(date, format)
    @date = date
    @format_arr = format ? format.split(',') : []
    @valid_params = []
    @invalid_formats = []
  end

  def format
    start_formatter
  end

  def valid?
    @invalid_formats.empty?
  end

  def date_str
    @date_str
  end

  def invalid_formats
    @invalid_formats
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
