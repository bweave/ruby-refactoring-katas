# frozen_string_literal: true

require "rake/testtask"

# TODO: this glob is scoped to NN_*/ kata directories so vendored gems under
# vendor/bundle/ aren't pulled in. Once gems live somewhere FileList can't
# reach (e.g. .bundle/config sets BUNDLE_PATH outside the project tree, or the
# vendor/ directory is otherwise excluded), this can revert to "**/*_test.rb".
Rake::TestTask.new do |t|
  t.test_files = FileList["[0-9][0-9]_*/**/*_test.rb"]
end

task :default do
  Rake::Task[:test].invoke
rescue RuntimeError
  exit 1
end

rule(/\.rb:\d+$/) do |task|
  file, line = task.name.split(":")
  line = line.to_i

  test_name = nil
  File.readlines(file).each_with_index do |content, index|
    test_name = content.strip.match(/^def (test_\w+)/)[1] if content.match?(/^\s*def test_/)
    break if index + 1 >= line
  end

  abort "No test found at #{task.name}" unless test_name

  sh "bundle exec ruby #{file} -n #{test_name}"
end
