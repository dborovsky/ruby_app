class LogParser
  def initialize(file_name)
    @file_name = file_name
  end

  def parse
    # format of regex: "/endpoint ip_address"
    logs_regex = %r{^/.*\s\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}}
    result_parse = []
    webserver_logs = File.readlines @file_name

    webserver_logs.each do |log|
      parser = log.scan(logs_regex)[0].split(' ')

      # If can't parse the log line for any reason.
      if log.scan(logs_regex)[0].nil?
        puts "Can't parse: #{log}\n\n"
        next
      end

      parse =
        {
          :webpage => parser[0],
          :ip  => parser[1]
        }
      result_parse << parse
    end

    result_parse
  end

  def call
    result_parse = parse

    puts 'More viewed pages:'
    pp most_page_views(result_parse).join(' ')

    puts 'Unique pages view:'
    pp uniq_page_views(result_parse).join(' ')
  end

  def most_page_views(result_parse)
    result_parse.group_by { |h| h[:webpage] }
      .transform_values { |values| values.count }
      .sort_by {|k,v| v}
      .reverse
  end

  def uniq_page_views(result_parse)
    result_parse.group_by { |h| h[:webpage] }
      .transform_values { |values| values.uniq }
      .transform_values { |values| values.count }
      .sort_by {|k,v| v}
      .reverse
  end
end
