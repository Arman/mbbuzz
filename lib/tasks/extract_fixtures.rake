namespace :db do
  namespace :fixtures do
    desc "Create YAML test fixtures from data in an existing database.  " +
    " Defaults to development database.  Set RAILS_ENV to override. " +
    "\nSet OUTPUT_DIR to specify an output directory. Defaults to test/fixtures. " +
    "\nSet TABLES (a coma separated list of table names) to specify which tables to extract. " +
    "Leaving it blank will extract all tables."
    task :extract => :environment do
      sql  = "SELECT * FROM %s"
      skip_tables = ["schema_info"]
      ActiveRecord::Base.establish_connection
      if (not ENV['TABLES'])
        tables = ActiveRecord::Base.connection.tables - skip_tables
      else
        tables = ENV['TABLES'].split(/, */)
      end
      if (not ENV['OUTPUT_DIR'])
        output_dir="#{RAILS_ROOT}/test/fixtures"
      else
        output_dir = ENV['OUTPUT_DIR'].sub(/\/$/, '')
      end
      (tables).each do |table_name|
        i = "000"
        File.open("#{output_dir}/#{table_name}.yml", 'w') do |file|
          data = ActiveRecord::Base.connection.select_all(sql % table_name)
          file.write data.inject({}) { |hash, record|
            hash["#{table_name}_#{i.succ!}"] = record
            hash
          }.to_yaml
        puts "wrote #{table_name} to #{output_dir}/"
        end
      end
    end
  end
end
