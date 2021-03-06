$LOAD_PATH.unshift File.expand_path('../', __FILE__)
require 'spec_helper'

require 'builder'
require 'builder/builder_log_device'
require 'fileutils'

describe '.new' do

    before(:each) do
        @base_fixture_dir_path = File.expand_path('../../fixtures', __FILE__)
        @output_dir_path = File.expand_path('../../tmp', __FILE__)
        Dir.mkdir(@output_dir_path) if not FileTest.exist?(@output_dir_path)
    end

    after(:each) do
        FileUtils.rm_rf(@output_dir_path) if FileTest.exist?(@output_dir_path)
    end

    it 'has a version number' do
        expect(Builder::VERSION).not_to be nil
    end

    it 'initializes builder' do
        fixture_dir = File.join(@base_fixture_dir_path, 'app01')

        # create repository file
        fixture_repository_file_path =
            File.expand_path('preview_target_repository', fixture_dir)
        tmp_repository_file_path =
            File.expand_path('preview_target_repository', @output_dir_path)
        File.copy_stream(fixture_repository_file_path, tmp_repository_file_path)

        # create base_domain file
        fixture_base_domain_file_path =
            File.expand_path('base_domain', fixture_dir)
        tmp_base_domain_file_path =
            File.expand_path('base_domain', @output_dir_path)
        File.copy_stream(fixture_base_domain_file_path,
                         tmp_base_domain_file_path)

        # execute
        Builder::Builder.new(mock_res, 'master', @output_dir_path)
    end
end
