class PackagesFetcher

  attr_accessor :uri, :packages

	def initialize
		self.uri = "https://cran.r-project.org/src/contrib/PACKAGES"
		self.packages = []
	end

	def fetch
		begin
			resp = RestClient.get(uri)
		rescue RestClient::Exceptions::OpenTimeout, RestClient::Exceptions::ReadTimeout, Net::OpenTimeout, Errno::ETIMEDOUT => e
			puts "Timeout (#{e}), retrying in 1 second..."
			sleep(1)
			retry
		end
		package_arr = Dcf.parse(resp.body)
		package_arr.each do |p|
			packages.push(getPackageNameVersion(p))
		end
		packages
	end

	def getPackageNameVersion(package)
		package["Package"] + "_" + package["Version"]
	end

end