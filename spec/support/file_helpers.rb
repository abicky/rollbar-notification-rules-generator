module FileHelpers
  def yaml_file(name)
    File.join(__dir__, "..", "yaml", "#{name}.yaml")
  end

  def tf_file_content(name)
    File.read(File.join(__dir__, "..", "tf", "#{name}.tf"))
  end

  def text_file_content(name)
    File.read(File.join(__dir__, "..", "txt", "#{name}.txt"))
  end
end
