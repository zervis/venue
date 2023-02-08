defmodule Venue.Avatar do
  use Waffle.Definition
  use Waffle.Ecto.Definition

  #https://www.poeticoding.com/creating-thumbnails-of-uploaded-images-and-pdf-in-phoenix/

  # Include ecto support (requires package waffle_ecto installed):
  # use Waffle.Ecto.Definition

  @versions [:original, :thumb, :smol]

  # To add a thumbnail version:
  # @versions [:original, :thumb]

  # Override the bucket on a per definition basis:
  # def bucket do
  #   :custom_bucket_name
  # end

  # def bucket({_file, scope}) do
  #   scope.bucket || bucket()
  # end

  # Whitelist file extensions:
   def validate({file, _}) do
     file_extension = file.file_name |> Path.extname() |> String.downcase()

     case Enum.member?(~w(.jpg .jpeg .gif .png), file_extension) do
       true -> :ok
       false -> {:error, "invalid file type"}
     end
   end

  # Define a thumbnail transformation:
   def transform(:thumb, _) do
     {:convert, "-strip -thumbnail 512x512^ -gravity center -extent 512x512 -format png", :png}
   end

   def transform(:smol, _) do
    {:convert, "-strip -thumbnail 64x64^ -gravity center -extent 64x64 -format png", :png}
  end

  # Override the persisted filenames:
   def filename(version, _) do
     version
   end

  # Override the storage directory:
   def storage_dir(version, {file, scope}) do
     "/uploads/user/avatars/#{scope.id}"
   end

  # Provide a default URL if there hasn't been a file uploaded
  def default_url(version, scope) do
   "/uploads/default_#{version}.png"
  end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: MIME.from_path(file.file_name)]
  # end
end
