require_relative "../lib/command"

begin
  cmd = Command.execute(Dir.getwd, ENV, ARGV, $stdin, $stdout, $stderr)
  exit cmd.status

rescue Command::Unknown => error
  $stderr.puts "jit: #{ error.message }"
  exit 1

rescue => error
  $stderr.puts "fatal: #{ error.message }"
  if ENV["DEBUG"]
    error.backtrace.each do |line|
      $stderr.puts "        from #{ line }"
    end
  end
  exit 1
end
