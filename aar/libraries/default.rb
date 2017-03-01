
module AARHelpers
  def install_complete_marker_file_present?
    File.exist?('/site/aar/install_complete_marker_file')
  end
end
