class Jig < Formula
  desc "Jq-compatible JSON processor with humane errors"
  homepage "https://github.com/emmett-lathrop-brown/jig"
  url "https://github.com/emmett-lathrop-brown/jig/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "b33cf65517bc3e1adda8b20ff08947b3724f61d3bba48ac0c05c7b9e97291440"
  license "MIT"
  head "https://github.com/emmett-lathrop-brown/jig.git", branch: "main"

  depends_on macos: :ventura

  def install
    system "./build.sh"
    bin.install "bin/jig"
  end

  def caveats
    <<~EOS
      jig runs jq filters with source-span diagnostics and hints:

        curl -s https://api.example.com/users | jig '.[] | .name'

      Compatibility policy and the supported filter subset:
        #{homepage}/blob/main/docs/jq-compat.md
    EOS
  end

  test do
    assert_match(/jig/, shell_output("#{bin}/jig --version"))
    assert_equal "1", pipe_output("#{bin}/jig -c .a", '{"a":1}').strip
  end
end
