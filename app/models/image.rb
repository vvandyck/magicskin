class Image < ActiveRecord::Base
  belongs_to :skin

  RELATIVE_IMAGE_PATH = "/images"
  ABSOLUTE_IMAGE_PATH ="#{RAILS_ROOT}/public#{RELATIVE_IMAGE_PATH}"

  def file= (f)
    logger.debug "setting image"
    @file = f
  end


  def validate

    # @file should contain file uploaded by HTTP
    # it is either StringIO object (if file was smaller than 10Kb)
    # or Tempfile (otherwise)
    if not (@file.kind_of? StringIO or @file.kind_of? Tempfile)
      errors.add_to_base("No file selected")
      return
    end
    # We can't use StringIO data to call external programs
    # So, if object is StringIO -- we have to create Tempfile
    # Unfortunatly, in Rails it is impossible to force all uploads to be Tempfiles
    if @file.kind_of? StringIO
      # Yes, if @file is StringIO, create new Tempfile and copy everything to it
      @real_file = Tempfile.new("tmp_images")
      while not @file.eof?
        @real_file.write @file.read
      end
    else
      # Most uploads will be Tempfiles
      @real_file = @file
    end
    self.name = rand(9999).to_s + @file.original_filename
  end

  def after_save
    dest_photo   = "#{ABSOLUTE_IMAGE_PATH}/#{self.name}"


    # Copying Tempfile to our storage,
    # which is a subdirectory 'photo/f' in 'public'
    # directory of Rails project
    FileUtils.cp(@real_file.path, dest_photo);

    # Setting right permissions
    FileUtils.chmod 0644, dest_photo

  end

end
