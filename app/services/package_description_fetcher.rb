require 'rubygems/package'

class PackageDescriptionFetcher

  attr_accessor :base_uri, :package_suffix, :description

	def initialize
		self.base_uri = "http://cran.r-project.org/src/contrib/"
		self.package_suffix = ".tar.gz"
		self.description = nil
	end

	def fetch(package_name_version)
		begin
			raw = RestClient::Request.execute(method: :get, url: base_uri + package_name_version + package_suffix, raw_response: true)
		rescue RestClient::Exceptions::OpenTimeout, RestClient::Exceptions::ReadTimeout, Net::OpenTimeout, Errno::ETIMEDOUT => e
			puts "Timeout (#{e}), retrying in 1 second..."
			sleep(1)
			retry
		end
		if raw.file.size > 0
			self.description = extract_description(raw.file)
		end
		description
	end

	def extract_description(file)
		tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open(file.path))
		tar_extract.rewind
		desc = nil
		tar_extract.each do |entry|
			desc = Dcf.parse(entry.read)[0] if entry.file? && entry.full_name.split("/")[-1] == "DESCRIPTION"
		end
		tar_extract.close
		desc
	end

end