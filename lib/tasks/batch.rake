require "dcf"

namespace :batch do

  desc "Indexes Packages Daily"
  task package_indexer_daily_job: :environment do
    puts "Job started"
    packages = PackagesFetcher.new.fetch
    puts "Packages: #{packages.size}"
    packages.each_with_index do |p, i|
      puts "package##{i+1}: #{p}"
      name_version = p.split("_")
      package = Package.find_by(name: name_version[0], version: name_version[1])
      unless package.nil?
        puts "Package already indexed. Moving on to next"
        next
      end
      description = PackageDescriptionFetcher.new.fetch(p)
      puts "description##{i+1}: #{description}"
      PackageDetailsPersister.new.persist description
    end
  end

end
