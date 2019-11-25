class PackagesFetcher

  attr_accessor :uri, :packages

	def initialize
		self.uri = "https://cran.r-project.org/src/contrib/PACKAGES"
		self.packages = []
	end

	def fetch
		# puts "uri: #{uri}"
		resp = RestClient.get(uri)
		# puts "resp: #{resp.body}"
		package_arr = Dcf.parse(resp.body)
		# puts "package_arr: #{package_arr}"
		package_arr.each do |p|
			packages.push(getPackageNameVersion(p))
		end
		packages
	end

	def getPackageNameVersion(package)
		package["Package"] + "_" + package["Version"]
	end

end