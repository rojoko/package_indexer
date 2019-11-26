class PackageDetailsPersister

  def persist(description)
    package = persist_package description
    return if package.nil?
    persist_authors(description, package.id)
    persist_maintainers(description, package.id)
  end

  def persist_package(details_map)
    package = Package.new
    package.name = details_map["Package"].strip
    package.version = details_map["Version"].strip
    package.title = details_map["Title"].strip
    package.description = details_map["Description"].strip
    package.publication_date = details_map["Date/Publication"]
    if package.save
      package
    else
      puts "Package not saved: #{package}"
      nil
    end
  end

  def persist_authors(details_map, package_id)
    author = details_map["Author"]
    authors = parse_contributor_details author
    authors.each do |author|
      contributor = persist_contributor author
      return if contributor.nil?
      contributor_package = ContributorsPackage.find_by(package_id: package_id, contributor_id: contributor.id, role: ContributorsPackage.roles[:author])
      return unless contributor_package.nil?
      contributor_package = ContributorsPackage.new
      contributor_package.contributor_id = contributor.id
      contributor_package.package_id = package_id
      contributor_package.role = :author
      puts "Author Package relation not saved: #{contributor_package}" unless contributor_package.save
    end
  end

  def persist_maintainers(details_map, package_id)
    maintainer = details_map["Maintainer"]
    maintainers = parse_contributor_details maintainer
    maintainers.each do |maintainer|
      contributor = persist_contributor maintainer
      return if contributor.nil?
      contributor_package = ContributorsPackage.find_by(package_id: package_id, contributor_id: contributor.id, role: ContributorsPackage.roles[:maintainer])
      return unless contributor_package.nil?
      contributor_package = ContributorsPackage.new
      contributor_package.contributor_id = contributor.id
      contributor_package.package_id = package_id
      contributor_package.role = :maintainer
      puts "Maintainer Package relation not saved: #{contributor_package}" unless contributor_package.save
    end
  end

  def persist_contributor(contributor_map)
    contributor = Contributor.find_by(email: contributor_map[:email])
    return contributor unless contributor.nil?
    contributor = Contributor.find_by(name: contributor_map[:name])
    contributor = Contributor.new if contributor.nil?
    contributor.name = contributor_map[:name]
    contributor.email = contributor_map[:email]
    if contributor.save
      contributor
    else
      puts "Contributor not saved: #{contributor}"
      nil
    end
  end

  def parse_contributor_details(contributor)
    contributor = contributor.gsub(/\[\w*,*\s*\w*\]/, "")
    contributor_details = contributor.split(",")
    contributors = []
    contributor_details.each do |cd|
      cd.strip!
      cd_arr = cd.split(" <")
      name = cd_arr[0]
      email = cd_arr[1].chop unless cd_arr[1].nil?
      contributors.push({name: name, email: email})
    end
    contributors
  end

end