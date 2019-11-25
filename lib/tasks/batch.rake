require "dcf"

namespace :batch do

  desc "Indexes Packages Daily"
  task package_indexer_daily_job: :environment do

  end

  desc "Indexes Packages Hourly"
  task package_indexer_hourly_job: :environment do
    puts "Job started"
    packages = PackagesFetcher.new.fetch
    puts "Packages: #{packages.size}"
    package_details_map = {}
    packages.each_with_index do |p, i|
      puts "package##{i+1}: #{p}"
      description = PackageDescriptionFetcher.new.fetch(p)
      puts "description##{i+1}: #{description}"
      PackageDetailsPersister.new.persist description
    end
  end

end
